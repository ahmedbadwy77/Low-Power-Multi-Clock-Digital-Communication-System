
####################################################################################
# Constraints
# ----------------------------------------------------------------------------
#
# 0. Design Compiler variables
#
# 1. Master Clock Definitions
#
# 2. Generated Clock Definitions
#
# 3. Clock Uncertainties
#
# 4. Clock Latencies 
#
# 5. Clock Relationships
#
# 6. #set input/output delay on ports
#
# 7. Driving cells
#
# 8. Output load

####################################################################################
           #########################################################
                  #### Section 0 : DC Variables ####
           #########################################################
#################################################################################### 

# Prevent assign statements in the generated netlist (must be applied before compile command)
set_fix_multiple_port_nets -all -buffer_constants -feedthroughs

####################################################################################
           #########################################################
                  #### Section 1 : Clock Definition ####
           #########################################################
#################################################################################### 
# 1. Master Clock Definitions 
# 2. Generated Clock Definitions
# 3. Clock Latencies
# 4. Clock Uncertainties
# 4. Clock Transitions
####################################################################################

#1. Master Clocks

set uart_clk_period 271.26736
set ref_clk_period 10

create_clock -name ref_clk -period $ref_clk_period [get_ports REF_CLK]

create_clock -name uart_clk -period $uart_clk_period [get_ports UART_CLK]

set_clock_uncertainty -setup 0.2 [get_clocks {ref_clk uart_clk}]
set_clock_uncertainty -hold 0.1 [get_clocks {ref_clk uart_clk}]
set_clock_transition -fall 0.05 [get_clocks {ref_clk uart_clk}]
set_clock_transition -rise 0.05 [get_clocks {ref_clk uart_clk}]


#2. Generated clocks

set prescale 32
set rx_clk_div [expr 32 / $prescale]
set div_ratio 32

create_generated_clock -master_clock uart_clk -source [get_ports UART_CLK] -name rx_clk -divide_by $rx_clk_div [get_ports U1_RX_CLK_DIV/o_div_clk]

create_generated_clock -master_clock uart_clk -source [get_ports UART_CLK] -name tx_clk -divide_by $div_ratio [get_ports U0_TX_CLK_DIV/o_div_clk]

create_generated_clock -master_clock ref_clk -source [get_ports REF_CLK] -name alu_clk -divide_by 1 [get_ports U0_CLK_GATE/gated_clk]

####################################################################################
           #########################################################
             #### Section 2 : Clocks Relationship ####
           #########################################################
####################################################################################

set_dont_touch_network [get_ports {UART_CLK REF_CLK RST}]

set_clock_groups -asynchronous -group [get_clocks {uart_clk rx_clk tx_clk}] -group [get_clocks {alu_clk ref_clk}]

####################################################################################
           #########################################################
             #### Section 3 : set input/output delay on ports ####
           #########################################################
####################################################################################

set_input_delay [expr 0.2 * $uart_clk_period] -clock uart_clk [get_ports {RX_IN}]

set_output_delay [expr 0.2 * $uart_clk_period] -clock uart_clk [get_ports {TX_OUT parity_error framing_error}]

####################################################################################
           #########################################################
                  #### Section 4 : Driving cells ####
           #########################################################
####################################################################################

set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M [get_ports RX_IN]

####################################################################################
           #########################################################
                  #### Section 5 : Output load ####
           #########################################################
####################################################################################

set_load 0.1 [get_ports {TX_OUT parity_error framing_error}]

####################################################################################
           #########################################################
                 #### Section 6 : Operating Condition ####
           #########################################################
####################################################################################

# Define the Worst Library for Max(#setup) analysis
# Define the Best Library for Min(hold) analysis

set_operating_conditions -min_library "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c" -min "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c" -max_library "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c" -max "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c"

####################################################################################
           #########################################################
                  #### Section 7 : wireload Model ####
           #########################################################
####################################################################################

set_wire_load_model -name tsmc13_wl10 -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c


####################################################################################
           #########################################################
                  #### Section 8 : premapped cells ####
           #########################################################
####################################################################################

set_dont_touch [get_designs CLK_GATE]

