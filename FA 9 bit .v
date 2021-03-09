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
half_add (w1,w2,A,B);
half_add (w3,S,w1,w2);
or (C_out,w3,w2);
endmodule


module full_add4 (Carry,Sum,A,B,Cin);
output [3:0]Sum;
output Carry ;
input [3:0]A, B; 
input Cin;
wire [3:0]w;
Full_add FA0(.C_out(w[0]),.S(Sum[0]),.A(A[0]),.B(B[0]),.c_in(Cin));
Full_add FA1(.C_out(w[1]),.S(Sum[1]),.A(A[1]),.B(B[1]),.c_in(w[0]));
Full_add FA2(.C_out(w[2]),.S(Sum[2]),.A(A[2]),.B(B[2]),.c_in(w[1]));
Full_add FA3(.C_out(Carry),.S(Sum[3]),.A(A[3]),.B(B[3]),.c_in(w[2]));
endmodule

module full_adder9 (Carryout,sum,A,B,Carryin);
output [8:0]sum;
output Carryout;
input [8:0] A,B;
input Carryin;
wire w1,w2;
full_add4 FA41(.Carry(w1),.Sum(sum[3:0]),.B(B[3:0]),.A(A[3:0]),.Cin(Carryin));
full_add4 FA42(.Carry(w2),.Sum(sum[7:4]),.B(B[7:4]),.A(A[7:4]),.Cin(w1));
Full_add FA5(.C_out(carryout),.S(sum[8]),.A(A[8]),.B(B[8]),.c_in(w2));
endmodule 