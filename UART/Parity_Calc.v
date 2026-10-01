module Parity_Calc (
input wire Data_Valid , PAR_TYP , clk , rst ,
input wire [7:0] P_DATA ,
output reg par_bit
);

always@(posedge clk or negedge rst)
begin

if(!rst)
par_bit <= 1'b0;

else if (Data_Valid)
begin

case(PAR_TYP)

1'b0 : begin

par_bit <= (^P_DATA);

end

1'b1 : begin

par_bit <= !(^P_DATA);

end

endcase
end
end

endmodule