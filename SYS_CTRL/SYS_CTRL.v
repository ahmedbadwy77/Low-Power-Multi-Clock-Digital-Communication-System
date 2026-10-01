module SYS_CTRL(
    input wire [7:0] Rd_D , sync_bus,
    input wire Rd_D_Vld , clk , rst , out_valid,
                enable_pulse , FIFO_FULL,
    input wire [15:0] ALU_OUT,
    output reg[3:0] Addr , FUN,
    output reg en , WrEn , RdEn , Gate_EN , WR_INC , clk_div_en,
    output reg [7:0] Wr_D , WR_DATA
);

reg [3:0] current_state , next_state;
reg [7:0] command;
reg [3:0] addr_reg;

localparam idle = 4'b0000,
           Address = 4'b0001,
           data_write = 4'b0011,
           data_read = 4'b0010,
           send_to_fifo = 4'b0110,
           ALU_state = 4'b0100,
           write_A = 4'b0101,
           write_B = 4'b0111,
           send_MSB = 4'b1000,
           send_LSB = 4'b1001;

always@(posedge clk or negedge rst) begin
    if(!rst) begin
        current_state <= idle;
        command <= 8'b0;
        addr_reg <= 4'b0;
    end
    else begin
        current_state <= next_state;

        if(enable_pulse) begin
            if((sync_bus == 8'hAA) ||
               (sync_bus == 8'hBB) ||
               (sync_bus == 8'hCC) ||
               (sync_bus == 8'hDD))
                command <= sync_bus;

            if(current_state == Address)
                addr_reg <= sync_bus[3:0];
        end
    end
end

always@(*) begin
    next_state = current_state;

    Addr = addr_reg;
    FUN = 4'b0;
    en = 1'b0;
    WrEn = 1'b0;
    RdEn = 1'b0;
    Gate_EN = 1'b0;
    WR_INC = 1'b0;
    clk_div_en = 1'b1;
    Wr_D = 8'b0;
    WR_DATA = 8'b0;

    case(current_state)

    idle : begin
        if(enable_pulse) begin
            case(sync_bus)

            8'hAA : begin
                next_state = Address;
            end

            8'hBB : begin
                next_state = Address;
            end

            8'hCC : begin
                next_state = write_A;
            end

            8'hDD : begin
                next_state = ALU_state;
            end

            default : begin
                next_state = idle;
            end

            endcase
        end
        else begin
            next_state = idle;
        end
    end

    Address : begin
        if(enable_pulse && command == 8'hAA) begin
            next_state = data_write;
        end
        else if(enable_pulse && command == 8'hBB) begin
            Addr = sync_bus[3:0];
            RdEn = 1'b1;
            next_state = send_to_fifo;
        end
        else begin
            next_state = Address;
        end
    end

    data_write : begin
        if(enable_pulse && command == 8'hAA) begin
            WrEn = 1'b1;
            Addr = addr_reg;
            Wr_D = sync_bus;
            next_state = idle;
        end
        else begin
            next_state = data_write;
        end
    end

    data_read : begin
        next_state = send_to_fifo;
    end

    send_to_fifo : begin
        if(Rd_D_Vld && !FIFO_FULL) begin
            WR_DATA = Rd_D;
            WR_INC = 1'b1;
            next_state = idle;
        end
        else begin
            next_state = send_to_fifo;
        end
    end

    write_A : begin
        if(enable_pulse) begin
            WrEn = 1'b1;
            Addr = 4'b0000;
            Wr_D = sync_bus;
            next_state = write_B;
        end
        else begin
            next_state = write_A;
        end
    end

    write_B : begin
        if(enable_pulse) begin
            WrEn = 1'b1;
            Addr = 4'b0001;
            Wr_D = sync_bus;
            next_state = ALU_state;
        end
        else begin
            next_state = write_B;
        end
    end

    ALU_state : begin
        if(enable_pulse) begin
            FUN = sync_bus[3:0];
            en = 1'b1;
            Gate_EN = 1'b1;
            next_state = send_MSB;
        end
        else begin
            next_state = ALU_state;
        end
    end

    send_MSB : begin
        if(out_valid && !FIFO_FULL) begin
            WR_DATA = ALU_OUT[15:8];
            WR_INC = 1'b1;
            next_state = send_LSB;
        end
        else begin
            next_state = send_MSB;
        end
    end

    send_LSB : begin
        if(!FIFO_FULL) begin
            WR_DATA = ALU_OUT[7:0];
            WR_INC = 1'b1;
            next_state = idle;
        end
        else begin
            next_state = send_LSB;
        end
    end

    default : begin
        next_state = idle;
    end

    endcase
end

endmodule
