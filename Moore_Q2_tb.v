module moore_Q230s(); 
reg IN,CLOCK,RESET;
wire OUT;
reg[15:0] sequence;
integer i;
moore_30s M1(OUT,IN,CLOCK,RESET);

initial
begin
CLOCK=1'b0;
RESET=1'b1;
sequence=16'b111111111111111; // input sequence this should show our output three times
#5 RESET=1'b0;
for (i=0; i<=15; i=i+1) begin
IN=sequence[i];
#5 CLOCK=1'b1;
#5 CLOCK=1'b0;
end
end
endmodule



