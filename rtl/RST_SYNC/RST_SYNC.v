module RST_SYNC #(parameter stages = 3) (
    input wire rst , clk ,
    output wire sync_rst
);

reg [0 : stages - 1] flops;

always@(posedge clk or negedge rst) begin
    if(!rst) begin
        flops <= 'b0;
    end
    else begin
        flops <= {1'b1 , flops[0 : stages-2]};
    end
end

assign sync_rst = flops[stages-1];

endmodule