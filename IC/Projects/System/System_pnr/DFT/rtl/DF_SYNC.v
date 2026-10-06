module DF_SYNC(
    input wire [3:0] ptr,
    input wire clk , rst ,
    output reg [3:0] sync_out
);

reg [3:0] sync_reg;

always@(posedge clk or negedge rst) begin
    if(!rst) begin
        sync_reg <= 4'b0;
        sync_out <= 4'b0;
    end
    else begin
        sync_reg <= ptr;
        sync_out <= sync_reg;
    end
end

endmodule