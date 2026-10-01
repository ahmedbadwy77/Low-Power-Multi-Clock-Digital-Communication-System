# ==============================================================================
# ModelSim / QuestaSim Simulation Script for SYSTEM_TOP
# ==============================================================================

# Clean and recreate work library
if [file exists work] {
    vdel -all
}
vlib work

# Compile RTL source files from module directories
vlog -reportprogress 300 +acc -sv \
    ../rtl/CLK_GATING/CLK_GATE.v \
    ../rtl/CLK_DIV/Clk_Div.v \
    ../rtl/CLK_DIV_RX_MUX/prescale_mux.v \
    ../rtl/RST_SYNC/RST_SYNC.v \
    ../rtl/UART/data_sampling.v \
    ../rtl/UART/strt_checker.v \
    ../rtl/UART/stop_checker.v \
    ../rtl/UART/parity_checker.v \
    ../rtl/UART/edge_bit_counter.v \
    ../rtl/UART/deserializer.v \
    ../rtl/UART/FSM_RX.v \
    ../rtl/UART/UART_RX.v \
    ../rtl/UART/Serializer.v \
    ../rtl/UART/Parity_Calc.v \
    ../rtl/UART/MUX.v \
    ../rtl/UART/FSM_TX.sv \
    ../rtl/UART/UART_TX.v \
    ../rtl/UART/UART.v \
    ../rtl/Pulse_Gen/Pulse_Gen.v \
    ../rtl/DATA_SYNC/DATA_SYNC.v \
    ../rtl/ASYNC_FIFO/DF_SYNC.v \
    ../rtl/ASYNC_FIFO/FIFO_RD.v \
    ../rtl/ASYNC_FIFO/FIFO_WR.v \
    ../rtl/ASYNC_FIFO/FIFO_MEM_CNTRL.v \
    ../rtl/ASYNC_FIFO/ASYNC_FIFO.v \
    ../rtl/Reg_File/regfile.v \
    ../rtl/ALU/ALU.v \
    ../rtl/SYS_CTRL/SYS_CTRL.v \
    ../rtl/SYS_TOP/SYSTEM_TOP.v

# Compile Testbench
vlog -reportprogress 300 +acc \
    ../Test_bench/SYSTEM_TOP_tb.v

# Optimize and load simulation
vsim -voptargs="+acc" work.SYSTEM_TOP_tb

# Run simulation
run -all
