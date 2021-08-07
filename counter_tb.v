module test_counter();
  reg clk,rst,enable;
  wire overflow;
  wire [3:0] count;
  counter C1(.clk(clk),.rst(rst),.enable(enable),.count(count),.over_flow(overflow));
  initial 
  begin 
    clk=1'b0;
    rst=1'b0;
    enable=1'b0;
    #4 rst=1'b1;
    #8 rst=1'b0;
    #12 enable=1'b1;
    #200 $stop;
    
  end
  always #5 clk =~clk;

endmodule
