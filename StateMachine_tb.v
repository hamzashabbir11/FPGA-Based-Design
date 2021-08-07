module Statemachine_Test();
reg IN, CLOCK, RESET;
wire OUT;
moore M1(OUT,IN,CLOCK,RESET);

initial
begin                     // This is a syncronous design 
CLOCK=1'b0;
repeat(50) #5 CLOCK=~CLOCK;
end

initial 
begin 
RESET=1'b0;   // Asyncronous reset 
#3 RESET=1'b1;
#3 RESET=1'b0;
end

initial
begin
#10 IN=1'b0; #10 IN=1'b0; #10 IN=1'b1; #10 IN=1'b1; #10 IN=1'b0; #10 IN=1'b0;
#10 IN=1'b1; #10 IN=1'b0; #10 IN=1'b1; #10 IN=1'b0; #10 IN=1'b0; #10 IN=1'b1;
#10 IN=1'b0; #10 IN=1'b0; #10 IN=1'b1; #10 IN=1'b1; #10 IN=1'b0; #10 IN=1'b0;
#10 IN=1'b0; #10 IN=1'b1; #10 IN=1'b1; #10 IN=1'b1; #10 IN=1'b0; #10 IN=1'b0;
#10 IN=1'b0; #10 IN=1'b1; #10 IN=1'b0; #10 IN=1'b1; #10 IN=1'b1; #10 IN=1'b1;
#10 IN=1'b0; #10 IN=1'b1;
end
endmodule


