module prescale_mux(
    input wire [5:0] prescale,
    output reg [2:0] div_ratio
);

always@(*) begin
    case(prescale)
        6'd32: div_ratio = 3'd1;
        6'd16: div_ratio = 3'd2;
        6'd8 : div_ratio = 3'd4;
        default: div_ratio = 3'd1;
    endcase
end

endmodule
