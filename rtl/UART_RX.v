module UART_RX(
    input wire RX_IN , clk , rst , PAR_EN , PAR_TYP ,
    input wire [5:0] prescale,
    output wire [7:0] P_DATA,
    output wire data_valid , par_err , stp_err
);

wire  strt_glitch , sampled_bit ,deser_en , enable , dat_samp_en , par_chk_en , strt_chk_en , stp_chk_en ,majority_bit;
wire [5:0] edge_cnt;

parity_checker U0(
    .par_chk_en(par_chk_en),
    .majority_bit(majority_bit),
    .PAR_TYP(PAR_TYP),
    .rst(rst),
    .clk(clk),
    .P_DATA(P_DATA),
    .par_err(par_err),
    .strt_chk_en(strt_chk_en),
    .prescale(prescale),
    .edge_cnt(edge_cnt)
);

strt_checker U1(
    .strt_chk_en(strt_chk_en),
    .majority_bit(majority_bit),
    .rst(rst),
    .clk(clk),
    .strt_glitch(strt_glitch)
);

stop_checker U2(
    .stp_chk_en(stp_chk_en),
    .strt_chk_en(strt_chk_en),
    .majority_bit(majority_bit),
    .clk(clk),
    .rst(rst),
    .prescale(prescale),
    .edge_cnt(edge_cnt),
    .stp_err(stp_err)
);

data_sampling U3(
    .edge_cnt(edge_cnt),
    .prescale(prescale),
    .dat_samp_en(dat_samp_en),
    .clk(clk),
    .rst(rst),
    .RX_IN(RX_IN),
    .majority_bit(majority_bit)
);

deserializer U4(
    .deser_en(deser_en),
    .majority_bit(majority_bit),
    .clk(clk),
    .rst(rst),
    .P_DATA(P_DATA)
);
edge_bit_counter U5(
    .enable(enable),
    .clk(clk),
    .rst(rst),
    .prescale(prescale),
    .edge_cnt(edge_cnt)
);

FSM_RX U6(
    .PAR_EN(PAR_EN),
    .RX_IN(RX_IN),
    .strt_glitch(strt_glitch),
    .clk(clk),
    .rst(rst),
    .prescale(prescale),
    .edge_cnt(edge_cnt),
    .dat_samp_en(dat_samp_en),
    .par_chk_en(par_chk_en),
    .strt_chk_en(strt_chk_en),
    .stp_chk_en(stp_chk_en),
    .data_valid(data_valid),
    .deser_en(deser_en),
    .enable(enable)
);

endmodule
