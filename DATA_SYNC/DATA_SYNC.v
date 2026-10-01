module DATA_SYNC #(parameter bus_width = 8 , stages = 2) (
    input wire clk , rst , bus_enable  ,
    input wire [bus_width - 1 : 0] unsync_bus ,
    output  reg [bus_width - 1 : 0] sync_bus ,
    output reg enable_pulse
);

reg [0 : stages - 1] multi_flops;
reg enable_flop;
wire pulse_gen_out;
wire [bus_width-1 : 0] mux_out;

always@(posedge clk or negedge rst) begin
    if(!rst) begin
        multi_flops <= 'b0;
    end
    else begin
        {multi_flops[0 : stages - 1]} <= {bus_enable , multi_flops[0 : stages - 2]};
    end
end

always@(posedge clk or negedge rst) begin
    if(!rst) begin
        enable_flop <= 1'b0;
    end
    else  begin
        enable_flop <= multi_flops[stages-1];
    end
end

assign pulse_gen_out = multi_flops[stages-1]  && !enable_flop;
assign mux_out = pulse_gen_out ? unsync_bus : sync_bus;

always@(posedge clk or negedge rst) begin
    if(!rst) begin
        sync_bus <= 'b0;
        enable_pulse <= 1'b0;
    end
    else begin
        sync_bus <= mux_out;
        enable_pulse <= pulse_gen_out;
    end
end

endmodule