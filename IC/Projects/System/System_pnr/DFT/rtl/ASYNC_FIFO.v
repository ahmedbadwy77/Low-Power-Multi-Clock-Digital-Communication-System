module ASYNC_FIFO #(parameter data_width = 8)(
    input wire [data_width-1 : 0] wdata ,
    input wire winc , rinc , wclk , rclk , wrst_n , rrst_n ,
    output wire [data_width-1 : 0] rdata ,
    output wire rempty , wfull
);

wire [2:0] raddr , waddr;
wire [3:0] rptr_gray , wptr_gray;
wire [3:0] rq2_wptr , wq2_rptr;

wire wclken = winc & (!wfull);

FIFO_RD U0 (.rinc(rinc) , .rempty(rempty) , .rclk(rclk) , .rrst_n(rrst_n) , .raddr(raddr) , 
            .rptr_gray(rptr_gray) , .rq2_wptr(rq2_wptr));

FIFO_WR U1 (.winc(winc) , .wclk(wclk) , .wrst_n(wrst_n) , .wfull(wfull) , .waddr(waddr) , 
            .wptr_gray(wptr_gray) , .wq2_rptr(wq2_rptr));

FIFO_MEM_CNTRL #(.data_width(data_width)) U2 (.wrst_n(wrst_n) , .wclk(wclk) , .wdata(wdata) , .waddr(waddr) ,
                    .rdata(rdata) , .wclken(wclken) , .raddr(raddr));

DF_SYNC U3 (.clk(rclk) , .rst(rrst_n) , .ptr(wptr_gray) , .sync_out(rq2_wptr));

DF_SYNC U4 (.clk(wclk) , .rst(wrst_n) , .ptr(rptr_gray) , .sync_out(wq2_rptr));

endmodule