module CLK_GATE(
    input wire clk,
    input wire clk_en,
    output wire gated_clk
);

`ifdef SYNTHESIS
    // Standard cell integrated clock gating latch from TSMC 130nm library
    TLATNCAX2M U0 (
        .CK(clk),
        .E(clk_en),
        .ECK(gated_clk)
    );
`else
    // Behavioral clock gating latch model for functional simulation
    reg latch;

    always @(clk or clk_en) begin
        if (!clk) begin
            latch <= clk_en;
        end
    end

    assign gated_clk = clk && latch;
`endif

endmodule
