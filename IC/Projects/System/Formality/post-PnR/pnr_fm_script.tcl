
########################### Define Top Module ############################
                                                   
set top_module SYS_TOP

######################### Formality Setup File ###########################

set synopsys_auto_setup true

set_svf "../../DFT/$top_module.svf"


set SSLIB "/home/ICer/IC/Projects/System/std_cells/scmetro_tsmc_cl013g_rvt_ss_1p08v_125c.db"
set TTLIB "/home/ICer/IC/Projects/System/std_cells/scmetro_tsmc_cl013g_rvt_tt_1p2v_25c.db"
set FFLIB "/home/ICer/IC/Projects/System/std_cells/scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c.db"

######################### Reference Container ############################

## Read Reference technology libraries

read_db -container Ref [list $SSLIB $TTLIB $FFLIB]

## Read Reference Design Files

read_verilog -container Ref /home/ICer/IC/Projects/System/DFT/rtl/ALU.v
read_verilog -container Ref /home/ICer/IC/Projects/System/DFT/rtl/ASYNC_FIFO.v
read_verilog -container Ref /home/ICer/IC/Projects/System/DFT/rtl/Clk_Div.v
read_verilog -container Ref /home/ICer/IC/Projects/System/DFT/rtl/CLK_GATE.v
read_verilog -container Ref /home/ICer/IC/Projects/System/DFT/rtl/data_sampling.v
read_verilog -container Ref /home/ICer/IC/Projects/System/DFT/rtl/DATA_SYNC.v
read_verilog -container Ref /home/ICer/IC/Projects/System/DFT/rtl/deserializer.v
read_verilog -container Ref /home/ICer/IC/Projects/System/DFT/rtl/DF_SYNC.v
read_verilog -container Ref /home/ICer/IC/Projects/System/DFT/rtl/edge_bit_counter.v
read_verilog -container Ref /home/ICer/IC/Projects/System/DFT/rtl/FIFO_MEM_CNTRL.v
read_verilog -container Ref /home/ICer/IC/Projects/System/DFT/rtl/FIFO_RD.v
read_verilog -container Ref /home/ICer/IC/Projects/System/DFT/rtl/FIFO_WR.v
read_verilog -container Ref /home/ICer/IC/Projects/System/DFT/rtl/FSM_RX.v
read_sverilog -container Ref /home/ICer/IC/Projects/System/DFT/rtl/FSM_TX.sv
read_verilog -container Ref /home/ICer/IC/Projects/System/DFT/rtl/MUX.v
read_verilog -container Ref /home/ICer/IC/Projects/System/DFT/rtl/Parity_Calc.v
read_verilog -container Ref /home/ICer/IC/Projects/System/DFT/rtl/parity_checker.v
read_verilog -container Ref /home/ICer/IC/Projects/System/DFT/rtl/prescale_mux.v
read_verilog -container Ref /home/ICer/IC/Projects/System/DFT/rtl/Pulse_Gen.v
read_verilog -container Ref /home/ICer/IC/Projects/System/DFT/rtl/regfile.v
read_verilog -container Ref /home/ICer/IC/Projects/System/DFT/rtl/RST_SYNC.v
read_verilog -container Ref /home/ICer/IC/Projects/System/DFT/rtl/Serializer.v
read_verilog -container Ref /home/ICer/IC/Projects/System/DFT/rtl/stop_checker.v
read_verilog -container Ref /home/ICer/IC/Projects/System/DFT/rtl/strt_checker.v
read_verilog -container Ref /home/ICer/IC/Projects/System/DFT/rtl/SYS_CTRL.v
read_verilog -container Ref /home/ICer/IC/Projects/System/DFT/rtl/SYS_TOP.v
read_verilog -container Ref /home/ICer/IC/Projects/System/DFT/rtl/UART.v
read_verilog -container Ref /home/ICer/IC/Projects/System/DFT/rtl/UART_RX.v
read_verilog -container Ref /home/ICer/IC/Projects/System/DFT/rtl/UART_TX.v

## set the top Reference Design 

set_reference_design $top_module
set_top $top_module

######################## Implementation Container #########################

## Read Implementation technology libraries

read_db -container Imp [list $SSLIB $TTLIB $FFLIB]

## Read Implementation Design Files

read_verilog -container Imp /home/ICer/IC/Projects/System/Formality/post-PnR/netlist/SYS_TOP.v
 
## set the top Implementation Design

set_implementation_design $top_module
set_top $top_module

############################### Don't verify #################################

# do not verify scan in & scan out ports as a compare point as it is existed only after synthesis and not existed in the RTL

#scan in

set_dont_verify_points -type port {Ref:/WORK/*/SI[0]}
set_dont_verify_points -type port {Ref:/WORK/*/SI[1]}
set_dont_verify_points -type port {Ref:/WORK/*/SI[2]}
set_dont_verify_points -type port {Ref:/WORK/*/SI[3]}

#scan_out

set_dont_verify_points -type port {Ref:/WORK/*/SO[0]}
set_dont_verify_points -type port {Ref:/WORK/*/SO[1]}
set_dont_verify_points -type port {Ref:/WORK/*/SO[2]}
set_dont_verify_points -type port {Ref:/WORK/*/SO[3]}

############################### constants #####################################

# all atpg enable(test_mode, scan_enable) are zero during formal compare

#test_mode

set_constant Ref:/WORK/*/test_mode 0
set_constant Imp:/WORK/*/test_mode 0

#scan_enable

set_constant Ref:/WORK/*/SE 0
set_constant Imp:/WORK/*/SE 0


########################### matching Compare points ##########################

match

################################# verify #####################################

set successful [verify]
if {!$successful} {
diagnose
analyze_points -failing
}

report_passing_points > "reports/passing_points.rpt"
report_failing_points > "reports/failing_points.rpt"
report_aborted_points > "reports/aborted_points.rpt"
report_unverified_points > "reports/unverified_points.rpt"
report_unmatched_points -status unread


start_gui
