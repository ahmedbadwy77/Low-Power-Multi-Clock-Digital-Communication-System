###################################################################

# Created by write_sdc on Mon Oct 5 04:37:24 2026

###################################################################
set sdc_version 2.1

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
set_operating_conditions -max scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -max_library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -min scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c -min_library scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c
set_wire_load_model -name tsmc13_wl10 -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c [get_ports test_mode]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c [get_ports SE]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c [get_ports {SI[3]}]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c [get_ports {SI[2]}]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c [get_ports {SI[1]}]
set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c [get_ports {SI[0]}]
set_load -pin_load 0.1 [get_ports {SO[3]}]
set_load -pin_load 0.1 [get_ports {SO[2]}]
set_load -pin_load 0.1 [get_ports {SO[1]}]
set_load -pin_load 0.1 [get_ports {SO[0]}]
set_load -pin_load 0.1 [get_ports parity_error]
set_load -pin_load 0.1 [get_ports framing_error]
create_clock [get_ports REF_CLK]  -name ref_clk  -period 10  -waveform {0 5}
set_clock_uncertainty -setup 0.2  [get_clocks ref_clk]
set_clock_uncertainty -hold 0.1  [get_clocks ref_clk]
set_clock_transition -min -rise 0.05 [get_clocks ref_clk]
set_clock_transition -max -rise 0.05 [get_clocks ref_clk]
set_clock_transition -min -fall 0.05 [get_clocks ref_clk]
set_clock_transition -max -fall 0.05 [get_clocks ref_clk]
create_clock [get_ports UART_CLK]  -name uart_clk  -period 271.267  -waveform {0 135.634}
set_clock_uncertainty -setup 0.2  [get_clocks uart_clk]
set_clock_uncertainty -hold 0.1  [get_clocks uart_clk]
set_clock_transition -min -rise 0.05 [get_clocks uart_clk]
set_clock_transition -max -rise 0.05 [get_clocks uart_clk]
set_clock_transition -min -fall 0.05 [get_clocks uart_clk]
set_clock_transition -max -fall 0.05 [get_clocks uart_clk]
create_clock [get_ports scan_clk]  -name dft_clk  -period 1000  -waveform {0 500}
set_clock_uncertainty -setup 0.2  [get_clocks dft_clk]
set_clock_uncertainty -hold 0.1  [get_clocks dft_clk]
set_clock_transition -min -rise 0.05 [get_clocks dft_clk]
set_clock_transition -max -rise 0.05 [get_clocks dft_clk]
set_clock_transition -min -fall 0.05 [get_clocks dft_clk]
set_clock_transition -max -fall 0.05 [get_clocks dft_clk]
create_generated_clock [get_pins U1_RX_CLK_DIV/o_div_clk]  -name rx_clk  -source [get_ports UART_CLK]  -master_clock uart_clk  -divide_by 1  -add
create_generated_clock [get_pins U0_TX_CLK_DIV/o_div_clk]  -name tx_clk  -source [get_ports UART_CLK]  -master_clock uart_clk  -divide_by 32  -add
create_generated_clock [get_pins U0_CLK_GATE/gated_clk]  -name alu_clk  -source [get_ports REF_CLK]  -master_clock ref_clk  -divide_by 1  -add
set_input_delay -clock uart_clk  54.2535  [get_ports UART_RX_IN]
set_input_delay -clock dft_clk  200  [get_ports test_mode]
set_input_delay -clock dft_clk  200  [get_ports {SI[3]}]
set_input_delay -clock dft_clk  200  [get_ports {SI[2]}]
set_input_delay -clock dft_clk  200  [get_ports {SI[1]}]
set_input_delay -clock dft_clk  200  [get_ports {SI[0]}]
set_input_delay -clock dft_clk  200  [get_ports SE]
set_output_delay -clock uart_clk  54.2535  [get_ports UART_TX_O]
set_output_delay -clock uart_clk  54.2535  [get_ports parity_error]
set_output_delay -clock uart_clk  54.2535  [get_ports framing_error]
set_output_delay -clock dft_clk  200  [get_ports {SO[3]}]
set_output_delay -clock dft_clk  200  [get_ports {SO[2]}]
set_output_delay -clock dft_clk  200  [get_ports {SO[1]}]
set_output_delay -clock dft_clk  200  [get_ports {SO[0]}]
set_clock_groups -logically_exclusive -name dft_clk_others_1 -group [get_clocks dft_clk]
set_clock_groups -asynchronous -name uart_clk_1 -group [list [get_clocks uart_clk] [get_clocks rx_clk] [get_clocks tx_clk]] -group [list [get_clocks alu_clk] [get_clocks ref_clk]]

set_case_analysis 1 [get_ports test_mode]
set_case_analysis 1 [get_port SE]
