vlib work
vmap work

file mkdir VCD

# Compile Standard Cell Library
vlog -sv /home/ICer/IC/Projects/System/GLS/std_cells/tsmc13_m.v

# Compile Gate-Level Netlist
vlog -sv /home/ICer/IC/Projects/System/GLS/sdc_sdf_netlist/SYS_TOP.v

# Compile Testbench
vlog -sv +define+DUMP_VCD +define+IVERILOG SYSTEM_TOP_tb.v

# Start Simulation
vsim -sdfmax /SYSTEM_TOP_tb/DUT=/home/ICer/IC/Projects/System/GLS/sdc_sdf_netlist/SYS_TOP.sdf -sdfnoerror +no_notifier work.SYSTEM_TOP_tb

# Load waveform 
#do wave.do

# Run
run -all
