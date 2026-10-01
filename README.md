# Low-Power Multi-Clock Digital Communication System & ASIC Implementation Flow

[![CI](https://github.com/ahmedbadwy77/Low-Power-Multi-Clock-Digital-Communication-System/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/ahmedbadwy77/Low-Power-Multi-Clock-Digital-Communication-System/actions/workflows/ci.yml)
[![HDL](https://img.shields.io/badge/HDL-Verilog%20%7C%20SystemVerilog-blue.svg)](rtl/)
[![PDK](https://img.shields.io/badge/PDK-TSMC%20130nm-orange.svg)](IC/Projects/System/std_cells/)
[![Synthesis](https://img.shields.io/badge/Synthesis-Synopsys%20Design%20Compiler-red.svg)](IC/Projects/System/Synthesis/)
[![DFT Coverage](https://img.shields.io/badge/DFT%20Coverage-99.66%25-brightgreen.svg)](IC/Projects/System/DFT/)
[![Formality](https://img.shields.io/badge/Equivalence-100%25%20Verified-success.svg)](IC/Projects/System/Formality/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

An industrial-grade, multi-clock domain System-on-Chip (SoC) communication subsystem designed in synthesizable **Verilog / SystemVerilog** and verified through a complete **ASIC backend flow** using Synopsys and SpyGlass EDA tools under the **TSMC 130nm CMOS** technology library.

The system features full-duplex configurable **UART communication**, **dual-clock asynchronous synchronization**, a 16-word dual-clock **Asynchronous FIFO**, dynamic **clock dividers**, an **Integrated Clock Gating (ICG)** cell for ultra-low dynamic power, a 16-register **Register File**, and a high-performance 16-bit **Arithmetic Logic Unit (ALU)**.

---

## Table of Contents
- [1. System Architecture Overview](#1-system-architecture-overview)
- [2. Top-Level Ports & Interface](#2-top-level-ports--interface)
- [3. Communication Protocol & Frame Formats](#3-communication-protocol--frame-formats)
- [4. Detailed Hardware Module Descriptions](#4-detailed-hardware-module-descriptions)
  - [4.1 System Controller (SYS_CTRL)](#41-system-controller-sys_ctrl)
  - [4.2 Register File (regfile)](#42-register-file-regfile)
  - [4.3 Arithmetic Logic Unit (ALU)](#43-arithmetic-logic-unit-alu)
  - [4.4 Integrated Clock Gating (CLK_GATE)](#44-integrated-clock-gating-clk_gate)
  - [4.5 UART Transmitter (UART_TX)](#45-uart-transmitter-uart_tx)
  - [4.6 UART Receiver (UART_RX)](#46-uart-receiver-uart_rx)
  - [4.7 Asynchronous FIFO (ASYNC_FIFO)](#47-asynchronous-fifo-async_fifo)
  - [4.8 Multi-Bit Data Synchronizer (DATA_SYNC)](#48-multi-bit-data-synchronizer-data_sync)
  - [4.9 Reset Synchronizer (RST_SYNC)](#49-reset-synchronizer-rst_sync)
  - [4.10 Clock Dividers & Prescaler MUX](#410-clock-dividers--prescaler-mux)
  - [4.11 Pulse Generator (Pulse_Gen)](#411-pulse-generator-pulse_gen)
- [5. Verification & Waveforms](#5-verification--waveforms)
- [6. ASIC Implementation Flow & Results](#6-asic-implementation-flow--results)
  - [6.1 Logic Synthesis (Synopsys DC)](#61-logic-synthesis-synopsys-dc)
  - [6.2 Design for Testability (DFT Compiler)](#62-design-for-testability-dft-compiler)
  - [6.3 Formal Verification (Synopsys Formality)](#63-formal-verification-synopsys-formality)
  - [6.4 Lint & CDC Sign-off (SpyGlass)](#64-lint--cdc-sign-off-spyglass)
- [7. Directory Structure](#7-directory-structure)
- [8. How to Run Simulation & Verification](#8-how-to-run-simulation--verification)

---

## 1. System Architecture Overview

The system operates across **two distinct asynchronous clock domains** connected through robust Clock Domain Crossing (CDC) synchronization structures:
1. **Reference Clock Domain (`REF_CLK` @ 50 MHz)**: High-speed processing domain hosting the master System Controller FSM, the Register File, the Integrated Clock Gating latch, and the 16-bit ALU.
2. **UART Clock Domain (`UART_CLK` @ 3.6864 MHz)**: Low-speed serial communication domain hosting the UART transmitter, UART receiver, clock division logic, and FIFO pop-pulse generation.

```mermaid
flowchart TB
    subgraph UART_Domain["UART Clock Domain (UART_CLK = 3.6864 MHz)"]
        RX_IN[RX_IN] --> UART_RX[UART Receiver]
        UART_TX[UART Transmitter] --> TX_OUT[TX_OUT]
        RX_CLK_DIV[RX Clock Divider] --> UART_RX
        TX_CLK_DIV[TX Clock Divider] --> UART_TX
        UART_RST_SYNC[Reset Synchronizer 2] --> UART_RX & UART_TX
        UART_TX -- "Busy" --> PULSE_GEN[Pulse Generator]
    end

    subgraph CDC_Interface["Clock Domain Crossing (CDC)"]
        UART_RX -- "8-bit RX Data + Vld" --> DATA_SYNC[Multi-bit Data Synchronizer]
        ASYNC_FIFO[Dual-Clock Asynchronous FIFO 8x16] -- "Read Data" --> UART_TX
        PULSE_GEN -- "R_INC Pulse" --> ASYNC_FIFO
    end

    subgraph REF_Domain["Reference Clock Domain (REF_CLK = 50 MHz)"]
        REF_RST_SYNC[Reset Synchronizer 1] --> SYS_CTRL & REGFILE & ALU
        DATA_SYNC -- "Sync Bus + Pulse" --> SYS_CTRL[System Controller FSM]
        SYS_CTRL -- "Addr, WrData, WrEn, RdEn" --> REGFILE[Register File 16x8]
        SYS_CTRL -- "ALU_EN, ALU_FUN" --> ALU[16-bit ALU]
        SYS_CTRL -- "CLK_EN" --> CLK_GATE[Integrated Clock Gating]
        CLK_GATE -- "GATED_CLK" --> ALU
        REGFILE -- "REG0 (Op A), REG1 (Op B)" --> ALU
        SYS_CTRL -- "WrData + WrEn" --> ASYNC_FIFO
        ALU -- "ALU_OUT [15:0]" --> SYS_CTRL
        REGFILE -- "RdData" --> SYS_CTRL
        REGFILE -- "REG2 (Prescale/Parity)" --> UART_RX & UART_TX & RX_CLK_DIV
        REGFILE -- "REG3 (Div Ratio)" --> TX_CLK_DIV
    end
```

---

## 2. Top-Level Ports & Interface

| Port Name | Direction | Width | Clock Domain | Description |
| :--- | :---: | :---: | :---: | :--- |
| `REF_CLK` | Input | 1-bit | REF_CLK | Reference high-speed system clock (50 MHz) |
| `UART_CLK` | Input | 1-bit | UART_CLK | Asynchronous UART baud generation clock (3.6864 MHz) |
| `RST` | Input | 1-bit | Asynchronous | Master active-low asynchronous reset |
| `RX_IN` | Input | 1-bit | UART_CLK | Serial UART input stream |
| `TX_OUT` | Output | 1-bit | UART_CLK | Serial UART output stream |
| `parity_error` | Output | 1-bit | UART_CLK | Asserted high when a received frame parity check fails |
| `framing_error`| Output | 1-bit | UART_CLK | Asserted high when a received frame stop bit is invalid |

---

## 3. Communication Protocol & Frame Formats

### 3.1 UART Frame Structure
Every UART communication frame transmitted or received consists of 10 or 11 serial bits:
* **Start Bit**: 1-bit logic `0`.
* **Data Bits**: 8-bit payload transmitted **LSB first**.
* **Parity Bit (Optional)**: 1-bit parity (Even or Odd), dynamically configured via `REG2[0]` (Enable) and `REG2[1]` (Type).
* **Stop Bit**: 1-bit logic `1`.

```
Idle (1) ──┐        ┌──────┬──────┬──────┬──────┬──────┬──────┬──────┬──────┐ ┌────────┐ ┌─── Idle (1)
           └────────┴──────┴──────┴──────┴──────┴──────┴──────┴──────┴──────┴─┴────────┴─┘
            Start    Bit 0  Bit 1  Bit 2  Bit 3  Bit 4  Bit 5  Bit 6  Bit 7   Parity   Stop
             (0)     (LSB)                                            (MSB)  (Opt)    (1)
```

### 3.2 Baud Rate & Oversampling Calculation
The serial communication baud rate is determined by dividing `UART_CLK`:

$$\text{TX Baud Rate} = \frac{f_{\text{UART-CLK}}}{\text{Div Ratio (REG3)}} = \frac{3.6864\text{ MHz}}{32} = 115,200\text{ Baud}$$

For the receiver, oversampling ensures robust data recovery in noisy environments:

$$\text{RX Sampling Clock} = \frac{f_{\text{UART-CLK}}}{\text{Prescale Mux Ratio}} = 115,200 \times \text{Prescale}$$

### 3.3 Master Command Protocol
The external host controls the system by sending multi-frame commands over UART:

#### Command 1: Register File Write (`0xAA`) — 3 Frames
Enables the host to write configuration parameters or data into any register.
```
Frame 0: [ 0xAA ] (RF Write Command ID)
Frame 1: [ Address (0x0 to 0xF) ]
Frame 2: [ Write Data (8-bit) ]
```

#### Command 2: Register File Read (`0xBB`) — 2 Frames
Reads data from an addressed register; the system returns 1 frame over `TX_OUT`.
```
Command:
Frame 0: [ 0xBB ] (RF Read Command ID)
Frame 1: [ Address (0x0 to 0xF) ]

System Response:
Frame 0: [ Read Data (8-bit) ]
```

#### Command 3: ALU Operation with Operands (`0xCC`) — 4 Frames
Updates operands in `REG0` and `REG1`, triggers the ALU, and transmits the 16-bit result back in 2 frames.
```
Command:
Frame 0: [ 0xCC ] (ALU with Operands Command ID)
Frame 1: [ Operand A (written to REG0) ]
Frame 2: [ Operand B (written to REG1) ]
Frame 3: [ ALU Function Code (ALU_FUN [3:0]) ]

System Response:
Frame 0: [ ALU_OUT[7:0]  (Least Significant Byte) ]
Frame 1: [ ALU_OUT[15:8] (Most Significant Byte)  ]
```

#### Command 4: ALU Operation with No Operands (`0xDD`) — 2 Frames
Executes an ALU function using the operands already stored in `REG0` and `REG1`.
```
Command:
Frame 0: [ 0xDD ] (ALU without Operands Command ID)
Frame 1: [ ALU Function Code (ALU_FUN [3:0]) ]

System Response:
Frame 0: [ ALU_OUT[7:0]  (Least Significant Byte) ]
Frame 1: [ ALU_OUT[15:8] (Most Significant Byte)  ]
```

---

## 4. Detailed Hardware Module Descriptions

### 4.1 System Controller (`SYS_CTRL`)
The **System Controller** is the master finite state machine (FSM) operating in the `REF_CLK` domain. It samples synchronized UART command frames, decodes opcodes, coordinates reads/writes to the Register File, asserts clock gating to the ALU, initiates ALU operations, and writes outgoing responses to the Asynchronous FIFO.

```mermaid
flowchart LR
    subgraph Inputs["Control & Data Inputs"]
        sync_bus["sync_bus [7:0]"]
        enable_pulse["enable_pulse"]
        Rd_D["Rd_D [7:0] & Rd_D_Vld"]
        ALU_OUT["ALU_OUT [15:0] & out_valid"]
        FIFO_FULL["FIFO_FULL"]
        clk_rst["clk (REF_CLK) & rst"]
    end

    subgraph SYS_CTRL_CORE["SYS_CTRL Module Core"]
        DEC["Command & Address Latch<br/>(0xAA, 0xBB, 0xCC, 0xDD)"]
        FSM["10-State Master Controller FSM"]
        OUT_GEN["Output Multiplexer &<br/>Handshake Generator"]
        DEC --> FSM
        FSM --> OUT_GEN
    end

    subgraph Outputs["Subsystem Interfaces"]
        subgraph to_rf["To Register File"]
            RF_BUS["Addr [3:0]<br/>Wr_D [7:0]<br/>WrEn, RdEn"]
        end
        subgraph to_alu["To 16-bit ALU"]
            ALU_BUS["FUN [3:0]<br/>en (ALU_EN)"]
        end
        subgraph to_cg["To Clock Gate"]
            CG_BUS["Gate_EN (CLK_EN)"]
        end
        subgraph to_fifo["To Async FIFO"]
            FIFO_BUS["WR_DATA [7:0]<br/>WR_INC (Push Pulse)"]
        end
        subgraph to_clkdiv["To Clock Dividers"]
            DIV_BUS["clk_div_en"]
        end
    end

    sync_bus & enable_pulse --> DEC
    Rd_D & ALU_OUT & FIFO_FULL --> FSM
    clk_rst --> FSM
    OUT_GEN --> RF_BUS & ALU_BUS & CG_BUS & FIFO_BUS & DIV_BUS
```

```mermaid
stateDiagram-v2
    direction TB
    [*] --> IDLE
    IDLE --> CMD_DECODE: RX_D_VLD == 1
    
    state CMD_DECODE <<choice>>
    CMD_DECODE --> RF_WR_ADDR: CMD == 0xAA (RF Write)
    CMD_DECODE --> RF_RD_ADDR: CMD == 0xBB (RF Read)
    CMD_DECODE --> ALU_OP_A: CMD == 0xCC (ALU with Op)
    CMD_DECODE --> ALU_FUN_OP: CMD == 0xDD (ALU no Op)
    
    RF_WR_ADDR --> RF_WR_DATA: RX_D_VLD == 1 (Latch Addr)
    RF_WR_DATA --> IDLE: Latch Data & Assert WrEn
    
    RF_RD_ADDR --> WAIT_RD: Assert RdEn
    WAIT_RD --> FIFO_WR_RD: RdData_Valid == 1
    FIFO_WR_RD --> IDLE: Push to FIFO (WR_INC)
    
    ALU_OP_A --> ALU_OP_B: RX_D_VLD == 1 (Store Op A)
    ALU_OP_B --> ALU_FUN_OP: RX_D_VLD == 1 (Store Op B)
    ALU_FUN_OP --> ALU_WAIT: Assert ALU_EN & CLK_EN
    ALU_WAIT --> FIFO_WR_P1: OUT_VALID == 1 (Push LSB)
    FIFO_WR_P1 --> FIFO_WR_P2: Push MSB
    FIFO_WR_P2 --> IDLE: Computation Complete
```

* **Key FSM States**: `IDLE`, `RF_ADDR`, `RF_WR_DATA`, `RF_RD_DATA`, `ALU_OP_A`, `ALU_OP_B`, `ALU_FUN_OP`, `ALU_WAIT`, `FIFO_WR_P1`, `FIFO_WR_P2`.
* **Handshake Coordination**: Automatically manages `WrEn`, `RdEn`, `CLK_EN`, `ALU_EN`, and `WR_INC` to ensure collision-free internal transfers.

---

### 4.2 Register File (`regfile`)
The **Register File** contains 16 addressable 8-bit registers (REG0 through REG15). Addresses `0x0` to `0x3` are reserved for system hardware configurations and direct operand feeds, while `0x4` to `0xF` are general-purpose storage registers.

```mermaid
flowchart LR
    subgraph Inputs["Register File Inputs"]
        WrData["WrData [7:0]"]
        Address["Address [3:0]"]
        WrEn["WrEn"]
        RdEn["RdEn"]
        clk_rst["clk (REF_CLK) & rst"]
    end

    subgraph RF_Array["16 x 8-bit Register Storage Array"]
        direction TB
        REG0["REG0 (0x0): ALU Operand A [7:0]"]
        REG1["REG1 (0x1): ALU Operand B [7:0]"]
        REG2["REG2 (0x2): Prescale [7:2] | Parity [1:0]"]
        REG3["REG3 (0x3): TX Clock Div Ratio [7:0]"]
        REG_GP["REG4 - REG15: General Purpose Registers [7:0]"]
    end

    subgraph Write_Logic["Write Decode Logic"]
        W_DEC["Address Decoder &<br/>Register Write Enable"]
    end

    subgraph Read_Logic["Read Decode & Output MUX"]
        R_MUX["16-to-1 Multiplexer &<br/>Valid Flag Register"]
    end

    subgraph Outputs["External & Dedicated Ports"]
        REG0_OUT["REG0 [7:0] --> ALU (Operand A)"]
        REG1_OUT["REG1 [7:0] --> ALU (Operand B)"]
        REG2_OUT["REG2 [7:0] --> UART & RX Div"]
        REG3_OUT["REG3 [7:0] --> TX Div Ratio"]
        RdData["RdData [7:0] --> SYS_CTRL"]
        Rd_Data_Valid["Rd_Data_Valid --> SYS_CTRL"]
    end

    WrData & Address & WrEn --> W_DEC
    W_DEC --> REG0 & REG1 & REG2 & REG3 & REG_GP
    REG0 & REG1 & REG2 & REG3 & REG_GP --> R_MUX
    Address & RdEn --> R_MUX
    clk_rst --> RF_Array & R_MUX

    REG0 --> REG0_OUT
    REG1 --> REG1_OUT
    REG2 --> REG2_OUT
    REG3 --> REG3_OUT
    R_MUX --> RdData & Rd_Data_Valid
```

#### Memory Map & Reserved Registers:
| Address | Name | Default Value | Description |
| :---: | :---: | :---: | :--- |
| `0x0` | **REG0** | `8'h00` | **ALU Operand A**: Directly wired to the ALU A-input bus. |
| `0x1` | **REG1** | `8'h00` | **ALU Operand B**: Directly wired to the ALU B-input bus. |
| `0x2` | **REG2** | `8'h20` | **UART Configuration Register**:<br>&bull; `REG2[0]`: Parity Enable (`1` = enabled, `0` = disabled).<br>&bull; `REG2[1]`: Parity Type (`0` = Even, `1` = Odd).<br>&bull; `REG2[7:2]`: UART Prescale Ratio (default = `32`). |
| `0x3` | **REG3** | `8'h20` | **Clock Division Ratio**: Configures the integer divisor for `TX_CLK_DIV` (default = `32`). |
| `0x4 - 0xF` | **REG4 - REG15** | `8'h00` | **General Purpose Registers**: Available for normal host read/write operations. |

---

### 4.3 Arithmetic Logic Unit (`ALU`)
The **ALU** is a 16-bit parameterized computation engine operating on 8-bit operands (`A` and `B`). It executes arithmetic, logical, comparison, and shifting operations based on the 4-bit `ALU_FUN` signal.

```mermaid
flowchart LR
    subgraph Inputs["ALU Inputs"]
        A["Operand A [7:0] (from REG0)"]
        B["Operand B [7:0] (from REG1)"]
        ALU_FUN["ALU_FUN [3:0] (from SYS_CTRL)"]
        en["en (ALU_EN from SYS_CTRL)"]
        clk_rst["clk (GATED_CLK) & rst"]
    end

    subgraph Computation_Blocks["Parallel Computation Units"]
        direction TB
        ARITH["Arithmetic Unit<br/>ADD (+) | SUB (-) | MUL (*) | DIV (/)"]
        LOGIC["Logic Unit<br/>AND (&) | OR (|) | NAND | NOR | XOR (^) | XNOR"]
        CMP["Comparator Unit<br/>Equal (A == B) | Greater (A > B)"]
        SHIFT["Barrel Shifter<br/>Shift Right (>> 1) | Shift Left (<< 1)"]
    end

    subgraph Output_Stage["Output Multiplexer & Registers"]
        MUX["16-to-1 Operation MUX<br/>(Selected by ALU_FUN)"]
        OUT_REG["16-bit ALU_OUT Register"]
        VAL_REG["out_valid Flag Register"]
    end

    subgraph Outputs["ALU Outputs"]
        ALU_OUT["ALU_OUT [15:0] --> SYS_CTRL"]
        out_valid["out_valid --> SYS_CTRL"]
    end

    A & B --> ARITH & LOGIC & CMP & SHIFT
    ARITH & LOGIC & CMP & SHIFT --> MUX
    ALU_FUN --> MUX
    en --> VAL_REG
    MUX --> OUT_REG
    clk_rst --> OUT_REG & VAL_REG
    OUT_REG --> ALU_OUT
    VAL_REG --> out_valid
```

#### Supported ALU Operations:
| `ALU_FUN` | Operation | Output Formula / Logic | Description |
| :---: | :--- | :---: | :--- |
| `4'b0000` | **Addition** | `A + B` | 16-bit sum of operands |
| `4'b0001` | **Subtraction** | `A - B` | 16-bit difference of operands |
| `4'b0010` | **Multiplication**| `A * B` | 16-bit product of operands |
| `4'b0011` | **Division** | `A / B` | 16-bit quotient of operands |
| `4'b0100` | **Bitwise AND** | `A & B` | Bitwise logical AND |
| `4'b0101` | **Bitwise OR** | `A \| B` | Bitwise logical OR |
| `4'b0110` | **Bitwise NAND**| `~(A & B)` | Bitwise logical NAND |
| `4'b0111` | **Bitwise NOR** | `~(A \| B)` | Bitwise logical NOR |
| `4'b1000` | **Bitwise XOR** | `A ^ B` | Bitwise logical XOR |
| `4'b1001` | **Bitwise XNOR**| `~(A ^ B)` | Bitwise logical XNOR |
| `4'b1010` | **CMP: A = B** | `(A == B) ? 16'd1 : 16'd0` | Equality comparator |
| `4'b1011` | **CMP: A > B** | `(A > B) ? 16'd2 : 16'd0` | Greater-than comparator |
| `4'b1100` | **Shift Right** | `{1'b0, A[7:1]}` | Logical shift right by 1 bit |
| `4'b1101` | **Shift Left** | `{A[6:0], 1'b0}` | Logical shift left by 1 bit |

---

### 4.4 Integrated Clock Gating (`CLK_GATE`)
To reduce dynamic power consumption during idle periods, the ALU clock is gated using an **Integrated Clock Gating (ICG)** cell. The clock is active only when `SYS_CTRL` asserts `CLK_EN` during active ALU computations.

```mermaid
flowchart LR
    subgraph Inputs["Clock Gate Inputs"]
        clk["clk (REF_CLK = 50 MHz)"]
        clk_en["clk_en (Gate_EN from SYS_CTRL)"]
    end

    subgraph ICG_Cell["Integrated Clock Gating Cell (TLATNCAX2M)"]
        direction LR
        INV["Clock Inverter<br/>(Active-Low Control)"]
        LATCH["Negative-Level-Sensitive Latch<br/>Transparent when clk = 0<br/>Latched when clk = 1"]
        AND_GATE["2-Input AND Gate"]
    end

    subgraph Outputs["Gated Output"]
        gated_clk["gated_clk --> ALU Sequential Logic"]
    end

    clk --> INV --> LATCH
    clk_en --> LATCH
    LATCH -- "glitch_free_en" --> AND_GATE
    clk --> AND_GATE
    AND_GATE --> gated_clk
```

* **Architecture**: Negative-level-sensitive latch driving an AND gate, completely preventing clock glitches and runt pulses.
* **ASIC Implementation**: Maps to TSMC 130nm library cell `TLATNCAX2M`.

---

### 4.5 UART Transmitter (`UART_TX`)
The **UART Transmitter** handles parallel-to-serial conversion of bytes popped from the Asynchronous FIFO.

```mermaid
flowchart LR
    subgraph Inputs["UART_TX Inputs"]
        Data_Valid["Data_Valid (from ASYNC_FIFO)"]
        P_DATA["P_DATA [7:0] (from ASYNC_FIFO)"]
        PAR_EN["PAR_EN (from REG2[0])"]
        PAR_TYP["PAR_TYP (from REG2[1])"]
        clk_rst["clk (TX_CLK) & rst"]
    end

    subgraph Internal_Blocks["UART_TX Architecture"]
        FSM["FSM_TX<br/>(IDLE, START, DATA, PARITY, STOP)"]
        SER["Serializer<br/>(P_DATA to 1-bit ser_data)"]
        PAR["Parity_Calc<br/>(Even / Odd Parity Bit)"]
        MUX["Output MUX 4:1<br/>[0: Start, 1: Stop, 2: ser_data, 3: par_bit]"]
    end

    subgraph Outputs["UART_TX Outputs"]
        TX_OUT["TX_OUT (Serial Output Pin)"]
        busy["busy --> Pulse_Gen (FIFO Read Trigger)"]
    end

    Data_Valid --> FSM & PAR
    P_DATA --> SER & PAR
    PAR_EN --> FSM
    PAR_TYP --> PAR
    clk_rst --> FSM & SER & PAR

    FSM -- "ser_en" --> SER
    SER -- "ser_done" --> FSM
    SER -- "ser_data" --> MUX
    PAR -- "par_bit" --> MUX
    FSM -- "mux_sel [1:0]" --> MUX
    FSM --> busy
    MUX --> TX_OUT
```

```mermaid
stateDiagram-v2
    direction LR
    [*] --> IDLE
    IDLE --> START: DATA_VALID == 1
    START --> DATA: 1 TX_CLK period (Send Start 0)
    DATA --> PARITY: Bit_Count == 8 & PAR_EN == 1
    DATA --> STOP: Bit_Count == 8 & PAR_EN == 0
    PARITY --> STOP: 1 TX_CLK period (Send Parity)
    STOP --> IDLE: 1 TX_CLK period (Send Stop 1)
```

* **Internal Blocks**:
  * **`FSM_TX`**: Controls frame state sequencing (`IDLE`, `START`, `DATA`, `PARITY`, `STOP`).
  * **`Serializer`**: Shifts out parallel data bit-by-bit driven by `TX_CLK`.
  * **`Parity_Calc`**: Computes Even or Odd parity dynamically across the 8 data bits.
  * **`MUX`**: Multiplexes Start (`0`), Serial Data, Parity, and Stop (`1`) bits onto `TX_OUT`.
  * **`Busy` Flag**: Indicates when a transmission is ongoing; falling edge triggers next FIFO pop.

---

### 4.6 UART Receiver (`UART_RX`)
The **UART Receiver** captures incoming serial stream `RX_IN`, filters noise, checks frame integrity, and converts valid bytes into parallel data.

```mermaid
flowchart LR
    subgraph Inputs["UART_RX Inputs"]
        RX_IN["RX_IN (Serial Input Pin)"]
        prescale["prescale [5:0] (from REG2[7:2])"]
        PAR_EN["PAR_EN (from REG2[0])"]
        PAR_TYP["PAR_TYP (from REG2[1])"]
        clk_rst["clk (RX_CLK) & rst"]
    end

    subgraph Core_Blocks["UART_RX Architecture"]
        CNT["edge_bit_counter<br/>(Tracks edge_cnt & bit_cnt)"]
        SAMP["data_sampling<br/>(3-Sample Majority Voter)"]
        STRT["strt_checker<br/>(Start Glitch Detector)"]
        DESER["deserializer<br/>(SIPO Shift Register)"]
        PAR_CHK["parity_checker<br/>(Dynamic Parity Validator)"]
        STP_CHK["stop_checker<br/>(Framing Stop Bit Validator)"]
        FSM["FSM_RX<br/>(11-State Master RX Engine)"]
    end

    subgraph Outputs["UART_RX Outputs"]
        P_DATA["P_DATA [7:0] --> DATA_SYNC"]
        data_valid["data_valid --> DATA_SYNC (bus_enable)"]
        par_err["par_err (Parity Error Flag)"]
        stp_err["stp_err (Framing Error Flag)"]
    end

    RX_IN --> SAMP & FSM
    prescale --> CNT & SAMP & PAR_CHK & STP_CHK & FSM
    clk_rst --> CNT & SAMP & STRT & DESER & PAR_CHK & STP_CHK & FSM

    FSM -- "enable" --> CNT
    CNT -- "edge_cnt" --> SAMP & PAR_CHK & STP_CHK & FSM
    FSM -- "dat_samp_en" --> SAMP
    SAMP -- "majority_bit" --> STRT & DESER & PAR_CHK & STP_CHK

    FSM -- "strt_chk_en" --> STRT
    STRT -- "strt_glitch" --> FSM

    FSM -- "deser_en" --> DESER
    DESER --> P_DATA

    FSM -- "par_chk_en" --> PAR_CHK
    PAR_EN & PAR_TYP --> PAR_CHK
    P_DATA --> PAR_CHK
    PAR_CHK --> par_err

    FSM -- "stp_chk_en" --> STP_CHK
    STP_CHK --> stp_err

    FSM --> data_valid
```

```mermaid
stateDiagram-v2
    direction LR
    [*] --> IDLE
    IDLE --> START: RX_IN == 0 (Falling Edge Detected)
    START --> DATA: Valid Start Bit Checked (Samples 3,4,5 = 0)
    DATA --> PARITY: Bit_Count == 8 & PAR_EN == 1
    DATA --> STOP: Bit_Count == 8 & PAR_EN == 0
    PARITY --> STOP: Check Parity (Assert PAR_ERR if mismatch)
    STOP --> IDLE: Check Stop Bit (Assert STP_ERR if 0, else DATA_VLD)
```

* **Internal Blocks**:
  * **`data_sampling`**: Takes 3 samples per bit interval and applies majority voting for glitch immunity.
  * **`strt_checker`**: Validates low-level start bit.
  * **`stop_checker`**: Verifies high-level stop bit; asserts `STP_ERR` if missing.
  * **`parity_checker`**: Verifies received parity bit; asserts `PAR_ERR` upon mismatch.
  * **`deserializer`**: Reconstructs serial bits into parallel 8-bit bus.
  * **`edge_bit_counter`**: Tracks oversampling edges and frame bit indices.
  * **`FSM_RX`**: Orchestrates reception and asserts `DATA_VLD`.

---

### 4.7 Asynchronous FIFO (`ASYNC_FIFO`)
The **Asynchronous FIFO** provides rate matching and safe cross-clock domain data transfer between the high-speed `REF_CLK` domain (writing ALU/RegFile results) and the low-speed `UART_CLK` domain (reading for serial transmission).

```mermaid
flowchart TB
    subgraph Write_Domain["Write Clock Domain (REF_CLK = 50 MHz)"]
        wdata["wdata [7:0] (from SYS_CTRL)"]
        winc["winc (WR_INC from SYS_CTRL)"]
        wclk["wclk (REF_CLK) & wrst_n"]
        FIFO_WR["FIFO_WR<br/>• Binary/Gray Write Pointer<br/>• Full Flag Generation"]
        SYNC_R2W["DF_SYNC (U4)<br/>2-Flop Synchronizer<br/>(rptr_gray -> wq2_rptr)"]
        wfull["wfull (FIFO_FULL) --> SYS_CTRL"]
    end

    subgraph Dual_Port_RAM["Dual-Port SRAM (FIFO_MEM_CNTRL 8x8)"]
        MEM_CORE["8-Entry x 8-bit Dual-Port Register Array<br/>wclken = winc & !wfull"]
    end

    subgraph Read_Domain["Read Clock Domain (TX_CLK = 115.2 kHz)"]
        rinc["rinc (from Pulse_Gen)"]
        rclk["rclk (TX_CLK) & rrst_n"]
        FIFO_RD["FIFO_RD<br/>• Binary/Gray Read Pointer<br/>• Empty Flag Generation"]
        SYNC_W2R["DF_SYNC (U3)<br/>2-Flop Synchronizer<br/>(wptr_gray -> rq2_wptr)"]
        rempty["rempty (FIFO Empty Flag)"]
        rdata["rdata [7:0] (P_DATA) --> UART_TX"]
    end

    winc & wclk & wrst_n --> FIFO_WR
    FIFO_WR --> wfull
    FIFO_WR -- "waddr [2:0]" --> MEM_CORE
    wdata & wclk --> MEM_CORE
    FIFO_WR -- "wptr_gray [3:0]" --> SYNC_W2R
    SYNC_W2R -- "rq2_wptr" --> FIFO_RD

    rinc & rclk & rrst_n --> FIFO_RD
    FIFO_RD --> rempty
    FIFO_RD -- "raddr [2:0]" --> MEM_CORE
    MEM_CORE --> rdata
    FIFO_RD -- "rptr_gray [3:0]" --> SYNC_R2W
    SYNC_R2W -- "wq2_rptr" --> FIFO_WR
```

* **Buffer Depth & Width**: 8 words deep, 8 bits wide (dual-port memory).
* **Pointer Synchronization**: Read and Write pointers are converted to **Gray code** before crossing clock domains via 2-stage synchronizers (`DF_SYNC`), eliminating multi-bit metastability risks.
* **Full & Empty Logic**: Generated in the respective source domains to prevent data loss or underflow.

---

### 4.8 Multi-Bit Data Synchronizer (`DATA_SYNC`)
Transfers parallel 8-bit data from `UART_RX` (`UART_CLK` domain) into `SYS_CTRL` (`REF_CLK` domain) without bus skew or metastability issues.

```mermaid
flowchart LR
    subgraph Inputs["Source Domain Inputs (UART_CLK Domain)"]
        unsync_bus["unsync_bus [7:0] (from UART_RX)"]
        bus_enable["bus_enable (data_valid from UART_RX)"]
    end

    subgraph Sync_Logic["Destination Domain Synchronization (REF_CLK Domain)"]
        subgraph Flop_Stages["2-Stage Multi-Flop Synchronizer"]
            FF1["Synchronizer Flop 1"] --> FF2["Synchronizer Flop 2"]
        end
        subgraph Pulse_Unit["Edge Detector & Pulse Generator"]
            FF3["Enable Flop (Delay)"]
            AND_GATE["Pulse AND Gate<br/>(multi_flops[1] & !enable_flop)"]
            FF2 --> FF3
            FF2 & FF3 --> AND_GATE
        end
        subgraph Holding_Reg["Data Holding Register & Multiplexer"]
            MUX["Bus Multiplexer<br/>pulse ? unsync_bus : sync_bus"]
            OUT_REG["sync_bus Output Register"]
            PULSE_REG["enable_pulse Output Register"]
            MUX --> OUT_REG
            AND_GATE --> PULSE_REG
            AND_GATE --> MUX
        end
    end

    subgraph Outputs["Synchronized Outputs (REF_CLK Domain)"]
        sync_bus["sync_bus [7:0] --> SYS_CTRL"]
        enable_pulse["enable_pulse --> SYS_CTRL"]
    end

    bus_enable --> FF1
    unsync_bus --> MUX
    OUT_REG --> sync_bus
    OUT_REG -- "feedback" --> MUX
    PULSE_REG --> enable_pulse
```

* **Mechanism**: Uses pulse handshake coordination. When `bus_enable` is asserted in the transmitter domain, a synchronized enable pulse is generated in the destination domain after the multi-bit bus has stabilized.

---

### 4.9 Reset Synchronizer (`RST_SYNC`)
Ensures clean system reset assertion and deassertion across both independent clock domains.

```mermaid
flowchart LR
    subgraph Inputs["Reset Inputs"]
        rst["rst (Asynchronous Active-Low Reset)"]
        clk["clk (Domain Reference Clock)"]
        VCC["Logic 1'b1 (VCC)"]
    end

    subgraph Sync_Chain["3-Stage Synchronizer Flop Chain"]
        direction LR
        FF0["Flip-Flop 0<br/>Async Clear = !rst"]
        FF1["Flip-Flop 1<br/>Async Clear = !rst"]
        FF2["Flip-Flop 2<br/>Async Clear = !rst"]
        FF0 --> FF1 --> FF2
    end

    subgraph Outputs["Synchronized Reset"]
        sync_rst["sync_rst<br/>(Asynchronous Assert, Synchronous Deassert)"]
    end

    VCC --> FF0
    clk --> FF0 & FF1 & FF2
    rst -- "Direct Async Clear" --> FF0 & FF1 & FF2
    FF2 --> sync_rst
```

* **Operation**: **Asynchronous Assertion, Synchronous Deassertion**. Reset asserts instantly to protect hardware, but deasserts synchronously with clock edges to prevent reset recovery/removal timing violations.
* Two dedicated instances: `U0_RST_SYNC` for `REF_CLK` and `U1_RST_SYNC` for `UART_CLK`.

---

### 4.10 Clock Dividers & Prescaler MUX
Generates the baud clocks from `UART_CLK` (3.6864 MHz):
* **`U0_TX_CLK_DIV`**: Divides `UART_CLK` by `REG3` (division ratio) to produce `TX_CLK`.
* **`U1_RX_CLK_DIV`**: Divides `UART_CLK` by `rx_div_ratio` (produced by `prescale_mux` from `REG2[7:2]`) to generate the oversampled `RX_CLK`.

```mermaid
flowchart LR
    subgraph Inputs["Clock & Configuration Inputs"]
        UART_CLK["UART_CLK (3.6864 MHz)"]
        REG2["REG2[7:2] (UART Prescale)"]
        REG3["REG3[7:0] (TX Div Ratio = 32)"]
        clk_div_en["clk_div_en (from SYS_CTRL)"]
    end

    subgraph Prescaler["Prescaler Logic"]
        MUX["prescale_mux<br/>32 -> div 1<br/>16 -> div 2<br/>8  -> div 4"]
    end

    subgraph Dividers["Clock Divider Units"]
        RX_DIV["U1_RX_CLK_DIV (CLK_DIV)<br/>Odd / Even Integer Divider"]
        TX_DIV["U0_TX_CLK_DIV (CLK_DIV)<br/>Divide-by-32 Clock Divider"]
    end

    subgraph Outputs["Generated Clocks"]
        RX_CLK["RX_CLK (Oversampling Clock) --> UART_RX"]
        TX_CLK["TX_CLK (115,200 Hz Baud Clock) --> UART_TX"]
    end

    REG2 --> MUX
    MUX -- "div_ratio [2:0]" --> RX_DIV
    UART_CLK --> RX_DIV & TX_DIV
    clk_div_en --> RX_DIV & TX_DIV
    REG3 --> TX_DIV

    RX_DIV --> RX_CLK
    TX_DIV --> TX_CLK
```

---

### 4.11 Pulse Generator (`Pulse_Gen`)
Detects the falling edge of the `UART_TX` busy signal and converts it into a single `TX_CLK`-cycle pulse. This pulse drives `R_INC` on the Asynchronous FIFO, popping the next byte for continuous multi-byte transmissions.

```mermaid
flowchart LR
    subgraph Inputs["Pulse_Gen Inputs"]
        async["async (UART_TX Busy Signal)"]
        clk["clk (TX_CLK)"]
        rst["rst (Active-Low Reset)"]
    end

    subgraph Sync_and_Detect["Synchronization & Edge Detection"]
        direction LR
        subgraph Sync_Stages["2-Stage Synchronizer"]
            FF1["sync_reg[0]"] --> FF2["sync_reg[1]"]
        end
        D_FF["Delay Register (sync_d)"]
        INV["Inverter (~sync_d)"]
        AND_GATE["Pulse AND Gate<br/>(sync_reg[1] & !sync_d)"]
        OUT_FF["sync Output Register"]

        FF2 --> D_FF --> INV
        FF2 & INV --> AND_GATE --> OUT_FF
    end

    subgraph Outputs["Pulse Output"]
        sync["sync (Single-Cycle Pulse) --> ASYNC_FIFO (R_INC)"]
    end

    async --> FF1
    clk & rst --> FF1 & FF2 & D_FF & OUT_FF
    OUT_FF --> sync
```

---

## 5. Verification & Waveforms

The design was fully verified using an exhaustive self-checking testbench ([`SYSTEM_TOP_tb.v`](Test_bench/SYSTEM_TOP_tb.v)) in **QuestaSim / ModelSim**, validating:
1. Reset assertion and deassertion across clock domains.
2. Register File configuration writes (`REG2` UART prescaler, `REG3` clock divisor).
3. General-purpose Register File writes and readback verification.
4. ALU operations with operands (Addition, Subtraction, Multiplication, Division, Logic).
5. ALU operations without operands (using cached operands).
6. Parity error detection and framing error reporting.
7. Asynchronous FIFO continuous buffering under rate mismatch.

### Simulation Waveform 1: Clocks, UART, Synchronization & Control
![ModelSim Waveform 1](Screenshots/modelsim_waveform_1.png)

### Simulation Waveform 2: Register File & ALU Execution
![ModelSim Waveform 2](Screenshots/modelsim_waveform_2.png)

### Simulation Waveform 3: Asynchronous FIFO Buffering
![ModelSim Waveform 3](Screenshots/modelsim_waveform_3.png)

---

## 6. ASIC Implementation Flow & Results

The digital ASIC implementation flow was executed under worst-case corner conditions (**SS / 1.08V / 125°C**) using standard cell libraries (`scmetro_tsmc_cl013g_rvt`).

### 6.1 Logic Synthesis (Synopsys Design Compiler)
* **Target Clock Frequency**: 100 MHz (Clock Period = 10.0 ns)
* **Setup Timing Slack**: **`0.00 ns` (MET — Zero Slack Closure)**
* **Hold Timing Slack**: **`0.04 ns` (MET)**
* **Total Cell Area**: **`27,225.31 µm²`**
* **Total Chip Area (including net interconnect)**: **`301,113.36 µm²`**
* **Total Cell Count**: **2,275 cells** (1,844 combinational, 393 sequential)
* **Power Dissipation**: **13.56 mW Dynamic Power**, **704.9 nW Leakage Power**

```
Hierarchical Area Breakdown:
-------------------------------------------------------------
Hierarchical Cell     Absolute Area (um2)    Percent Total (%)
-------------------------------------------------------------
SYSTEM_TOP                27225.31                 100.0%
├── U0_ALU                 8864.08                  32.6%
├── U0_REGFILE             6045.88                  22.2%
├── U0_ASYNC_FIFO          4103.15                  15.1%
├── U0_UART                3730.14                  13.7%
├── U0_TX_CLK_DIV          1269.66                   4.7%
├── U1_RX_CLK_DIV          1269.66                   4.7%
├── U0_SYS_CTRL            1203.76                   4.4%
└── Synchronizers & Gate    738.98                   2.7%
-------------------------------------------------------------
```

### 6.2 Design for Testability (DFT Compiler)
* **Scan Architecture**: **4 Scan Chains** stitched across sequential elements.
* **Scan Cells**: 389 scan flip-flops.
* **Test Coverage**: **`99.66%`**
* **Fault Coverage**: **`99.27%`**
* **Fault Population**: 17,638 total faults evaluated; 0 un-testable violations.

### 6.3 Formal Verification (Synopsys Formality)
* **RTL vs. Post-Synthesis Netlist**: **100% Equivalence Verification SUCCEEDED** (55,620 compare points verified, 0 failing, 0 unverified).
* **Post-Synthesis vs. Post-DFT Netlist**: **100% Equivalence Verification SUCCEEDED** (53,410 compare points verified, 0 failing, 0 unverified).

### 6.4 Lint & CDC Sign-off (SpyGlass)
* **Lint Methodology**: Clean sign-off under `GuideWare/latest/block/rtl_handoff`.
* **Clock Domain Crossing (CDC)**: Structural and functional CDC verification passed across all domain crossings with customized waiver files.

---

## 7. Directory Structure

```
Final_System/
│
├── .github/
│   └── workflows/
│       └── ci.yml                      # Automated GitHub Actions RTL CI verification
│
├── docs/                               # System specifications and PDF documentation
│   ├── Final_System.pdf                # Architectural specifications
│   └── simulation_waveform.pdf         # Full formatted simulation waveform printout
│
├── do_files/                           # Multi-simulator automation & compilation scripts
│   ├── run.do                          # ModelSim / QuestaSim DO script
│   ├── wave.do                         # ModelSim waveform signal configuration & grouping
│   ├── run_iverilog.sh                 # Open-source Icarus Verilog script (Linux/macOS/CI)
│   └── run_iverilog.bat                # Open-source Icarus Verilog script (Windows)
│
├── IC/                                 # ASIC Implementation Flow (VM Environment)
│   └── Projects/
│       └── System/
│           ├── std_cells/              # TSMC 130nm library (.db and .lib files)
│           ├── lint/                   # SpyGlass Lint project, rules & waivers
│           ├── CDC/                    # SpyGlass CDC analysis, SDC & SGDC constraints
│           ├── Synthesis/              # Synopsys DC scripts, constraints, reports, netlists
│           ├── DFT/                    # Synopsys DFT scan insertion, scan netlists & reports
│           └── Formality/              # Formal Equivalence Verification (post-syn, post-dft, post-pnr)
│
├── rtl/                                # Golden synthesizable RTL source modules
│   ├── ALU/                            # 16-bit Arithmetic Logic Unit
│   │   └── ALU.v
│   ├── ASYNC_FIFO/                     # Dual-Clock Asynchronous FIFO
│   │   ├── ASYNC_FIFO.v
│   │   ├── DF_SYNC.v
│   │   ├── FIFO_MEM_CNTRL.v
│   │   ├── FIFO_RD.v
│   │   └── FIFO_WR.v
│   ├── CLK_DIV/                        # Parameterized Clock Divider
│   │   └── Clk_Div.v
│   ├── CLK_DIV_RX_MUX/                 # RX Oversampling Clock Prescale Multiplexer
│   │   └── prescale_mux.v
│   ├── CLK_GATING/                     # Integrated Clock Gating Cell (TLATNCA / Simulation)
│   │   └── CLK_GATE.v
│   ├── DATA_SYNC/                      # Multi-Bit Enable-Handshake Data Synchronizer
│   │   └── DATA_SYNC.v
│   ├── Pulse_Gen/                      # Single-Cycle Pulse Generator
│   │   └── Pulse_Gen.v
│   ├── Reg_File/                       # 16x8 Dual-Port Register File
│   │   └── regfile.v
│   ├── RST_SYNC/                       # 2-Stage Reset Synchronizer
│   │   └── RST_SYNC.v
│   ├── SYS_CTRL/                       # Master System Controller FSM
│   │   └── SYS_CTRL.v
│   ├── SYS_TOP/                        # Top-Level SoC Integration
│   │   └── SYSTEM_TOP.v
│   └── UART/                           # Full-Duplex Configurable UART Subsystem
│       ├── UART.v
│       ├── UART_TX.v
│       ├── UART_RX.v
│       ├── Serializer.v
│       ├── Parity_Calc.v
│       ├── MUX.v
│       ├── FSM_TX.sv
│       ├── FSM_RX.v
│       ├── data_sampling.v
│       ├── strt_checker.v
│       ├── stop_checker.v
│       ├── parity_checker.v
│       ├── edge_bit_counter.v
│       └── deserializer.v
│
├── Screenshots/                        # Logic simulation waveform captures
│   ├── modelsim_waveform_1.png
│   ├── modelsim_waveform_2.png
│   └── modelsim_waveform_3.png
│
├── scripts/                            # Host communication software & verification
│   └── uart_driver.py                  # Python UART host driver & protocol regression suite
│
├── Test_bench/                         # Exhaustive self-checking testbench
│   └── SYSTEM_TOP_tb.v
│
├── .gitignore                          # EDA & simulation cache filter
└── README.md                           # Master project documentation
```

---

## 8. How to Run Simulation & Verification

The testbench can be verified using proprietary EDA tools (ModelSim/QuestaSim), free open-source tools (Icarus Verilog + GTKWave), or interactively validated via the Python UART host driver:

### 8.1 ModelSim / QuestaSim (GUI Simulation)
1. Open **ModelSim / QuestaSim**.
2. Navigate to the `do_files` directory:
   ```tcl
   cd do_files
   ```
3. Run the automated compilation and execution script:
   ```tcl
   do run.do
   ```

### 8.2 Open-Source Simulation (Icarus Verilog & GTKWave)
The testbench can be compiled and executed with 100% open-source tools on Linux, macOS, or Windows:
* **Linux / macOS**:
  ```bash
  chmod +x do_files/run_iverilog.sh
  ./do_files/run_iverilog.sh
  ```
* **Windows (Command Prompt / PowerShell)**:
  ```bat
  do_files\run_iverilog.bat
  ```
* **View Simulation Waveforms in GTKWave**:
  ```bash
  gtkwave do_files/system_waveform.vcd
  ```

### 8.3 Host Python UART Driver & Interactive Verification
A Python driver is provided in `scripts/uart_driver.py` to interact with the SoC over a physical serial port or through the built-in mock hardware simulator:
* **Run the automated protocol regression suite**:
  ```bash
  python scripts/uart_driver.py --demo
  ```
* **Connect to a physical hardware UART / COM port**:
  ```bash
  python scripts/uart_driver.py --port COM3 --baud 115200
  ```

---

## Author
**Ahmed Badawy**  
Faculty of Engineering, Cairo University  
📧 `ahmed.badwy05@eng-st.cu.edu.eg`  
🔗 GitHub: [@ahmedbadwy77](https://github.com/ahmedbadwy77)
