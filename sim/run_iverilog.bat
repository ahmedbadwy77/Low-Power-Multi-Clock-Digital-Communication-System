@echo off
rem ==============================================================================
rem Open-Source Icarus Verilog Simulation Script for SYSTEM_TOP (Windows)
rem ==============================================================================
cd /d "%~dp0"

echo Compiling RTL and Testbench with Icarus Verilog...
iverilog -g2012 -DIVERILOG -DDUMP_VCD -o sim.vvp ^
    -I ../rtl ^
    ../rtl/CLK_GATE.v ^
    ../rtl/Clk_Div.v ^
    ../rtl/prescale_mux.v ^
    ../rtl/RST_SYNC.v ^
    ../rtl/data_sampling.v ^
    ../rtl/strt_checker.v ^
    ../rtl/stop_checker.v ^
    ../rtl/parity_checker.v ^
    ../rtl/edge_bit_counter.v ^
    ../rtl/deserializer.v ^
    ../rtl/FSM_RX.v ^
    ../rtl/UART_RX.v ^
    ../rtl/Serializer.v ^
    ../rtl/Parity_Calc.v ^
    ../rtl/MUX.v ^
    ../rtl/FSM_TX.sv ^
    ../rtl/UART_TX.v ^
    ../rtl/UART.v ^
    ../rtl/Pulse_Gen.v ^
    ../rtl/DATA_SYNC.v ^
    ../rtl/DF_SYNC.v ^
    ../rtl/FIFO_RD.v ^
    ../rtl/FIFO_WR.v ^
    ../rtl/FIFO_MEM_CNTRL.v ^
    ../rtl/ASYNC_FIFO.v ^
    ../rtl/regfile.v ^
    ../rtl/ALU.v ^
    ../rtl/SYS_CTRL.v ^
    ../rtl/SYSTEM_TOP.v ^
    ../tb/SYSTEM_TOP_tb.v

if %ERRORLEVEL% neq 0 (
    echo Compilation failed!
    exit /b %ERRORLEVEL%
)

echo Running Simulation...
vvp sim.vvp
if %ERRORLEVEL% neq 0 (
    echo Simulation failed!
    exit /b %ERRORLEVEL%
)

echo Simulation finished successfully. VCD waveform written to: sim\system_waveform.vcd
