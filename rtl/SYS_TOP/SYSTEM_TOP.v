module SYSTEM_TOP(
    input wire REF_CLK,
    input wire UART_CLK,
    input wire RST,
    input wire RX_IN,
    output wire TX_OUT,
    output wire parity_error,
    output wire framing_error
);

wire [15:0] ALU_OUT;
wire [7:0] RX_OUT_P , sync_bus , Wr_D , WR_DATA , Rd_D , REG0 , REG1 , REG2 , REG3 , FIFO_RDATA;
wire [3:0] Addr , FUN;
wire [2:0] rx_div_ratio;
wire REF_RST , UART_RST , TX_CLK , RX_CLK , gated_clk , RX_OUT_V , enable_pulse , en , WrEn , 
			RdEn , Gate_EN , WR_INC , clk_div_en , Rd_D_Vld , ALU_OUT_V , FIFO_EMPTY , FIFO_FULL , FIFO_RINC , UART_TX_BUSY , TX_IN_V;

prescale_mux U0_prescale_mux(
    .prescale(REG2[7:2]),
    .div_ratio(rx_div_ratio)
);

CLK_DIV U0_TX_CLK_DIV(
    .i_ref_clk(UART_CLK),
    .i_rst_n(UART_RST),
    .i_clk_en(clk_div_en),
    .i_div_ratio(REG3),
    .o_div_clk(TX_CLK)
);

CLK_DIV U1_RX_CLK_DIV(
    .i_ref_clk(UART_CLK),
    .i_rst_n(UART_RST),
    .i_clk_en(clk_div_en),
    .i_div_ratio({5'b0,rx_div_ratio}),
    .o_div_clk(RX_CLK)
);

RST_SYNC U0_RST_SYNC(
    .rst(RST),
    .clk(REF_CLK),
    .sync_rst(REF_RST)
);

RST_SYNC U1_RST_SYNC(
    .rst(RST),
    .clk(UART_CLK),
    .sync_rst(UART_RST)
);

UART U0_UART(
    .RST(UART_RST),
    .TX_CLK(TX_CLK),
    .RX_CLK(RX_CLK),
    .RX_IN_S(RX_IN),
    .parity_enable(REG2[0]),
    .parity_type(REG2[1]),
    .TX_IN_V(TX_IN_V),
    .Prescale(REG2[7:2]),
    .TX_IN_P(FIFO_RDATA),
    .RX_OUT_P(RX_OUT_P),
    .RX_OUT_V(RX_OUT_V),
    .TX_OUT_S(TX_OUT),
    .TX_OUT_V(UART_TX_BUSY),
    .parity_error(parity_error),
    .framing_error(framing_error)
);

DATA_SYNC U0_DATA_SYNC(
    .clk(REF_CLK),
    .rst(REF_RST),
    .bus_enable(RX_OUT_V),
    .unsync_bus(RX_OUT_P),
    .sync_bus(sync_bus),
    .enable_pulse(enable_pulse)
);

SYS_CTRL U0_SYS_CTRL(
    .Rd_D(Rd_D),
    .sync_bus(sync_bus),
    .Rd_D_Vld(Rd_D_Vld),
    .clk(REF_CLK),
    .rst(REF_RST),
    .out_valid(ALU_OUT_V),
    .enable_pulse(enable_pulse),
    .FIFO_FULL(FIFO_FULL),
    .ALU_OUT(ALU_OUT),
    .Addr(Addr),
    .FUN(FUN),
    .en(en),
    .WrEn(WrEn),
    .RdEn(RdEn),
    .Gate_EN(Gate_EN),
    .WR_INC(WR_INC),
    .clk_div_en(clk_div_en),
    .Wr_D(Wr_D),
    .WR_DATA(WR_DATA)
);

regfile U0_REGFILE(
    .WrEn(WrEn),
    .RdEn(RdEn),
    .clk(REF_CLK),
    .rst(REF_RST),
    .WrData(Wr_D),
    .Address(Addr),
    .RdData(Rd_D),
    .Rd_Data_Valid(Rd_D_Vld),
    .REG0(REG0),
    .REG1(REG1),
    .REG2(REG2),
    .REG3(REG3)
);

CLK_GATE U0_CLK_GATE(
    .clk(REF_CLK),
    .clk_en(Gate_EN),
    .gated_clk(gated_clk)
);

ALU U0_ALU(
    .A(REG0),
    .B(REG1),
    .ALU_FUN(FUN),
    .clk(gated_clk),
    .en(en),
    .rst(REF_RST),
    .ALU_OUT(ALU_OUT),
    .out_valid(ALU_OUT_V)
);

ASYNC_FIFO U0_ASYNC_FIFO(
    .wdata(WR_DATA),
    .winc(WR_INC),
    .rinc(FIFO_RINC),
    .wclk(REF_CLK),
    .rclk(TX_CLK),
    .wrst_n(REF_RST),
    .rrst_n(UART_RST),
    .rdata(FIFO_RDATA),
    .rempty(FIFO_EMPTY),
    .wfull(FIFO_FULL)
);

assign TX_IN_V = !FIFO_EMPTY;

Pulse_Gen U0_Pulse_Gen(
    .clk(TX_CLK),
    .rst(UART_RST),
    .async(UART_TX_BUSY),
    .sync(FIFO_RINC)
);

endmodule
