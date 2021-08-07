module mealy(out,in,clk,reset);
  input in,clk,reset;
  reg out;
  output out;
  reg [2:0] pstate,nstate;
  parameter s0=3'b000,s1=3'b001,s2=3'b010,s3=3'b011,s4=3'b100,s5=3'b101;
  
  always @(posedge clk)
  if (reset)
    pstate=s0;
  else
    pstate=nstate;
    
  always @(pstate or in)
  case (pstate)
    s0: begin 
      if (in) begin
        nstate=s1;
        out=1'b0
      end
    else begin 
      nstte=s0;
      out=1'b0;
    end
  end
  
    s0: begin 
      if (in) begin
        nstate=s1;
        out=1'b0
      end
    else begin 
      nstte=s0;
      out=1'b0;
    end
  end
  
    s1: begin 
      if (in) begin
        nstate=s1;
        out=1'b0
      end
    else begin 
      nstte=s0;
      out=1'b0;
    end
  end
  
    s2: begin 
      if (in) begin
        nstate=s1;
        out=1'b0
      end
    else begin 
      nstte=s0;
      out=1'b0;
    end
  end
  
    s3: begin 
      if (in) begin
        nstate=s1;
        out=1'b0
      end
    else begin 
      nstte=s0;
      out=1'b0;
    end
  end
  
    s4: begin 
      if (in) begin
        nstate=s1;
        out=1'b0
      end
    else begin 
      nstte=s0;
      out=1'b0;
    end
  end
  
    s5: begin 
      if (in) begin
        nstate=s1;
        out=1'b0
      end
    else begin 
      nstte=s0;
      out=1'b0;
    end
  end
  
  default:begin 
    nstate=s0;
    out=1'b0;
  end
endcase 
endmodule 
  
    
    
  
    
    
