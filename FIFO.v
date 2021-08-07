//module for 32 bit FIFO memory
module fifo (clk,reset,write_signal,read_signal,in,full_signal,empty_signal,over_flow,under_flow,out);
// Declaring two constants for width of ram and no. of address bits 
parameter ram_width=8;
parameter address_bits=5;
//Defining inputs and outputs
input clk,reset,write_signal,read_signal;
input[ram_width-1:0] in;
output full_signal,empty_signal,over_flow,under_flow;
output[ram_width-1:0] out;
// Defining variables which will be used inside the module
parameter depth=32;
reg[address_bits-1:0] write_pointer, read_pointer, difference_pointer;
wire full_signal, empty_signal, over_flow, under_flow;

//First always block sensitive at positive edge of clock in which conditions for write signal are defined
always @(posedge clk)
begin
if(reset)
write_pointer<=0;
else if (write_signal)
write_pointer<=write_pointer+1;
else
write_pointer<=write_pointer;
end

//Second always block also sensitive at positive edge of clock defining conditiond for read signal
always @(posedge clk)
begin
if(reset)
read_pointer<=0;
else if (read_signal)
read_pointer<=read_pointer+1;
else
read_pointer<=read_pointer;
end

//Last always block used to find difference between read and write pointer which will be used later to find wether we are in read or write mode.
always @(posedge clk)
begin
if (write_pointer>read_pointer)
difference_pointer=write_pointer-read_pointer;
else
difference_pointer=depth-read_pointer+write_pointer;
end

//In the last assigning values to full signal, empty signal, overflow signal and underflow signal.
assign full_signal=(difference_pointer==depth-1);
assign empty_signal=(difference_pointer==0);
assign over_flow=(full_signal&write_signal);
assign under_flow=(empty_signal&read_signal);

//This the the ram module previously made and now called out here to serve as memory.
RAM_32B #(8,5) RAM_32B(.data_out(out),.address_w(write_pointer),.address_r(read_pointer),.clk(clk),.data_in(in),.write_sig(write_signal));
endmodule


