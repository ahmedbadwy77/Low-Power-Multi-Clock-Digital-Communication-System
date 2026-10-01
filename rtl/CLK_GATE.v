module CLK_GATE #(
    parameter SYNTHESIS = 0
)(
    input wire clk,
    input wire clk_en,
    output wire gated_clk
);

generate
    if (SYNTHESIS) begin : GEN_SYNTHESIS
        // Standard cell integrated clock gating latch from TSMC 130nm library
        TLATNCAX2M U0 (
            .CK(clk),
            .E(clk_en),
            .ECK(gated_clk)
        );
    end
    else begin : GEN_SIMULATION
        // Behavioral clock gating latch model for functional simulation
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
