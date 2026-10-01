module Serializer (
input  wire [7:0] P_DATA,
input  wire ser_en , clk , rst,

output reg ser_done , ser_data
);

reg [2:0] count;
reg [7:0] Data_In;

always @(posedge clk or negedge rst)
begin
if(!rst)
begin
Data_In <= 8'd0;
count <= 3'd0;
ser_data <= 1'b0;
ser_done <= 1'b0;
end

else if(ser_en)
begin
if(count == 3'd0)
begin
Data_In <= P_DATA;
ser_data <= P_DATA[0];
ser_done <= 1'b0;
count <= 3'd1;
end
else
begin
ser_data <= Data_In[count];
if(count == 3'd7)
begin
ser_done <= 1'b1;
count <= 3'd0;
end
else
begin
ser_done <= 1'b0;
count <= count + 3'd1;
end
end
end
else
begin
count <= 3'd0;
ser_done <= 1'b0;
end
end
endmodule