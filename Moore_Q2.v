module moore_30s(out,in,clock,reset); // My sequence is 3 0's w/o overlap 
output out;
reg out;  // declared output as reg
input in,clock,reset;
reg[3:0] pstate, nstate;  // 4 bits to store the stated 
parameter s0=4'b000, s1=5'b001, s2=5'b010, s3=5'b011;

always @(posedge clock)
if (reset)
pstate=s0; 
else
pstate=nstate;

always @(pstate or in)
case (pstate)
s0: if(~in) nstate=s1; else nstate=s0;   // cases according to our state machine diagram 
s1: if(~in) nstate=s2; else nstate=s0;
s2: if(~in) nstate=s3; else nstate=s2;
s3: if(~in) nstate=s1; else nstate=s0;

default: nstate=s0;
endcase

always @(posedge clock)  // sending the output at s3 when 
begin                    // our desired sequence is detected 
if (pstate==s3)
out=1'b1;
else
out=1'b0;
end
endmodule

