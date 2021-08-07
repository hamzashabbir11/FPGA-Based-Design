module mealy30s(out,in,clock,reset); // port declarition 
output out;
reg out; // output defined as reg 
input in,clock,reset;
reg[2:0] pstate, nstate; // reg to store the states
parameter s0=4'b000, s1=4'b001, s2=4'b010; // 3 bits for Mealy 

always @(posedge clock) // always block to implemrnt the stste logic accroding to stste diagram

if (reset)
pstate=s0; 
else
pstate=nstate;

always @(pstate or in) // output depends on both input and previous state
case (pstate)

s0: begin
if(~in) begin 
nstate=s1;
out<=1'b0; // in every case now we will send out output 
end
else begin 
nstate=s0;
out<=1'b0;
end
end

s1: begin
if(~in) begin 
nstate=s2;
out<=1'b0;
end
else begin 
nstate=s0;
out<=1'b0;
end
end

s2: begin
if(~in) begin 
nstate=s0;
out<=1'b1;
end
else begin 
nstate=s2;
out<=1'b0;
end
end


    

default: begin
nstate=s0;
out<=1'b0;
end
endcase

always @(pstate)
  if(out)begin 
    out=2'b11;
  end
  else begin
    out=1'b0;
  end
  
endmodule


