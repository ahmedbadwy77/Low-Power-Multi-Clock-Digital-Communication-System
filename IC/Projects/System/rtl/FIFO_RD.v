module FIFO_RD (
    input  wire rinc,
    input  wire rclk,
    input  wire rrst_n,
    input  wire [3:0] rq2_wptr,
    output wire rempty,
    output wire [2:0] raddr,
    output wire [3:0] rptr_gray
);

reg [3:0] rcounter;
reg [3:0] rptr_gray_reg;
reg rempty_reg;

wire [3:0] rcounter_next =
    rcounter + 4'd1;

wire [3:0] rcounter_gray_next =
    rcounter_next ^ (rcounter_next >> 1);

always @(posedge rclk or negedge rrst_n) begin

    if (!rrst_n) begin
        rcounter     <= 4'b0;
        rptr_gray_reg <= 4'b0;
        rempty_reg   <= 1'b1;
    end

    else begin

        if (rinc && (rq2_wptr != rptr_gray_reg)) begin
            rcounter      <= rcounter_next;
            rptr_gray_reg <= rcounter_gray_next;
        end

        if (rinc && (rq2_wptr == rcounter_gray_next)) begin
            rempty_reg <= 1'b1;
        end
        else if (rq2_wptr == rptr_gray_reg) begin
            rempty_reg <= 1'b1;
        end
        else begin
            rempty_reg <= 1'b0;
        end
    end
end

assign rptr_gray = rptr_gray_reg;
assign raddr     = rcounter[2:0];
assign rempty    = rempty_reg;

endmodule
