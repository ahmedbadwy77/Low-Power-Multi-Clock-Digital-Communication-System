module strt_checker(
    input wire strt_chk_en , majority_bit , clk , rst ,
    output reg strt_glitch
);

always@(posedge clk or negedge rst) begin
    if(!rst) begin
        strt_glitch <= 1'b0;
    end
    else if (strt_chk_en)
    strt_glitch <= majority_bit != 1'b0;
    else
    strt_glitch <= 1'b0;
end


endmodule