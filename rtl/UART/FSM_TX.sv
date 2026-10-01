module FSM_TX(
input wire Data_Valid , PAR_EN , ser_done, clk , rst,
output reg ser_en , busy,
output reg [1:0] mux_sel
);

localparam s0 = 2'b00 ,s1 = 2'b01 ,s2 = 2'b10 ,s3 = 2'b11 ;

typedef enum bit [2:0] {idle = 3'b000 ,
start = 3'b001 , data = 3'b011 , parity = 3'b010 , stop = 3'b110}state_e;

state_e current_state , next_state;

always@(posedge clk or negedge rst)
begin

if(!rst)
current_state <= idle;

else
current_state <= next_state;

end

always@(*)
begin

busy    = 1'b0;
ser_en  = 1'b0;
mux_sel = s1;

case(current_state)

idle : begin

if(Data_Valid)
begin
busy = 1'b0;
ser_en = 1'b0;
mux_sel = s1;
end

else
begin
busy = 1'b0;
ser_en = 1'b0;
mux_sel = s1;
end
end

start : begin
busy = 1'b1;
ser_en = 1'b1;
mux_sel = s0;
end

data : begin
busy = 1'b1;
mux_sel = s2;
if (ser_done)
ser_en = 1'b0;
else
ser_en = 1'b1;
end

parity : begin
busy = 1'b1;
ser_en = 1'b0;
mux_sel = s3;
end

stop : begin
busy = 1'b1;
ser_en = 1'b0;
mux_sel = s1;
end

default : begin
ser_en = 1'b0;
busy = 1'b0;
mux_sel = s1;
end

endcase
end

always@(*) begin
case(current_state)

idle : begin
if(Data_Valid)
next_state = start ;
else
next_state = idle;
end

start : begin
next_state = data;
end

data : begin
if(!ser_done)
next_state = data;
else if (PAR_EN)
next_state = parity;
else
next_state = stop;
end

parity : begin
next_state = stop;
end

stop : begin
next_state = idle;
end

default : begin
next_state = idle;
end
endcase
end
endmodule