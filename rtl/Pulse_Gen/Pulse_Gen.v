module Pulse_Gen #(parameter stages = 2)(
    input wire clk , rst,
    input wire async,
    output reg sync
);

reg [stages-1:0] sync_reg;
reg sync_d;

always@(posedge clk or negedge rst) begin
    if(!rst) begin
        sync_reg <= 0;
        sync_d <= 0;
        sync <= 0;
    end
    else begin
        if(stages == 1)
            sync_reg <= async;
        else
            sync_reg <= {sync_reg[stages-2:0],async};

        sync_d <= sync_reg[stages-1];
        sync <= sync_reg[stages-1] & !sync_d;
    end
end

endmodule
