# ==============================================================================
# ModelSim / QuestaSim Simulation Script for SYSTEM_TOP
# ==============================================================================

# Clean and recreate work library
if [file exists work] {
    vdel -all
}
vlib work

# Compile RTL source files from module directories
vlog -reportprogress 300 +acc -sv ../rtl/*/*.*v

# Compile Testbench
vlog -reportprogress 300 +acc \
    ../Test_bench/SYSTEM_TOP_tb.v

# Optimize and load simulation
vsim -voptargs="+acc" work.SYSTEM_TOP_tb

# Run simulation
run -all
