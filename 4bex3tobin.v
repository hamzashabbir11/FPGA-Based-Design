module fourbexcess_3tobin(out,in,clock,reset);
input in,clock,reset;
output out;
reg out;
reg[3:0]  pstate, nstate;
parameter s0=4'd0, s1=4'd1, s2=4'd2, s3=4'd3, s4=4'd4,s5=4'd5, s6=4'd6, s7=4'd7, s8=4'd8,
  s9=4'd9, s10=4'd10; // s11=4'd11,s12=4'12;
//parameter s0=4'b0000, s1=4'b0001, s2=4'b0010, s3=4'b0011, s4=4'b0100,s5=4'b0101, s6=4'b0110, s7=4'b0111, s8=4'b1000,
 //s9=4'b1001, s10=4'b1010, s11=4'b1011,s12=4'b1100;
always @(posedge clock )
if (reset)
pstate=s0;
else pstate=nstate;         
always @(pstate or in)
case (pstate)
s0: if(~in) nstate=s1; else  nstate=s2;  // sequuencial logic according to our state machine digram 
s1: if(~in) nstate=s3; else  nstate=s4;   
s2: if(~in) nstate=s4; else  nstate=s5; 
s3: if(~in) nstate=s6; else  nstate=s7; 
s4: if(~in) nstate=s6; else  nstate=s7; 
s5: if(~in) nstate=s7; else  nstate=s8; 
s6: if(in)  nstate=s9;  
s7: if(~in) nstate=s9; else  nstate=s10; 
s8: if(in)  nstate=s10; 
s9: if(~in) nstate=s1; else  nstate=s2; 
s10: if(~in)nstate=s1; else  nstate=s2;  
  default: nstate=s0; 
endcase
always @( pstate)  // output logic depend on preveous state as this is moore machine 
begin              // output logic depending upon state diagram 
  if(pstate==s1)
    out=1'b1;
  else if(pstate==s2)
    out=1'b0;
  else if(pstate==s3)
    out=1'b0;
  else if(pstate==s4)
    out=1'b1;
  else if(pstate==s5)
    out=1'b0;
  else if(pstate==s6)
    out=1'b1;
  else if(pstate==s7)
    out=1'b0;
  else if(pstate==s8)
    out=1'b1;
  else if(pstate==s9)
    out=1'b0;
  else if(pstate==s10)
    out=1'b1;
  end
endmodule

