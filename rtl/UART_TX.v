module UART_TX(
input wire Data_Valid , PAR_EN , PAR_TYP , clk , rst,
input wire [7:0] P_DATA,
output wire TX_OUT , busy
);

wire ser_data , par_bit , ser_en , ser_done;
wire [1:0] mux_sel ;

MUX U0 (.mux_sel(mux_sel) , .ser_data(ser_data) , .par_bit(par_bit) , .TX_OUT(TX_OUT));

Parity_Calc U1 (.Data_Valid(Data_Valid) , .P_DATA(P_DATA) , .PAR_TYP(PAR_TYP) ,
		.par_bit(par_bit) ,.clk(clk) , .rst(rst) );

Serializer U2 (.P_DATA(P_DATA) , .ser_en(ser_en) , .ser_done(ser_done) , .ser_data(ser_data),
		.clk(clk) , .rst(rst));

FSM_TX U3 (.Data_Valid(Data_Valid) , .ser_done(ser_done) , .ser_en(ser_en) , .PAR_EN(PAR_EN) ,
	.mux_sel(mux_sel) , .busy(busy) , .clk(clk) , .rst(rst));

endmodule