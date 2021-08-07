// Sequence Detection using Moore Machine using FSM 
// My sequence is 001100

module moore( out_detection, in,clk,reset,);
  input in,clk,reset;  // input is  bitseqence_input
  output out_detection;
  reg out_detection; // always decare output reg when using always block i.e. behavioral modeing 
  reg [2:0] pstate,nstate;
  parameter s0=3'b000, s1=3'b001, s2=3'b010, s3=3'b011, s4=3'b100, s5=3'b101, s6=3'b111;
  
  always @(posedge clk)   // positive edge of clock is used to make previous state into next state
  if(reset)
  pstate=s0; else
  pstate=nstate;
  
  always @(pstate or in )// moore machine only depends upon previous state/current state
  case(pstate)
    s0: if(~in) nstate=s1; else nstate = s0;
    s1: if(~in) nstate=s2; else nstate = s0;
    s2: if(in) nstate=s3; else nstate = s0; // This also works if we remain at s2 
    s3: if(in) nstate=s4; else nstate = s1;
    s4: if(~in) nstate=s5; else nstate = s3;
    s5: if(~in) nstate=s6; else nstate = s3;
    s6: if(in) nstate=s0; else nstate = s1;
    default: nstate=s0; // If error in sequence then this statment will execute 
  endcase
  
  always @ (posedge clk)   // Output detection signal generating 
  if(pstate==s6) begin     // we can also not write begin end here 
    out_detection=1'b1;
  end 
  else out_detection=1'b0;
endmodule 
  
    
  


