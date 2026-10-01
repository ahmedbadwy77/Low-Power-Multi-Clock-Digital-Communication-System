module deserializer(
    input wire deser_en,
    input wire majority_bit,
    input wire clk,
    input wire rst,
    output reg [7:0] P_DATA
);

reg [3:0] counter;
reg [7:0] data;

always @(posedge clk or negedge rst) begin

    if(!rst) begin
        P_DATA <= 8'b0;
        counter <= 4'b0;
        data <= 8'b0;
    end

    else if(deser_en) begin

        if(counter == 4'd7) begin

            data[7] <= majority_bit;
            P_DATA  <= {majority_bit, data[6:0]};
            counter <= 4'd0;

        end

        else begin

            data[counter] <= majority_bit;
            counter <= counter + 1'b1;

        end

    end

end

endmodule