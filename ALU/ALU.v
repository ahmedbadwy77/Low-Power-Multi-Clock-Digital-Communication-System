module ALU(
input wire [7:0] A , B,
input wire [3:0] ALU_FUN,
input wire clk , en , rst,
output reg [15:0] ALU_OUT,
output reg out_valid
);

reg [15:0] ALU_OUT_comb;
reg out_valid_comb;

always@(posedge clk or negedge rst) begin
    if(!rst) begin
        ALU_OUT <= 16'b0;
        out_valid <= 1'b0;
    end
    else begin
        ALU_OUT <= ALU_OUT_comb;
        out_valid <= out_valid_comb;
    end
end

always @(*) begin
    ALU_OUT_comb = 16'd0;
    out_valid_comb = 1'b0;

    if(en) begin
        out_valid_comb = 1'b1;

        case(ALU_FUN)

        4'b0000 : begin
            ALU_OUT_comb = A + B;
        end

        4'b0001 : begin
            ALU_OUT_comb = A - B;
        end

        4'b0010 : begin
            ALU_OUT_comb = A * B;
        end

        4'b0011 : begin
            if(B != 0)
                ALU_OUT_comb = A / B;
            else
                ALU_OUT_comb = 16'd0;
        end

        4'b0100 : begin
            ALU_OUT_comb = {8'b0,(A & B)};
        end

        4'b0101 : begin
            ALU_OUT_comb = {8'b0,(A | B)};
        end

        4'b0110 : begin
            ALU_OUT_comb = {8'b0,~(A & B)};
        end

        4'b0111 : begin
            ALU_OUT_comb = {8'b0,~(A | B)};
        end

        4'b1000 : begin
            ALU_OUT_comb = {8'b0,(A ^ B)};
        end

        4'b1001 : begin
            ALU_OUT_comb = {8'b0,~(A ^ B)};
        end

        4'b1010 : begin
            ALU_OUT_comb = (A == B) ? 16'd1 : 16'd0;
        end

        4'b1011 : begin
            ALU_OUT_comb = (A > B) ? 16'd2 : 16'd0;
        end

        4'b1100 : begin
            ALU_OUT_comb = (A < B) ? 16'd3 : 16'd0;
        end

        4'b1101 : begin
            ALU_OUT_comb = A >> 1;
        end

        4'b1110 : begin
            ALU_OUT_comb = A << 1;
        end

        default : begin
            ALU_OUT_comb = 16'd0;
            out_valid_comb = 1'b0;
        end

        endcase
    end
end

endmodule
