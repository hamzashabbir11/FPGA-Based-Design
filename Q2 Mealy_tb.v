module mealyy_Q230s(); 
reg IN,CLOCK,RESET;
wire OUT;
reg[15:0] sequence;
integer i;
mealy30s M1(OUT,IN,CLOCK,RESET);

initial
begin
CLOCK=1'b0; 
RESET=1'b1; // active high reset 
sequence=16'b0001110000000111; // input sequence given to the machine six 0's will give one output 
// as without overlapping 
#5 RESET=1'b0;
for (i=0; i<=15; i=i+1) begin
IN=sequence[i];
#5 CLOCK=1'b1;
#5 CLOCK=1'b0;
end
end
endmodule




