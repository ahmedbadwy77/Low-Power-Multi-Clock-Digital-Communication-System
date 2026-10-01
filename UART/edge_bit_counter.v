module edge_bit_counter(
    input wire enable , clk , rst ,
    input wire [5:0] prescale,
    output wire [5:0] edge_cnt
);
reg [5:0] edges_counter;
wire [5:0] half_data_bit;

always@(posedge clk or negedge rst) begin
    if(!rst) begin
        edges_counter <= 6'd0;
    end
    else if (enable) begin
        if (edges_counter == prescale - 1'b1) begin
            edges_counter <= 6'd0;
        end
        else begin
            edges_counter  <= edges_counter + 1'b1;
        end
    end
end

assign edge_cnt = edges_counter;

endmodule