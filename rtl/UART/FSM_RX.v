module FSM_RX(
    input  wire PAR_EN,
    input  wire RX_IN,
    input  wire strt_glitch,
    input  wire clk,
    input  wire rst,
    input  wire [5:0] prescale,
    input  wire [5:0] edge_cnt,

    output reg dat_samp_en,
    output reg par_chk_en,
    output reg strt_chk_en,
    output reg stp_chk_en,
    output reg data_valid,
    output reg deser_en,
    output reg enable
);

reg [2:0] current_state, next_state;
reg [2:0] data_counter;

localparam idle   = 3'b000,
           start  = 3'b001,
           data   = 3'b011,
           parity = 3'b010,
           stop   = 3'b110;


always @(posedge clk or negedge rst) begin
    if(!rst)
        current_state <= idle;
    else
        current_state <= next_state;
end


always @(posedge clk or negedge rst) begin
    if(!rst) begin
        data_counter <= 3'd0;
    end

    else if(current_state == start &&
            edge_cnt == prescale - 1'b1) begin

        data_counter <= 3'd0;
    end

    else if(current_state == data &&
            edge_cnt == prescale - 1'b1) begin

        if(data_counter == 3'd7)
            data_counter <= 3'd0;
        else
            data_counter <= data_counter + 1'b1;
    end
end

always @(posedge clk or negedge rst) begin
    if(!rst) begin
        data_valid <= 1'b0;
    end

    else begin
        if(current_state == stop &&
           edge_cnt == prescale - 1'b1)

            data_valid <= 1'b1;

        else
            data_valid <= 1'b0;
    end
end

always @(*) begin

    dat_samp_en  = 1'b0;
    par_chk_en   = 1'b0;
    strt_chk_en  = 1'b0;
    stp_chk_en   = 1'b0;
    deser_en     = 1'b0;
    enable       = 1'b0;

    next_state = current_state;

    case(current_state)

        idle: begin
            if(RX_IN)
                next_state = idle;
            else
                next_state = start;
        end


        start: begin
            enable      = 1'b1;
            dat_samp_en = 1'b1;
            strt_chk_en = 1'b1;

            if(edge_cnt == prescale - 1'b1) begin
                if(strt_glitch)
                    next_state = idle;
                else
                    next_state = data;
            end
            else begin
                next_state = start;
            end
        end


        data: begin
            enable      = 1'b1;
            dat_samp_en = 1'b1;

            if(edge_cnt == prescale - 1'b1)
                deser_en = 1'b1;
            else
                deser_en = 1'b0;

            if(edge_cnt == prescale - 1'b1) begin

                if(data_counter == 3'd7) begin
                    if(PAR_EN)
                        next_state = parity;
                    else
                        next_state = stop;
                end
                else begin
                    next_state = data;
                end

            end
            else begin
                next_state = data;
            end
        end


        parity: begin
            enable      = 1'b1;
            dat_samp_en = 1'b1;
            par_chk_en  = 1'b1;
            deser_en    = 1'b0;

            if(edge_cnt == prescale - 1'b1)
                next_state = stop;
            else
                next_state = parity;
        end


        stop: begin
            enable      = 1'b1;
            dat_samp_en = 1'b1;
            stp_chk_en  = 1'b1;

            deser_en = 1'b0;

            if(edge_cnt == prescale - 1'b1) begin
                if(RX_IN)
                    next_state = idle;
                else
                    next_state = start;
            end
            else begin
                next_state = stop;
            end
        end

        default: begin
            next_state = idle;
        end

    endcase
end

endmodule
