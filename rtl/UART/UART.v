module UART(
 input   wire RST , TX_CLK , RX_CLK , RX_IN_S, parity_enable , parity_type, TX_IN_V,
 input   wire [5:0] Prescale, 
 input   wire [7:0] TX_IN_P,
 output  wire [7:0] RX_OUT_P, 
 output  wire RX_OUT_V , TX_OUT_S , TX_OUT_V , parity_error , framing_error
);


UART_TX U0_UART_TX (
.clk(TX_CLK),
.rst(RST),
.P_DATA(TX_IN_P),
.Data_Valid(TX_IN_V),
.PAR_EN(parity_enable),
.PAR_TYP(parity_type), 
.TX_OUT(TX_OUT_S),
.busy(TX_OUT_V)
);
 
 
UART_RX U0_UART_RX (
.clk(RX_CLK),
.rst(RST),
.RX_IN(RX_IN_S),
.prescale(Prescale),
.PAR_EN(parity_enable),
.PAR_TYP(parity_type),
.P_DATA(RX_OUT_P), 
.data_valid(RX_OUT_V),
.par_err(parity_error),
.stp_err(framing_error)
);
endmodule
 
