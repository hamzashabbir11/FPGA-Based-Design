module counter(clk,enable,rst,over_flow,count);
  parameter max=9;
  parameter bits=4;
  input clk,enable,rst;
  output reg over_flow ;
  output reg [bits-1:0] count;
  always @ (posedge clk)
  if(rst)
    begin 
      count=0; over_flow=0;
      end
  else if(enable)
    if (count==max)
    begin over_flow=1;
      count=0;
    end
    else begin
    count=count+1;
    over_flow=0;
    end                                                                
endmodule
      
module second(clk,enable,rst,count_secMost,count_secLeast);
input clk,enable,rst;
output [3:0] count_secLeast;
output [3:0] count_secMost;

wire w1;//overflow
counter #(2,2) cc2(.clk(clk),.enable(w1),.over_flow(w1),.rst(rst),.count(count_secMost[3:0])); 
counter #(9,4) cc1(.clk(clk),.enable(enable),.over_flow(w1),.rst(rst),.count(count_secLeast[3:0]));
counter #(5,4) cc3(.clk(clk),.enable(w1),.over_flow(w1),.rst(rst),.count(count_secMost[3:0]));

endmodule
    

module DigiClk(clk,rst,enable,sec,min,hour);
  input clk,rst,enable;
  output [7:0] sec,min,hour;
  endmodule 




