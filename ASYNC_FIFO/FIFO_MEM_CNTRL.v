module FIFO_MEM_CNTRL #(parameter data_width = 8)(
    input wire wclken , wclk , wrst_n ,
    input wire [data_width-1 : 0] wdata ,
    input wire [2:0] waddr , raddr,
    output wire [data_width-1 : 0]rdata
);

reg [data_width-1 : 0] fifo_mem [7:0];
integer i;

assign rdata = fifo_mem[raddr];

always@(posedge wclk or negedge wrst_n) begin
    if(!wrst_n) begin
        for (i = 0 ; i <= 7 ; i = i + 1) begin
            fifo_mem[i] <= 8'b0;
        end
    end
    else begin
        if(wclken) begin
            fifo_mem[waddr] <= wdata;
        end
    end
end

endmodule