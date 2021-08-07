module test_ram();
parameter ram_width=8;
parameter add_bits=5;
reg clk,write_sig;
reg[add_bits-1:0] read_add,write_add;
reg[ram_width-1:0] ram_input;
reg[ram_width-1:0] memory[0:9999];
reg[ram_width-1:0] campare_mem1[0:9999];
reg[ram_width-1:0] campare_mem2[0:9999];
wire[ram_width-1:0] ram_output;

task initialize_system;
begin
clk=1'b0;
write_sig=1'b0;
write_add=5'b0;
read_add=5'b0;
ram_input=8'b0;
end
endtask

task create_data;
reg[ram_width-1:0] random_data;
integer i,data_file;
begin
data_file=$fopen("output_files/ch_data.txt");
for(i=0;i<=(2**add_bits)-1;i=i+1) begin
random_data=$random%256;
$fdisplay(data_file,"%b", random_data);
end
$fclose(data_file);
end
endtask

task write_data;
reg[ram_width-1:0] temp_data;
integer i;
begin 
$readmemb ("output_files/ch_data.txt" ,memory);
for(i=0;i<=(2**add_bits)-1;i=i+1) begin 
temp_data=memory[i];
@(posedge clk) begin 
ram_input=temp_data;
write_add=i;
write_sig=1;
end
end
@(posedge clk)
write_sig=0;
end
endtask

task read_data;
integer i,pointer;
begin 
pointer=$fopen("output_files/data_read.txt");
for(i=0;i<=(2**add_bits)-1;i=i+1) begin 
@(posedge clk) begin 
read_add=i;
#1 $fdisplay(pointer, "%b" ,ram_output);
end
end
$fclose(pointer);
end
endtask

task campare_data;
integer i,comp_pointer;
begin 
comp_pointer=$fopen("output_files/comparesion.txt");
$readmemb("output_files/ch_data.txt",campare_mem1);
$readmemb("output_files/data_read.txt",campare_mem2);
$fwrite(comp_pointer, "_____________________________________________________________");
$fwrite(comp_pointer, "Location Write Data <-- RAM --> Read Data Status\n");
$fwrite(comp_pointer, "-------------------------------------------------------------");
$display("\n\n\tLocation Write Data <----- RAM -----> Read Data Status");
for(i=0;i<=(2**add_bits)-1;i=i+1) begin 
 if(campare_mem1[i]!==campare_mem2[i]) begin 
  $fwrite(comp_pointer, "                     <-------------->                   ERROR\n" , i, campare_mem1[i]);
  $display("                         <--------------------->                       ERROR");
 end
 else begin 
  $fwrite(comp_pointer, "                        <----------------->                      OK\n" , i,campare_mem1[i]);
  $display("                      <-------------------->                        OK");
 end
end
$fclose(comp_pointer);
end
endtask

initial
begin
initialize_system;
create_data;
write_data;
read_data;
campare_data;
#1000 $stop;
end
always #25 clk=~clk;
RAM_32B R1(clk,write_sig,write_add,read_add,ram_input,ram_output);
endmodule
