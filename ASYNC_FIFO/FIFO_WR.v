module FIFO_WR(
    input wire winc,
    input wire wrst_n,
    input wire wclk,
    input wire [3:0] wq2_rptr,

    output wire [2:0] waddr,
    output wire [3:0] wptr_gray,
    output wire wfull
);

reg [3:0] wcounter;
reg [3:0] wptr_gray_reg;
reg wfull_reg;

wire [3:0] wcounter_gray_next;

wire [3:0] wcounter_next =
    (winc && !wfull_reg) ? wcounter + 4'd1 : wcounter;

assign wcounter_gray_next =
    wcounter_next ^ (wcounter_next >> 1'b1);


always @(posedge wclk or negedge wrst_n) begin

    if(!wrst_n) begin
        wcounter      <= 4'b0;
        wptr_gray_reg <= 4'b0;
        wfull_reg     <= 1'b0;
    end

    else begin

        wcounter <= wcounter_next;
        wptr_gray_reg <= wcounter_gray_next;

        if((wq2_rptr[3] != wcounter_gray_next[3]) &&
           (wq2_rptr[2] != wcounter_gray_next[2]) &&
           (wq2_rptr[1:0] == wcounter_gray_next[1:0])) begin

            wfull_reg <= 1'b1;
        end

        else begin
            wfull_reg <= 1'b0;
        end
    end
end


assign wptr_gray = wptr_gray_reg;
assign waddr     = wcounter[2:0];
assign wfull     = wfull_reg;

endmodule
