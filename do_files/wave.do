onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {Clocks & Resets} -color Gold /SYSTEM_TOP_tb/REF_CLK
add wave -noupdate -expand -group {Clocks & Resets} -color Gold /SYSTEM_TOP_tb/UART_CLK
add wave -noupdate -expand -group {Clocks & Resets} -color Orange /SYSTEM_TOP_tb/DUT/gated_clk
add wave -noupdate -expand -group {Clocks & Resets} -color Red /SYSTEM_TOP_tb/RST
add wave -noupdate -expand -group {Clocks & Resets} -color Red /SYSTEM_TOP_tb/DUT/REF_RST
add wave -noupdate -expand -group {Clocks & Resets} -color Red /SYSTEM_TOP_tb/DUT/UART_RST
add wave -noupdate -expand -group {Clocks & Resets} /SYSTEM_TOP_tb/DUT/TX_CLK
add wave -noupdate -expand -group {Clocks & Resets} /SYSTEM_TOP_tb/DUT/RX_CLK
add wave -noupdate -expand -group {Top-Level UART I/O} -color Cyan /SYSTEM_TOP_tb/DUT/RX_IN
add wave -noupdate -expand -group {Top-Level UART I/O} -color Green /SYSTEM_TOP_tb/DUT/TX_OUT
add wave -noupdate -expand -group {Top-Level UART I/O} -color Orange /SYSTEM_TOP_tb/DUT/UART_TX_BUSY
add wave -noupdate -expand -group {Top-Level UART I/O} -color Red /SYSTEM_TOP_tb/DUT/parity_error
add wave -noupdate -expand -group {Top-Level UART I/O} -color Red /SYSTEM_TOP_tb/DUT/framing_error
add wave -noupdate -expand -group UART -color Cyan -radix hexadecimal /SYSTEM_TOP_tb/DUT/U0_UART/RX_OUT_P
add wave -noupdate -expand -group UART -color Magenta /SYSTEM_TOP_tb/DUT/U0_UART/RX_OUT_V
add wave -noupdate -expand -group UART -color Green -radix hexadecimal /SYSTEM_TOP_tb/DUT/U0_UART/TX_IN_P
add wave -noupdate -expand -group UART -color Magenta /SYSTEM_TOP_tb/DUT/U0_UART/TX_IN_V
add wave -noupdate -expand -group UART -color Orange /SYSTEM_TOP_tb/DUT/U0_UART/TX_OUT_V
add wave -noupdate -expand -group DATA_SYNC -color Cyan -radix hexadecimal /SYSTEM_TOP_tb/DUT/U0_DATA_SYNC/unsync_bus
add wave -noupdate -expand -group DATA_SYNC /SYSTEM_TOP_tb/DUT/U0_DATA_SYNC/bus_enable
add wave -noupdate -expand -group DATA_SYNC -color Green -radix hexadecimal /SYSTEM_TOP_tb/DUT/U0_DATA_SYNC/sync_bus
add wave -noupdate -expand -group DATA_SYNC -color Magenta /SYSTEM_TOP_tb/DUT/U0_DATA_SYNC/enable_pulse
add wave -noupdate -expand -group SYS_CTRL -color Magenta -radix hexadecimal /SYSTEM_TOP_tb/DUT/U0_SYS_CTRL/current_state
add wave -noupdate -expand -group SYS_CTRL -color Cyan -radix hexadecimal /SYSTEM_TOP_tb/DUT/U0_SYS_CTRL/command
add wave -noupdate -expand -group SYS_CTRL -color Yellow -radix hexadecimal /SYSTEM_TOP_tb/DUT/U0_SYS_CTRL/Addr
add wave -noupdate -expand -group SYS_CTRL -color Cyan -radix hexadecimal /SYSTEM_TOP_tb/DUT/U0_SYS_CTRL/Wr_D
add wave -noupdate -expand -group SYS_CTRL -color Green /SYSTEM_TOP_tb/DUT/U0_SYS_CTRL/WrEn
add wave -noupdate -expand -group SYS_CTRL -color Green /SYSTEM_TOP_tb/DUT/U0_SYS_CTRL/RdEn
add wave -noupdate -expand -group SYS_CTRL -color Orange /SYSTEM_TOP_tb/DUT/U0_SYS_CTRL/Gate_EN
add wave -noupdate -expand -group SYS_CTRL /SYSTEM_TOP_tb/DUT/U0_SYS_CTRL/en
add wave -noupdate -expand -group SYS_CTRL -color Yellow -radix hexadecimal /SYSTEM_TOP_tb/DUT/U0_SYS_CTRL/FUN
add wave -noupdate -expand -group SYS_CTRL -color Magenta /SYSTEM_TOP_tb/DUT/U0_SYS_CTRL/WR_INC
add wave -noupdate -expand -group SYS_CTRL -color Cyan -radix hexadecimal /SYSTEM_TOP_tb/DUT/U0_SYS_CTRL/WR_DATA
add wave -noupdate -expand -group {Register File} -color Yellow -radix hexadecimal /SYSTEM_TOP_tb/DUT/U0_REGFILE/Address
add wave -noupdate -expand -group {Register File} -color Cyan -radix hexadecimal /SYSTEM_TOP_tb/DUT/U0_REGFILE/WrData
add wave -noupdate -expand -group {Register File} /SYSTEM_TOP_tb/DUT/U0_REGFILE/WrEn
add wave -noupdate -expand -group {Register File} /SYSTEM_TOP_tb/DUT/U0_REGFILE/RdEn
add wave -noupdate -expand -group {Register File} -color Green -radix hexadecimal /SYSTEM_TOP_tb/DUT/U0_REGFILE/RdData
add wave -noupdate -expand -group {Register File} -color Green /SYSTEM_TOP_tb/DUT/U0_REGFILE/Rd_Data_Valid
add wave -noupdate -expand -group {Register File} -color Yellow -radix hexadecimal /SYSTEM_TOP_tb/DUT/U0_REGFILE/REG0
add wave -noupdate -expand -group {Register File} -color Yellow -radix hexadecimal /SYSTEM_TOP_tb/DUT/U0_REGFILE/REG1
add wave -noupdate -expand -group {Register File} -color Cyan -radix hexadecimal /SYSTEM_TOP_tb/DUT/U0_REGFILE/REG2
add wave -noupdate -expand -group {Register File} -color Cyan -radix hexadecimal /SYSTEM_TOP_tb/DUT/U0_REGFILE/REG3
add wave -noupdate -expand -group ALU -color Yellow -radix hexadecimal /SYSTEM_TOP_tb/DUT/U0_ALU/A
add wave -noupdate -expand -group ALU -color Yellow -radix hexadecimal /SYSTEM_TOP_tb/DUT/U0_ALU/B
add wave -noupdate -expand -group ALU -color Yellow -radix hexadecimal /SYSTEM_TOP_tb/DUT/U0_ALU/ALU_FUN
add wave -noupdate -expand -group ALU /SYSTEM_TOP_tb/DUT/U0_ALU/en
add wave -noupdate -expand -group ALU -color Green -radix hexadecimal /SYSTEM_TOP_tb/DUT/U0_ALU/ALU_OUT
add wave -noupdate -expand -group ALU -color Magenta /SYSTEM_TOP_tb/DUT/U0_ALU/out_valid
add wave -noupdate -expand -group {Async FIFO} -color Cyan -radix hexadecimal /SYSTEM_TOP_tb/DUT/U0_ASYNC_FIFO/wdata
add wave -noupdate -expand -group {Async FIFO} -color Magenta /SYSTEM_TOP_tb/DUT/U0_ASYNC_FIFO/winc
add wave -noupdate -expand -group {Async FIFO} -color Red /SYSTEM_TOP_tb/DUT/U0_ASYNC_FIFO/wfull
add wave -noupdate -expand -group {Async FIFO} -color Green -radix hexadecimal /SYSTEM_TOP_tb/DUT/U0_ASYNC_FIFO/rdata
add wave -noupdate -expand -group {Async FIFO} -color Magenta /SYSTEM_TOP_tb/DUT/U0_ASYNC_FIFO/rinc
add wave -noupdate -expand -group {Async FIFO} -color Red /SYSTEM_TOP_tb/DUT/U0_ASYNC_FIFO/rempty
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1343976329 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 220
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {3731397608 ps}
