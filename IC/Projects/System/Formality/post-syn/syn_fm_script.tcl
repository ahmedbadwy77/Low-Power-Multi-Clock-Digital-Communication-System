
########################### Define Top Module ############################
                                                   
set top_module SYSTEM_TOP

######################### Formality Setup File ###########################

set synopsys_auto_setup true

set_svf "../../Synthesis/$top_module.svf"


set SSLIB "/home/ICer/IC/Projects/System/std_cells/scmetro_tsmc_cl013g_rvt_ss_1p08v_125c.db"
set TTLIB "/home/ICer/IC/Projects/System/std_cells/scmetro_tsmc_cl013g_rvt_tt_1p2v_25c.db"
set FFLIB "/home/ICer/IC/Projects/System/std_cells/scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c.db"

######################### Reference Container ############################

## Read Reference technology libraries

read_db -container Ref [list $SSLIB $TTLIB $FFLIB]

## Read Reference Design Files

read_verilog -container Ref /home/ICer/IC/Projects/System/rtl/ALU.v
read_verilog -container Ref /home/ICer/IC/Projects/System/rtl/ASYNC_FIFO.v
read_verilog -container Ref /home/ICer/IC/Projects/System/rtl/Clk_Div.v
read_verilog -container Ref /home/ICer/IC/Projects/System/rtl/CLK_GATE.v
read_verilog -container Ref /home/ICer/IC/Projects/System/rtl/data_sampling.v
read_verilog -container Ref /home/ICer/IC/Projects/System/rtl/DATA_SYNC.v
read_verilog -container Ref /home/ICer/IC/Projects/System/rtl/deserializer.v
read_verilog -container Ref /home/ICer/IC/Projects/System/rtl/DF_SYNC.v
read_verilog -container Ref /home/ICer/IC/Projects/System/rtl/edge_bit_counter.v
read_verilog -container Ref /home/ICer/IC/Projects/System/rtl/FIFO_MEM_CNTRL.v
read_verilog -container Ref /home/ICer/IC/Projects/System/rtl/FIFO_RD.v
read_verilog -container Ref /home/ICer/IC/Projects/System/rtl/FIFO_WR.v
read_verilog -container Ref /home/ICer/IC/Projects/System/rtl/FSM_RX.v
read_sverilog -container Ref /home/ICer/IC/Projects/System/rtl/FSM_TX.sv
read_verilog -container Ref /home/ICer/IC/Projects/System/rtl/MUX.v
read_verilog -container Ref /home/ICer/IC/Projects/System/rtl/Parity_Calc.v
read_verilog -container Ref /home/ICer/IC/Projects/System/rtl/parity_checker.v
read_verilog -container Ref /home/ICer/IC/Projects/System/rtl/prescale_mux.v
read_verilog -container Ref /home/ICer/IC/Projects/System/rtl/Pulse_Gen.v
read_verilog -container Ref /home/ICer/IC/Projects/System/rtl/regfile.v
read_verilog -container Ref /home/ICer/IC/Projects/System/rtl/RST_SYNC.v
read_verilog -container Ref /home/ICer/IC/Projects/System/rtl/Serializer.v
read_verilog -container Ref /home/ICer/IC/Projects/System/rtl/stop_checker.v
read_verilog -container Ref /home/ICer/IC/Projects/System/rtl/strt_checker.v
read_verilog -container Ref /home/ICer/IC/Projects/System/rtl/SYS_CTRL.v
read_verilog -container Ref /home/ICer/IC/Projects/System/rtl/SYSTEM_TOP.v
read_verilog -container Ref /home/ICer/IC/Projects/System/rtl/UART.v
read_verilog -container Ref /home/ICer/IC/Projects/System/rtl/UART_RX.v
read_verilog -container Ref /home/ICer/IC/Projects/System/rtl/UART_TX.v


## set the top Reference Design 

set_reference_design $top_module
set_top $top_module


######################## Implementation Container #########################

## Read Implementation technology libraries

read_db -container Imp [list $SSLIB $TTLIB $FFLIB]

## Read Implementation Design Files

read_verilog -container Imp /home/ICer/IC/Projects/System/Synthesis/netlists/SYSTEM_TOP.v
 
## set the top Implementation Design

set_implementation_design $top_module
set_top $top_module

## matching Compare points
match

## verify
set successful [verify]
if {!$successful} {
diagnose
analyze_points -failing
}

report_passing_points > "reports/passing_points.rpt"
report_failing_points > "reports/failing_points.rpt"
report_aborted_points > "reports/aborted_points.rpt"
report_unverified_points > "reports/unverified_points.rpt"


start_gui
