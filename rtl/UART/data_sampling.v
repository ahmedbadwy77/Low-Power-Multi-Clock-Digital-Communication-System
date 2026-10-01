module data_sampling(
    input wire [5:0] edge_cnt,
    input wire [5:0] prescale,
    input wire dat_samp_en, clk , rst ,
    input wire RX_IN ,
    output wire majority_bit
);

wire [5:0] half_data_bit;
reg first_sample , second_sample , third_sample;
assign half_data_bit = prescale >> 1;
assign majority_bit =(first_sample & second_sample) | (first_sample & third_sample)  | (second_sample & third_sample);

always@(posedge clk or negedge rst) begin
    if(!rst) begin
        first_sample <= 1'b0;
        second_sample <= 1'b0;
        third_sample <= 1'b0;
    end
    else if (dat_samp_en) begin
        case(edge_cnt)
        half_data_bit - 1'b1 : first_sample <= RX_IN;
        half_data_bit : second_sample <= RX_IN;
        half_data_bit + 1'b1 : third_sample <= RX_IN;
        endcase
    end
    end
endmodule
