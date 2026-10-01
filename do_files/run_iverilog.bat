@echo off
rem ==============================================================================
rem Open-Source Icarus Verilog Simulation Script for SYSTEM_TOP (Windows)
rem ==============================================================================
cd /d "%~dp0"

echo Compiling RTL and Testbench with Icarus Verilog...
iverilog -g2012 -DIVERILOG -DDUMP_VCD -o sim.vvp ^
    -I .. ^
    -I ../rtl ^
    ../rtl/CLK_GATING/CLK_GATE.v ^
    ../rtl/CLK_DIV/Clk_Div.v ^
    ../rtl/CLK_DIV_RX_MUX/prescale_mux.v ^
    ../rtl/RST_SYNC/RST_SYNC.v ^
    ../rtl/UART/data_sampling.v ^
    ../rtl/UART/strt_checker.v ^
    ../rtl/UART/stop_checker.v ^
    ../rtl/UART/parity_checker.v ^
    ../rtl/UART/edge_bit_counter.v ^
    ../rtl/UART/deserializer.v ^
    ../rtl/UART/FSM_RX.v ^
    ../rtl/UART/UART_RX.v ^
    ../rtl/UART/Serializer.v ^
    ../rtl/UART/Parity_Calc.v ^
    ../rtl/UART/MUX.v ^
    ../rtl/UART/FSM_TX.sv ^
    ../rtl/UART/UART_TX.v ^
    ../rtl/UART/UART.v ^
    ../rtl/Pulse_Gen/Pulse_Gen.v ^
    ../rtl/DATA_SYNC/DATA_SYNC.v ^
    ../rtl/ASYNC_FIFO/DF_SYNC.v ^
    ../rtl/ASYNC_FIFO/FIFO_RD.v ^
    ../rtl/ASYNC_FIFO/FIFO_WR.v ^
    ../rtl/ASYNC_FIFO/FIFO_MEM_CNTRL.v ^
    ../rtl/ASYNC_FIFO/ASYNC_FIFO.v ^
    ../rtl/Reg_File/regfile.v ^
    ../rtl/ALU/ALU.v ^
    ../rtl/SYS_CTRL/SYS_CTRL.v ^
    ../rtl/SYS_TOP/SYSTEM_TOP.v ^
    ../Test_bench/SYSTEM_TOP_tb.v

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

echo Simulation finished successfully. VCD waveform written to: do_files\system_waveform.vcd
