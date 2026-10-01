module CLK_GATE(
    input wire clk , clk_en ,
    output wire gated_clk
);
/*
reg latch;

always@(clk or clk_en) begin
    if(!clk) begin
        latch <= clk_en;
    end
end

assign gated_clk = clk  && latch;
*/

TLATNCAX2M U0(.E(clk_en) , .CK(clk) , .ECK(gated_clk));

endmodule
