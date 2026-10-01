module stop_checker(
    input wire stp_chk_en , strt_chk_en , clk , rst , majority_bit ,
    input wire [5:0] prescale,
    input wire [5:0] edge_cnt,
    output reg stp_err
);

always@(posedge clk or negedge rst) begin
    if(!rst) begin
        stp_err <= 1'b0;
    end
    else if(strt_chk_en)
        stp_err <= 1'b0;
    else if (stp_chk_en && (edge_cnt == prescale - 2'd2)) begin
        stp_err <= majority_bit != 1'b1;
    end
end

endmodule