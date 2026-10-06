set_app_var power_enable_analysis true
set_app_var power_analysis_mode time_based
set power_vcd_time_unit 1ns

set report_dir /home/ICer/IC/Projects/System/GLS/pt/report
file mkdir $report_dir

set Out_report True_Power
#------------------------------------------------------------------------------
# Libraries
#------------------------------------------------------------------------------
lappend search_path /home/ICer/IC/Projects/System/std_cells

set TTLIB   scmetro_tsmc_cl013g_rvt_tt_1p2v_25c.db
set SSLIB   scmetro_tsmc_cl013g_rvt_ss_1p08v_125c.db
set FFLIB   scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c.db

set target_library [list $TTLIB $SSLIB $FFLIB]
set link_library   [list * $TTLIB $SSLIB $FFLIB]

#------------------------------------------------------------------------------
# Read Design Files
#------------------------------------------------------------------------------

# Read Verilog Netlist
read_verilog /home/ICer/IC/Projects/System/GLS/sdc_sdf_netlist/SYS_TOP.v

current_design SYS_TOP

link_design

# Read SDC File
read_sdc /home/ICer/IC/Projects/System/GLS/sdc_sdf_netlist/SYS_TOP.sdc

# Read SDF File
read_sdf /home/ICer/IC/Projects/System/GLS/sdc_sdf_netlist/SYS_TOP.sdf

#------------------------------------------------------------------------------
# Read Switching Activity
#------------------------------------------------------------------------------
read_vcd -strip_path SYSTEM_TOP_tb/DUT /home/ICer/IC/Projects/System/GLS/Test_bench/VCD/SYSTEM_TOP.vcd

update_power

#------------------------------------------------------------------------------
# Reports
#------------------------------------------------------------------------------
report_power                              > $report_dir/$Out_report.rpt

echo "----------------------------------------"
echo "PrimeTime PX Analysis Finished"
echo "Reports saved in:"
echo "$report_dir"
echo "----------------------------------------"
#start_gui
exit
