module parity_checker(
    input wire par_chk_en , strt_chk_en , PAR_TYP , rst , clk , majority_bit,
    input wire [7:0] P_DATA,
    input wire [5:0] edge_cnt,
    input wire [5:0] prescale,
    output reg par_err
);

always @(posedge clk or negedge rst)
begin
    if(!rst)
    par_err <= 1'b0 ;
    else if(strt_chk_en)
        par_err <= 1'b0;
    else if (par_chk_en && (edge_cnt == prescale - 1'b1))
    begin
        if (PAR_TYP)
        begin
            par_err <= majority_bit !=  !(^P_DATA);
        end
        else
        begin
            par_err <= majority_bit != (^P_DATA);
        end
    end

end

endmodule