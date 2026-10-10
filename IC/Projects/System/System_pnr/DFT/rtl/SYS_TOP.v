module SYS_TOP #(parameter NUM_OF_CHAINS = 4)(
    input wire REF_CLK,
    input wire UART_CLK,
    input wire RST_N,
    input wire UART_RX_IN,
    input wire scan_clk , scan_rst , test_mode , SE ,
    input wire [NUM_OF_CHAINS-1 : 0] SI ,
    output wire [NUM_OF_CHAINS-1 : 0] SO ,
    output wire UART_TX_O,
    output wire parity_error,
    output wire framing_error
);

wire REF_RST;
wire UART_RST;

wire TX_CLK;
wire RX_CLK;

wire [7:0] RX_OUT_P;
wire RX_OUT_V;

wire [7:0] sync_bus;
wire enable_pulse;

wire [3:0] Addr;
wire [3:0] FUN;
wire en;
wire WrEn;
wire RdEn;
wire Gate_EN;
wire WR_INC;
wire clk_div_en;
wire [7:0] Wr_D;
wire [7:0] WR_DATA;

wire [7:0] Rd_D;
wire Rd_D_Vld;

wire [7:0] REG0;
wire [7:0] REG1;
wire [7:0] REG2;
wire [7:0] REG3;

wire [15:0] ALU_OUT;
wire ALU_OUT_V;

wire gated_clk;

wire [7:0] FIFO_RDATA;
wire FIFO_EMPTY;
wire FIFO_FULL;
wire FIFO_RINC;
wire UART_TX_BUSY;
wire TX_IN_V;

wire [2:0] rx_div_ratio;

wire TX_CLK_M , RX_CLK_M , REF_CLK_M , UART_CLK_M , GATED_CLK_M;

assign TX_CLK_M = test_mode ? scan_clk : TX_CLK ;
assign RX_CLK_M = test_mode ? scan_clk : RX_CLK ;
assign REF_CLK_M = test_mode ? scan_clk : REF_CLK ;
assign UART_CLK_M = test_mode ? scan_clk : UART_CLK;
assign GATED_CLK_M = test_mode ? scan_clk : gated_clk ;

wire RST_M , REF_RST_M , UART_RST_M ;

assign RST_M = test_mode ? scan_rst : RST_N;
assign REF_RST_M = test_mode ? scan_rst : REF_RST;
assign UART_RST_M = test_mode ? scan_rst : UART_RST;

prescale_mux U0_prescale_mux(
    .prescale(REG2[7:2]),
    .div_ratio(rx_div_ratio)
);

CLK_DIV U0_TX_CLK_DIV(
    .i_ref_clk(UART_CLK_M),
    .i_rst_n(UART_RST_M),
    .i_clk_en(clk_div_en),
    .i_div_ratio(REG3),
    .o_div_clk(TX_CLK)
);

CLK_DIV U1_RX_CLK_DIV(
    .i_ref_clk(UART_CLK_M),
    .i_rst_n(UART_RST_M),
    .i_clk_en(clk_div_en),
    .i_div_ratio({5'b0,rx_div_ratio}),
    .o_div_clk(RX_CLK)
);

RST_SYNC U0_RST_SYNC(
    .rst(RST_M),
    .clk(REF_CLK_M),
    .sync_rst(REF_RST)
);

RST_SYNC U1_RST_SYNC(
    .rst(RST_M),
    .clk(UART_CLK_M),
    .sync_rst(UART_RST)
);

UART U0_UART(
    .RST(UART_RST_M),
    .TX_CLK(TX_CLK_M),
    .RX_CLK(RX_CLK_M),
    .RX_IN_S(UART_RX_IN),
    .parity_enable(REG2[0]),
    .parity_type(REG2[1]),
    .TX_IN_V(TX_IN_V),
    .Prescale(REG2[7:2]),
    .TX_IN_P(FIFO_RDATA),
    .RX_OUT_P(RX_OUT_P),
    .RX_OUT_V(RX_OUT_V),
    .TX_OUT_S(UART_TX_O),
    .TX_OUT_V(UART_TX_BUSY),
    .parity_error(parity_error),
    .framing_error(framing_error)
);

DATA_SYNC U0_DATA_SYNC(
    .clk(REF_CLK_M),
    .rst(REF_RST_M),
    .bus_enable(RX_OUT_V),
    .unsync_bus(RX_OUT_P),
    .sync_bus(sync_bus),
    .enable_pulse(enable_pulse)
);

SYS_CTRL U0_SYS_CTRL(
    .Rd_D(Rd_D),
    .sync_bus(sync_bus),
    .Rd_D_Vld(Rd_D_Vld),
    .clk(REF_CLK_M),
    .rst(REF_RST_M),
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
    .clk(REF_CLK_M),
    .rst(REF_RST_M),
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
    .clk(REF_CLK_M),
    .clk_en(Gate_EN | test_mode),
    .gated_clk(gated_clk)
);

ALU U0_ALU(
    .A(REG0),
    .B(REG1),
    .ALU_FUN(FUN),
    .clk(GATED_CLK_M),
    .en(en),
    .rst(REF_RST_M),
    .ALU_OUT(ALU_OUT),
    .out_valid(ALU_OUT_V)
);

ASYNC_FIFO U0_ASYNC_FIFO(
    .wdata(WR_DATA),
    .winc(WR_INC),
    .rinc(FIFO_RINC),
    .wclk(REF_CLK_M),
    .rclk(TX_CLK_M),
    .wrst_n(REF_RST_M),
    .rrst_n(UART_RST_M),
    .rdata(FIFO_RDATA),
    .rempty(FIFO_EMPTY),
    .wfull(FIFO_FULL)
);

assign TX_IN_V = !FIFO_EMPTY;

Pulse_Gen U0_Pulse_Gen(
    .clk(TX_CLK_M),
    .rst(UART_RST_M),
    .async(UART_TX_BUSY),
    .sync(FIFO_RINC)
);

endmodule
