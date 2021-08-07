//Single clk dual port RAM (Distributed RAM utilizing internal resources
module RAM_32B(clk,write_sig,address_w,address_r,data_in,data_out);
input clk, write_sig;
input [4:0] address_w;
input [4:0] address_r;
input [7:0] data_in;
output [7:0] data_out;
parameter ram_width = 8;
parameter add_bits = 5;

reg [7:0] RAM_MEM[(2**add_bits)-1:0]; // 0 to 31  so 32B RAM 
always @(posedge clk)
begin 
  if (write_sig)
     RAM_MEM[address_w] <=data_in;
end 

assign data_out = RAM_MEM[address_r];
endmodule 

 
