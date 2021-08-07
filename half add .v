module HA(A,B,S,c);
  input A,B;
  output S,c;
  xor (S,A,B);
  and (c,A,B);
endmodule 

  


