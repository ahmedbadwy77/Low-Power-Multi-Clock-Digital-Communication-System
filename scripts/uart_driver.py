#!/usr/bin/env python3
"""
================================================================================
Host UART Driver & Communication Protocol Client
Project: Low-Power Multi-Clock Digital Communication System
Author: Ahmed Badawy
================================================================================
This script acts as the external host controller communicating with the SoC
over UART. It implements frame assembly, serial transmission, and response
decoding for all supported commands:
  - Command 0xAA: Register File Write (3 frames)
  - Command 0xBB: Register File Read (2 frames TX, 1 frame RX)
  - Command 0xCC: ALU Operation with Operands (4 frames TX, 2 frames RX)
  - Command 0xDD: ALU Operation without Operands (2 frames TX, 2 frames RX)

Supports both real physical COM ports (via PySerial) and built-in Mock/Simulation
mode to demonstrate protocol compliance offline.
================================================================================
"""

import sys
import time
import argparse
from typing import Optional, Tuple

try:
    import serial
    HAS_PYSERIAL = True
except ImportError:
    HAS_PYSERIAL = False

# ==============================================================================
# Protocol Definitions & Opcode Constants
# ==============================================================================
CMD_RF_WRITE   = 0xAA
CMD_RF_READ    = 0xBB
CMD_ALU_W_OP   = 0xCC
CMD_ALU_NO_OP  = 0xDD

ALU_OPERATIONS = {
    "add":   0x0,  # A + B
    "sub":   0x1,  # A - B
    "mul":   0x2,  # A * B
    "div":   0x3,  # A / B
    "and":   0x4,  # A & B
    "or":    0x5,  # A | B
    "nand":  0x6,  # ~(A & B)
    "nor":   0x7,  # ~(A | B)
    "xor":   0x8,  # A ^ B
    "xnor":  0x9,  # ~(A ^ B)
    "eq":    0xA,  # (A == B) ? 1 : 0
    "gt":    0xB,  # (A > B)  ? 2 : 0
    "shr":   0xC,  # A >> 1
    "shl":   0xD,  # A << 1
}


class MockHardwareDevice:
    """Simulates the Verilog hardware behavior for offline demonstrations."""

    def __init__(self):
        self.registers = [0x00] * 16
        self.registers[2] = 0x81  # Default Prescale = 32, Parity = Enabled (Even)
        self.registers[3] = 0x20  # Default Div Ratio = 32
        self.alu_out = 0

    def process_command(self, cmd_bytes: bytes) -> bytes:
        if not cmd_bytes:
            return b""

        cmd_id = cmd_bytes[0]

        # 0xAA: RF Write [0xAA, Addr, Data]
        if cmd_id == CMD_RF_WRITE:
            if len(cmd_bytes) >= 3:
                addr = cmd_bytes[1] & 0x0F
                data = cmd_bytes[2] & 0xFF
                self.registers[addr] = data
                return b""

        # 0xBB: RF Read [0xBB, Addr] -> Returns [Data]
        elif cmd_id == CMD_RF_READ:
            if len(cmd_bytes) >= 2:
                addr = cmd_bytes[1] & 0x0F
                val = self.registers[addr] & 0xFF
                return bytes([val])

        # 0xCC: ALU with Operands [0xCC, OpA, OpB, Fun] -> Returns [LSB, MSB]
        elif cmd_id == CMD_ALU_W_OP:
            if len(cmd_bytes) >= 4:
                op_a = cmd_bytes[1] & 0xFF
                op_b = cmd_bytes[2] & 0xFF
                fun  = cmd_bytes[3] & 0x0F
                self.registers[0] = op_a
                self.registers[1] = op_b
                res = self._compute_alu(op_a, op_b, fun)
                return bytes([res & 0xFF, (res >> 8) & 0xFF])

        # 0xDD: ALU without Operands [0xDD, Fun] -> Returns [LSB, MSB]
        elif cmd_id == CMD_ALU_NO_OP:
            if len(cmd_bytes) >= 2:
                fun  = cmd_bytes[1] & 0x0F
                op_a = self.registers[0]
                op_b = self.registers[1]
                res = self._compute_alu(op_a, op_b, fun)
                return bytes([res & 0xFF, (res >> 8) & 0xFF])

        return b""

    def _compute_alu(self, a: int, b: int, fun: int) -> int:
        if fun == 0x0: return (a + b) & 0xFFFF
        if fun == 0x1: return (a - b) & 0xFFFF
        if fun == 0x2: return (a * b) & 0xFFFF
        if fun == 0x3: return (a // b if b != 0 else 0) & 0xFFFF
        if fun == 0x4: return (a & b) & 0xFFFF
        if fun == 0x5: return (a | b) & 0xFFFF
        if fun == 0x6: return (~(a & b)) & 0xFF
        if fun == 0x7: return (~(a | b)) & 0xFF
        if fun == 0x8: return (a ^ b) & 0xFFFF
        if fun == 0x9: return (~(a ^ b)) & 0xFF
        if fun == 0xA: return 1 if a == b else 0
        if fun == 0xB: return 2 if a > b else 0
        if fun == 0xC: return (a >> 1) & 0xFFFF
        if fun == 0xD: return ((a << 1) & 0xFF)
        return 0


class SoCProtocolDriver:
    """Master communication driver for the Digital Communication Subsystem."""

    def __init__(self, port: Optional[str] = None, baudrate: int = 115200, mock: bool = False):
        self.mock_mode = mock or (port is None)
        self.ser = None
        self.mock_device = MockHardwareDevice() if self.mock_mode else None

        if not self.mock_mode:
            if not HAS_PYSERIAL:
                raise RuntimeError("pyserial is required for physical COM ports. Install with: pip install pyserial")
            self.ser = serial.Serial(
                port=port,
                baudrate=baudrate,
                bytesize=serial.EIGHTBITS,
                parity=serial.PARITY_EVEN,
                stopbits=serial.STOPBITS_ONE,
                timeout=1.0
            )

    def write_register(self, address: int, data: int) -> None:
        """Command 0xAA: Write an 8-bit value into a register."""
        frame = bytes([CMD_RF_WRITE, address & 0x0F, data & 0xFF])
        print(f"[TX] RF Write -> Addr: 0x{address:X}, Data: 0x{data:02X} (Raw: {frame.hex(' ').upper()})")
        self._transmit(frame)
        time.sleep(0.01)

    def read_register(self, address: int) -> int:
        """Command 0xBB: Read an 8-bit value from a register."""
        frame = bytes([CMD_RF_READ, address & 0x0F])
        print(f"[TX] RF Read  -> Addr: 0x{address:X} (Raw: {frame.hex(' ').upper()})")
        self._transmit(frame)
        rx = self._receive(1)
        if len(rx) < 1:
            raise TimeoutError(f"No response received for RF Read from Addr 0x{address:X}")
        val = rx[0]
        print(f"[RX] RF Data  <- Addr 0x{address:X} = 0x{val:02X} ({val})")
        return val

    def alu_operation_with_operands(self, op_a: int, op_b: int, fun_code: int) -> int:
        """Command 0xCC: Load operands, compute ALU result, and read back 16-bit word."""
        frame = bytes([CMD_ALU_W_OP, op_a & 0xFF, op_b & 0xFF, fun_code & 0x0F])
        print(f"[TX] ALU W/Op -> A: 0x{op_a:02X}, B: 0x{op_b:02X}, FUN: 0x{fun_code:X} (Raw: {frame.hex(' ').upper()})")
        self._transmit(frame)
        rx = self._receive(2)
        if len(rx) < 2:
            raise TimeoutError("Timeout waiting for 16-bit ALU response")
        result = rx[0] | (rx[1] << 8)
        print(f"[RX] ALU OUT  <- Result = 0x{result:04X} ({result}) [LSB: 0x{rx[0]:02X}, MSB: 0x{rx[1]:02X}]")
        return result

    def alu_operation_no_operands(self, fun_code: int) -> int:
        """Command 0xDD: Execute ALU operation with cached operands."""
        frame = bytes([CMD_ALU_NO_OP, fun_code & 0x0F])
        print(f"[TX] ALU NoOp -> FUN: 0x{fun_code:X} (Raw: {frame.hex(' ').upper()})")
        self._transmit(frame)
        rx = self._receive(2)
        if len(rx) < 2:
            raise TimeoutError("Timeout waiting for 16-bit ALU response")
        result = rx[0] | (rx[1] << 8)
        print(f"[RX] ALU OUT  <- Result = 0x{result:04X} ({result}) [LSB: 0x{rx[0]:02X}, MSB: 0x{rx[1]:02X}]")
        return result

    def _transmit(self, data: bytes) -> None:
        if self.mock_mode:
            self._mock_response = self.mock_device.process_command(data)
        else:
            self.ser.write(data)
            self.ser.flush()

    def _receive(self, count: int) -> bytes:
        if self.mock_mode:
            resp = getattr(self, "_mock_response", b"")
            return resp[:count]
        else:
            return self.ser.read(count)

    def close(self):
        if self.ser and self.ser.is_open:
            self.ser.close()


def run_automated_demo(driver: SoCProtocolDriver):
    """Executes an automated regression suite identical to the ModelSim testbench."""
    print("\n========================================================")
    print("      RUNNING HARDWARE VERIFICATION REGRESSION SUITE")
    print("========================================================\n")

    # 1. Register File Configuration & General Purpose R/W
    print("--- 1. Testing Register File Read/Write Operations ---")
    driver.write_register(0x4, 0xA5)
    val4 = driver.read_register(0x4)
    assert val4 == 0xA5, f"Mismatch at REG[4]: expected 0xA5, got 0x{val4:02X}"

    driver.write_register(0x5, 0x5A)
    val5 = driver.read_register(0x5)
    assert val5 == 0x5A, f"Mismatch at REG[5]: expected 0x5A, got 0x{val5:02X}"

    # 2. ALU Operations with Operands (Command 0xCC)
    print("\n--- 2. Testing ALU Operations with Operands (0xCC) ---")
    # Addition: 15 + 25 = 40
    res_add = driver.alu_operation_with_operands(15, 25, ALU_OPERATIONS["add"])
    assert res_add == 40, f"Add failed: expected 40, got {res_add}"

    # Multiplication: 12 * 11 = 132
    res_mul = driver.alu_operation_with_operands(12, 11, ALU_OPERATIONS["mul"])
    assert res_mul == 132, f"Mul failed: expected 132, got {res_mul}"

    # Division: 100 / 4 = 25
    res_div = driver.alu_operation_with_operands(100, 4, ALU_OPERATIONS["div"])
    assert res_div == 25, f"Div failed: expected 25, got {res_div}"

    # Bitwise XOR: 0xFF ^ 0xAA = 0x55
    res_xor = driver.alu_operation_with_operands(0xFF, 0xAA, ALU_OPERATIONS["xor"])
    assert res_xor == 0x55, f"XOR failed: expected 0x55, got 0x{res_xor:02X}"

    # 3. ALU Operations without Operands (Command 0xDD)
    print("\n--- 3. Testing ALU Operations with Cached Operands (0xDD) ---")
    # Cached operands are 0xFF (Op A) and 0xAA (Op B)
    # Bitwise AND: 0xFF & 0xAA = 0xAA
    res_and = driver.alu_operation_no_operands(ALU_OPERATIONS["and"])
    assert res_and == 0xAA, f"Cached AND failed: expected 0xAA, got 0x{res_and:02X}"

    print("\n========================================================")
    print("      ALL HARDWARE PROTOCOL CHECKS PASSED (100%)        ")
    print("========================================================\n")


def main():
    parser = argparse.ArgumentParser(description="Host UART Communication Driver for Digital SoC")
    parser.add_argument("--port", type=str, default=None, help="Serial COM port (e.g. COM3 or /dev/ttyUSB0)")
    parser.add_argument("--baud", type=int, default=115200, help="Baud rate (default: 115200)")
    parser.add_argument("--demo", action="store_true", help="Run automated protocol regression test")
    parser.add_argument("--mock", action="store_true", help="Force mock/offline simulation mode")

    args = parser.parse_args()

    mode_name = "MOCK / HARDWARE SIMULATION" if (args.mock or args.port is None) else f"PHYSICAL PORT ({args.port})"
    print(f"[*] Initializing SoC UART Driver in {mode_name} mode...")

    driver = SoCProtocolDriver(port=args.port, baudrate=args.baud, mock=args.mock)

    try:
        if args.demo or (args.port is None and not args.mock):
            run_automated_demo(driver)
        else:
            print("[*] Ready. Example interactive session:")
            driver.write_register(0x4, 0xBE)
            driver.read_register(0x4)
            driver.alu_operation_with_operands(50, 25, ALU_OPERATIONS["sub"])
    finally:
        driver.close()


if __name__ == "__main__":
    main()
