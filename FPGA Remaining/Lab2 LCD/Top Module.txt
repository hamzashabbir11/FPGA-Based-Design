`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:48:32 06/29/2021 
// Design Name: 
// Module Name:    LCDTopModule 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/1ps
module digital_watch_lcd_core (// Port List
CLK,
reset_1 ,
enable,
LED,
LCD_RS ,
LCD_RW ,
LCD_E,
SF_D,
SF_CE0
);
//---- Port Declarations ----
input CLK;
input reset_1 ;
input  enable;
output [7:0] LED;
output LCD_RS ;
output LCD_RW ;
output LCD_E;
output [11:8] SF_D;
output SF_CE0 ;
//-- Intermediate signals declaration
reg [7:0] LcdChar ;
wire [7:0] LcdIndex ;
wire [3:0] seconds_least, seconds_most,min_least,min_most,hours_least,hours_most ;
assign SF_CE0 = 1'b1;
assign LED = {min_least,min_most} ;
always @(LcdIndex or  seconds_least or seconds_most or min_least or min_most or hours_least or hours_most)
begin
case (LcdIndex )
8'h00 : LcdChar = 8'h54; //-- char T (First line 1st char)
8'h01 : LcdChar = 8'h69; //-- char i
8'h02 : LcdChar = 8'h6d; //-- char m
8'h03 : LcdChar = 8'h65; //-- char e
8'h04 : LcdChar = 8'h3d; //-- char =
8'h05 : LcdChar = 8'h20; //-- char ''
8'h06 : LcdChar = {4'b0011 , hours_most [3:0]}; //-- Hours
8'h07 : LcdChar = {4'b0011 , hours_least [3:0]};
8'h08 : LcdChar = 8'h3a; //-- char :
8'h09 : LcdChar = {4'b0011 , min_most [3:0]}; //-- Min
8'h0a : LcdChar = {4'b0011 , min_least [3:0]};
8'h0b : LcdChar = 8'h3a; //-- char :
8'h0c : LcdChar = {4'b0011 , seconds_most [3:0]}; //-- Sec
8'h0d : LcdChar = {4'b0011 , seconds_least [3:0]};
8'h40 : LcdChar = 8'h50; //-- char P (second line 1st char)
8'h41 : LcdChar = 8'h41; //-- char A
8'h42 : LcdChar = 8'h4B; //-- char K
8'h43 : LcdChar = 8'h49; //-- char I
8'h44 : LcdChar = 8'h53; //-- char S
8'h45 : LcdChar = 8'h54; //-- char T
8'h46 : LcdChar = 8'h41; //-- char A
8'h47 : LcdChar = 8'h4E; //-- char N
default : LcdChar = 8'b00000000 ;
endcase
end
//-- Instantiation of the LCD Display driver
lcd_driver i_lcd_driver (// Port Connections
. Clk ( CLK ),
. rs ( LCD_RS ),
. rw ( LCD_RW ),
. enable ( LCD_E ),
. lcd_data ( SF_D ),
. index ( LcdIndex ),
. char ( LcdChar )
);
//-- Instantiation of the Digital Watch Core
digital_watch i_digital_watch_core (// Port Connections
. clk ( CLK),
. reset_1 ( reset_1 ),
. enable ( enable),
. seconds_least ( seconds_least ),
.seconds_most(seconds_most),
. min_least ( min_least ),
.min_most(min_most),
. hours_most ( hours_most),
.hours_least(hours_least)
);
endmodule



