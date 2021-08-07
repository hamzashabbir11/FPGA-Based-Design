module nrz_test();
reg IN,CLOCK,RESET;
wire OUT;
nrztomanchester M1(OUT,IN,CLOCK,RESET);
initial
begin
CLOCK=1'b0;
repeat(50) #5 CLOCK=~CLOCK;
end
initial 
begin 
RESET=1'b0;
#7 RESET=1'b1;
#3 RESET=1'b0;
end
initial
begin
IN=1'b1;
repeat(20) #6 IN=~IN; 
end
endmodule






