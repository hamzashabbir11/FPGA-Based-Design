module mealy(out,in,clock,reset);
output out;
reg out;
input in,clock,reset;
reg[2:0] previous_state, next_state;
parameter s0=3'b000, s1=3'b001, s2=3'b010, s3=3'b011, s4=3'b100;

always @(posedge clock)
if (reset)
previous_state=s0;
else
previous_state=next_state;

always @(previous_state or in)
case (previous_state)
s0: begin
if(in) begin
next_state=s1;
out=1'b0;
end
else begin
next_state=s0;
out=1'b0;
end
end
 
s1: begin
if(~in) begin
next_state=s2;
out=1'b0;
end
else begin
next_state=s1;
out=1'b0;
end
end

s2: begin
if(~in) begin
next_state=s3;
out=1'b0;
end
else begin
next_state=s0;
out=1'b0;
end
end

s3: begin
if(in) begin
next_state=s4; 
out=1'b0;
end
else begin
next_state=s0;
out=1'b0;
end
end

s4: begin
if(in) begin
next_state=s1; 
out=1'b1;
end
else begin
next_state=s2;
out=1'b0;
end
end



default: begin
next_state=s0;
out=1'b0;
end
endcase
endmodule

