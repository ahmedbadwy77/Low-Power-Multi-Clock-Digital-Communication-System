module CLK_GATE #(
    parameter SYNTHESIS = 0
)(
    input wire clk,
    input wire clk_en,
    output wire gated_clk
);

generate
    if (SYNTHESIS) begin : GEN_SYNTHESIS
        TLATNCAX2M U0 (
            .CK(clk),
            .E(clk_en),
            .ECK(gated_clk)
        );
    end
    else begin : GEN_SIMULATION
        reg latch;

        always @(clk or clk_en) begin
            if (!clk) begin
                latch <= clk_en;
            end
        end

        assign gated_clk = clk && latch;
    end
endgenerate

endmodule
