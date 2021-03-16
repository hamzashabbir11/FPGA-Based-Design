module half_add (c,s,a,b);
output c,s;
input a,b;
xor (s,a,b);
and (c,a,b);
endmodule

module Full_add (C_out,S,A,B,c_in);
input A,B, c_in;
output C_out,S;
wire w1,w2,w3;
half_add HA0(w1,w2,A,B);
half_add HA1(w3,S,c_in,w2);
or (C_out,w3,w1);
endmodule


module full_add3 (Carry,Sum,A,B,Cin);
output[2:0] Sum;
output Carry;
input[2:0] A,B;
input Cin;
wire[1:0] w;
Full_add FA0(.C_out(w[0]),.S(Sum[0]),.A(A[0]),.B(B[0]),.c_in(Cin));
Full_add FA1(.C_out(w[1]),.S(Sum[1]),.A(A[1]),.B(B[1]),.c_in(w[0]));
Full_add FA2(.C_out(w[Carry]),.S(Sum[2]),.A(A[2]),.B(B[2]),.c_in(w[1]));
endmodule 
 
module full_adder9 (Carryout,sum,A,B,Carryin);
output [8:0]sum;
output Carryout;
input [8:0] A,B;
input Carryin;
wire [1:0] w; 
full_add4 FA31(.Carry(w[0]),.Sum(sum[2:0]),.B(B[2:0]),.A(A[2:0]),.Cin(Carryin));
full_add4 FA32(.Carry(w[1]),.Sum(sum[5:3]),.B(B[5:3]),.A(A[5:3]),.Cin(w[0]));
Full_add  FA33(.C_out(Carryout),.S(sum[8:6]),.A(A[8:6]),.B(B[8:6]),.c_in(w[1]));
endmodule 

