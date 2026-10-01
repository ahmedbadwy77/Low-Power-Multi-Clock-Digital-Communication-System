module regfile(
input wire WrEn , RdEn , clk , rst ,
input wire [7:0] WrData ,
input wire [3:0] Address ,
output reg [7:0] RdData ,
output reg Rd_Data_Valid ,
output wire [7:0] REG0 , REG1 , REG2 , REG3
);

reg [7:0] Registers [15:0];
integer i;

always @(posedge clk or negedge rst) begin
    if(!rst) begin
        Rd_Data_Valid <= 1'b0;
        RdData <= 8'b0;
        for(i = 0 ; i < 16 ;i = i + 1) begin
            if(i == 2) begin
                Registers[2] <= 8'b10000001;
            end
            else if (i == 3) begin
                Registers[3] <= 8'b00100000;
            end
            else begin
                Registers[i] <= 8'b0;
            end
        end
    end
    else if (WrEn && !RdEn) begin
        Registers[Address] <= WrData;
    end
    else if (RdEn && !WrEn) begin
        RdData <= Registers[Address];
        Rd_Data_Valid <= 1'b1;
    end
    else begin
        Rd_Data_Valid <= 1'b0;
    end
end

assign REG0 = Registers[0];
assign REG1 = Registers[1];
assign REG2 = Registers[2];
assign REG3 = Registers[3];

endmodule
