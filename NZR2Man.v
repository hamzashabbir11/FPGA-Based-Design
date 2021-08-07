module nrz2manchester (out,in,clock,reset);
output reg out; // output declared as reg 
input in,clock,reset;
reg[4:0] pstate, nstate;
parameter s0=5'b00001, s1=5'b00010, s2=5'b00100, s3=5'b01000, s4=5'b10000; // one hot design 
always @(posedge clock)
if (reset)
pstate=s0; 
else
pstate=nstate;
always @(pstate or in)  // implementing sequencial logic 
case (pstate)
s0: if(~in) nstate=s1; else nstate=s3;
s1: if(~in) nstate=s2; 
s2: if(~in) nstate=s2; else nstate=s3;
s3: if(in) nstate=s4; 
s4: if(~in) nstate=s1; else nstate=s4;
default: nstate=s0;
endcase
always @(posedge clock)
begin
if (pstate==s1)
out=1'b0;
else if (pstate==s2)
out=1'b1;
else if (pstate==s3)
out=1'b1;
else if (pstate==s4)
out=1'b0;
end
endmodule





