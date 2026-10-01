@echo off
rem ==============================================================================
rem Open-Source Icarus Verilog Simulation Script for SYSTEM_TOP (Windows)
rem ==============================================================================
cd /d "%~dp0"

echo Compiling RTL and Testbench with Icarus Verilog...
iverilog -g2012 -DIVERILOG -DDUMP_VCD -o sim.vvp ^
    -I .. ^
    ../CLK_GATING/CLK_GATE.v ^
    ../CLK_DIV/Clk_Div.v ^
    ../CLK_DIV_RX_MUX/prescale_mux.v ^
    ../RST_SYNC/RST_SYNC.v ^
    ../UART/data_sampling.v ^
    ../UART/strt_checker.v ^
    ../UART/stop_checker.v ^
    ../UART/parity_checker.v ^
    ../UART/edge_bit_counter.v ^
    ../UART/deserializer.v ^
    ../UART/FSM_RX.v ^
    ../UART/UART_RX.v ^
    ../UART/Serializer.v ^
    ../UART/Parity_Calc.v ^
    ../UART/MUX.v ^
    ../UART/FSM_TX.sv ^
    ../UART/UART_TX.v ^
    ../UART/UART.v ^
    ../Pulse_Gen/Pulse_Gen.v ^
    ../DATA_SYNC/DATA_SYNC.v ^
    ../ASYNC_FIFO/DF_SYNC.v ^
    ../ASYNC_FIFO/FIFO_RD.v ^
    ../ASYNC_FIFO/FIFO_WR.v ^
    ../ASYNC_FIFO/FIFO_MEM_CNTRL.v ^
    ../ASYNC_FIFO/ASYNC_FIFO.v ^
    ../Reg_File/regfile.v ^
    ../ALU/ALU.v ^
    ../SYS_CTRL/SYS_CTRL.v ^
    ../SYS_TOP/SYSTEM_TOP.v ^
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
