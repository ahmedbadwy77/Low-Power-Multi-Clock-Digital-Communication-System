module CLK_DIV(
    input  wire i_ref_clk, i_rst_n, i_clk_en,
    input  wire [7:0] i_div_ratio,
    output wire o_div_clk
);

reg [7:0] edge_count;
reg [7:0] prev_div_ratio;
reg divided_clk, clk_div_en;

always @(posedge i_ref_clk or negedge i_rst_n) begin

if (!i_rst_n) begin
    edge_count <= 8'd0;
    prev_div_ratio <= 8'd0;
    divided_clk <= 1'b1;
    clk_div_en <= 1'b0;
end
else if (!i_clk_en) begin
    edge_count <= 8'd0;
    divided_clk <= 1'b1;
    clk_div_en <= 1'b0;
end
else if (i_div_ratio != prev_div_ratio) begin
    edge_count <= 8'd0;
    divided_clk <= 1'b1;
    clk_div_en <= 1'b1;
    prev_div_ratio <= i_div_ratio;
end
else if (i_div_ratio == 8'd0 || i_div_ratio == 8'd1) begin
    edge_count <= 8'd0;
    divided_clk <= 1'b1;
    clk_div_en <= 1'b1;
end
else if (!clk_div_en) begin
    edge_count <= 8'd0;
    divided_clk <= 1'b1;
    clk_div_en <= 1'b1;
end
else begin
    if (!i_div_ratio[0]) begin
        if (edge_count == (i_div_ratio >> 1) - 1'b1) begin
            edge_count <= 8'd0;
            divided_clk <= ~divided_clk;
        end
        else begin
            edge_count <= edge_count + 1'b1;
        end
    end
    else begin
        if (!divided_clk) begin
            if (edge_count == (i_div_ratio >> 1) - 1'b1) begin
                edge_count <= 8'd0;
                divided_clk <= 1'b1;
            end
            else begin
                edge_count <= edge_count + 1'b1;
            end
        end
        else begin
            if (edge_count == (i_div_ratio >> 1)) begin
                edge_count <= 8'd0;
                divided_clk <= 1'b0;
            end
            else begin
                edge_count <= edge_count + 1'b1;
            end
        end
    end
end
end

assign o_div_clk = (i_div_ratio == 8'd0 || i_div_ratio == 8'd1) ? i_ref_clk : (clk_div_en ? divided_clk : i_ref_clk);

endmodule