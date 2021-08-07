module fifo_test();
parameter rw=8;
parameter ab=5;
reg c, re, ws, rs;
reg[rw-1:0] in;
wire fs, es, of, uf;
wire[rw-1:0] o;
integer i;
fifo F1(c,re,ws,rs,i,fs,es,of,uf,o);

initial 
begin
c=1'b0;
re=1'b0;
ws=1'b0;
rs=1'b0;
i=8'b0;
#25
re=1'b1;

for(i=0; i<=(2**ab)-1; i=i+1) begin
#25 ws=1'b1;
    in=i;
end
#25 ws=1'b0;

for(i=0; i<=(2**ab)-1; i=i+1) begin
#25 rs=1'b1;
end
#25 rs=1'b0;

for(i=0; i<=(2**ab)-1; i=i+1) begin
#25 ws=1'b1;
    in=i;
end
#25 ws=1'b0;

for(i=0; i<=(2**ab)-1; i=i+1) begin
#25 rs=1'b1;
end
#25 rs=1'b0;

for(i=0; i<=(2**ab)-1; i=i+1) begin
#25 ws=1'b1;
#25 rs=1'b1;
    in=i;
end
#25 ws=1'b0;
#25 rs=1'b0;

for(i=0; i<=(2**ab)-1; i=i+1) begin
#25 rs=1'b1;
end
#25 rs=1'b0;

for(i=0; i<=(2**ab)-1; i=i+1) begin
#25 ws=1'b1;
    in=i;
end
#25 ws=1'b0; rs=1'b0;
#10 re=1'b1;
#1000 $stop;
end
always #25 c=~c;
endmodule



