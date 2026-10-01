###################################################################

# Created by write_sdc on Thu Oct 1 03:03:38 2026

###################################################################

sg_set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
sg_set_operating_conditions -max scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -max_library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -min scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c -min_library scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c
sg_set_wire_load_model -name tsmc13_wl10 -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c
sg_set_driving_cell -lib_cell BUFX2M -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c [sg_get_ports RX_IN]
sg_set_load -pin_load 0.1 [sg_get_ports TX_OUT]
sg_set_load -pin_load 0.1 [sg_get_ports parity_error]
sg_set_load -pin_load 0.1 [sg_get_ports framing_error]
sg_create_clock [sg_get_ports REF_CLK]  -name ref_clk  -period 10  -waveform {0 5}
sg_set_clock_uncertainty -setup 0.2  [sg_get_clocks ref_clk]
sg_set_clock_uncertainty -hold 0.1  [sg_get_clocks ref_clk]
sg_set_clock_transition -max -fall 0.05 [sg_get_clocks ref_clk]
sg_set_clock_transition -min -fall 0.05 [sg_get_clocks ref_clk]
sg_set_clock_transition -max -rise 0.05 [sg_get_clocks ref_clk]
sg_set_clock_transition -min -rise 0.05 [sg_get_clocks ref_clk]
sg_create_clock [sg_get_ports UART_CLK]  -name uart_clk  -period 271.267  -waveform {0 135.634}
sg_set_clock_uncertainty -setup 0.2  [sg_get_clocks uart_clk]
sg_set_clock_uncertainty -hold 0.1  [sg_get_clocks uart_clk]
sg_set_clock_transition -max -fall 0.05 [sg_get_clocks uart_clk]
sg_set_clock_transition -min -fall 0.05 [sg_get_clocks uart_clk]
sg_set_clock_transition -max -rise 0.05 [sg_get_clocks uart_clk]
sg_set_clock_transition -min -rise 0.05 [sg_get_clocks uart_clk]
sg_create_generated_clock [sg_get_pins U1_RX_CLK_DIV/o_div_clk]  -name rx_clk  -source [sg_get_ports UART_CLK]  -master_clock uart_clk  -divide_by 1  -add
sg_create_generated_clock [sg_get_pins U0_TX_CLK_DIV/o_div_clk]  -name tx_clk  -source [sg_get_ports UART_CLK]  -master_clock uart_clk  -divide_by 32  -add
sg_create_generated_clock [sg_get_pins U0_CLK_GATE/gated_clk]  -name alu_clk  -source [sg_get_ports REF_CLK]  -master_clock ref_clk  -divide_by 1  -add
sg_group_path -name INOUT  -from [list [sg_get_ports REF_CLK] [sg_get_ports UART_CLK] [sg_get_ports RST] [sg_get_ports RX_IN]]  -to [list [sg_get_ports TX_OUT] [sg_get_ports parity_error] [sg_get_ports framing_error]]
sg_group_path -name INREG  -from [list [sg_get_ports REF_CLK] [sg_get_ports UART_CLK] [sg_get_ports RST] [sg_get_ports RX_IN]]
sg_group_path -name REGOUT  -to [list [sg_get_ports TX_OUT] [sg_get_ports parity_error] [sg_get_ports framing_error]]
sg_set_input_delay -clock uart_clk  54.2535  [sg_get_ports RX_IN]
sg_set_output_delay -clock uart_clk  54.2535  [sg_get_ports TX_OUT]
sg_set_output_delay -clock uart_clk  54.2535  [sg_get_ports parity_error]
sg_set_output_delay -clock uart_clk  54.2535  [sg_get_ports framing_error]
sg_set_clock_groups -asynchronous -name uart_clk_1 -group [list [sg_get_clocks uart_clk] [sg_get_clocks rx_clk] [sg_get_clocks tx_clk]] -group [list [sg_get_clocks alu_clk] [sg_get_clocks ref_clk]]
