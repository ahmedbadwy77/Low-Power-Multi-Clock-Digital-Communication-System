# ==============================================================================
# ModelSim / QuestaSim Simulation Script for SYSTEM_TOP
# ==============================================================================

# Clean and recreate work library
if [file exists work] {
    vdel -all
}
vlib work

# Compile RTL source files
vlog -reportprogress 300 +acc -sv \
    ../rtl/CLK_GATE.v \
    ../rtl/Clk_Div.v \
    ../rtl/prescale_mux.v \
    ../rtl/RST_SYNC.v \
    ../rtl/data_sampling.v \
    ../rtl/strt_checker.v \
    ../rtl/stop_checker.v \
    ../rtl/parity_checker.v \
    ../rtl/edge_bit_counter.v \
    ../rtl/deserializer.v \
    ../rtl/FSM_RX.v \
    ../rtl/UART_RX.v \
    ../rtl/Serializer.v \
    ../rtl/Parity_Calc.v \
    ../rtl/MUX.v \
    ../rtl/FSM_TX.sv \
    ../rtl/UART_TX.v \
    ../rtl/UART.v \
    ../rtl/Pulse_Gen.v \
    ../rtl/DATA_SYNC.v \
    ../rtl/DF_SYNC.v \
    ../rtl/FIFO_RD.v \
    ../rtl/FIFO_WR.v \
    ../rtl/FIFO_MEM_CNTRL.v \
    ../rtl/ASYNC_FIFO.v \
    ../rtl/regfile.v \
    ../rtl/ALU.v \
    ../rtl/SYS_CTRL.v \
    ../rtl/SYSTEM_TOP.v

# Compile Testbench
vlog -reportprogress 300 +acc \
    ../tb/SYSTEM_TOP_tb.v

# Optimize and load simulation
vsim -voptargs="+acc" work.SYSTEM_TOP_tb

# Run simulation
run -all
