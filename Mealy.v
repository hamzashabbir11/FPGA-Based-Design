module mealy(out,in,clk,rst);
  input in,clk,rst;
  output out;
  reg out; // output is declared as reg due to always block
  reg [2:0] pstate,nstate;
  parameter s0=3'b000, s1=3'b001, s2=3'b010, s3=3'b011, s4=3'b100, s5=3'b101; 
  
  always @(posedge clk)    // reset the machine  
  if(rst)  
  pstate=s0; 
  else 
  pstate=nstate;
  
  
  always @(pstate or in)
  case(pstate)
  s0: 
  if(~in) begin 
  nstate=s1; 
  out=1'b0;
  end
  else begin
    nstate=s0;
    out=1'b0;
  end
  
  
  s1: 
  if(~in) begin
  nstate=s2;
  out= 1'b0;
  end
  else begin
  nstate=s0;
  out=1'b0;
  end
     
  
  s2: 
  if(in) begin
  nstate=s3;
  out= 1'b0;
  end
  else begin
  nstate=s1;
  out=1'b0;
  end   
  
  s3: 
  if(in) begin
  nstate=s4;
  out= 1'b0;
  end
  else begin
  nstate=s3;
  out=1'b0;
  end   
  
  s4: 
  if(~in) begin
  nstate=s5;
  out= 1'b0;
  end
  else begin
  nstate=s3;
  out=1'b0;
  end   
  
  s5: 
  if(~in) begin
  nstate=s0;
  out= 1'b1;
  end
  else begin
  nstate=s3;
  out=1'b0;
  end   
  
  default: begin
  nstate=s0;
  out=1'b0;
  end
  

   endcase
    
endmodule
