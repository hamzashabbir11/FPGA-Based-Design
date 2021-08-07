module qq1four_bit_test_ex3_to_bin();
reg in,clk,rst; // input as reg  
wire out;  // output as wire  
fourbexcess_3tobin mod1(out,in,clk,rst);
initial 
begin 
  clk=1'b0;   // generaring the clock 
  repeat(50) #5 clk=~clk;
end
initial 
begin
  rst=1'b0;
  #7 rst=1'b1;   // syncronous reset 
  #3 rst=1'b0;
end
initial 
begin 
  #10 in=1'b1; #10 in=1'b1;#10 in=1'b0; #10 in=1'b0;#10 in=1'b1; #10 in=1'b0;#10 in=1'b1; #10 in=1'b0;
  #10 in=1'b0; #10 in=1'b1;#10 in=1'b1; #10 in=1'b0;#10 in=1'b1; #10 in=1'b1;#10 in=1'b1; #10 in=1'b0;
  #10 in=1'b0; #10 in=1'b0;#10 in=1'b0; #10 in=1'b1;#10 in=1'b0; #10 in=1'b0;#10 in=1'b1; #10 in=1'b1;
  // 6 different excess 3 inputs to verify output 
end 
endmodule

