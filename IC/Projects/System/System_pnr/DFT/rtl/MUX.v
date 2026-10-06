module MUX(
input wire ser_data , par_bit ,
input wire [1:0] mux_sel ,
output reg TX_OUT
);

parameter start_bit = 1'b0 , stop_bit = 1'b1;

always@(*)
begin

case(mux_sel)

2'b00 : begin

TX_OUT = start_bit;

end

2'b01 : begin

TX_OUT = stop_bit;

end

2'b10 : begin

TX_OUT = ser_data;

end

2'b11 : begin

TX_OUT = par_bit;

end
endcase
end

endmodule