timescale 1ns/1ps
module digital_watch_lcd_core (// Port List
 CLK,
 BTN_SOUTH ,
 SW,
 LED,
 
 LCD_RS,
 LCD_RW,
 LCD_E,
 SF_D,
 SF_CE0
 );
//---- Port Declarations ----
input CLK;
input BTN_SOUTH ;
input [3:0] SW;
output [7:0] LED; 
output LCD_RS;
output LCD_RW;
output LCD_E;
output [11:8] SF_D;
output SF_CE0;
//-- Intermediate signals declaration
reg [7:0] LcdChar ;
wire [7:0] LcdIndex ;
wire [7:0] sec_out  ;
 assign SF_CE0 = 1'b1;
 assign LED = min_out ;
always @(LcdIndex or  sec_out )
begin
 case (LcdIndex )
 8'h00 : LcdChar = 8'h54; //-- char T (First line 1st char)
 8'h01 : LcdChar = 8'h69; //-- char i 
 8'h02 : LcdChar = 8'h6d; //-- char m 
 8'h03 : LcdChar = 8'h65; //-- char e 
 8'h04 : LcdChar = 8'h3d; //-- char = 
 8'h05 : LcdChar = 8'h20; //-- char '' 
 8'h0b : LcdChar = 8'h3a; //-- char : 
 8'h0c : LcdChar = {4'b0011 , sec_out [7:4]}; //-- Sec 
 8'h0d : LcdChar = {4'b0011 , sec_out [3:0]}; 
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
digital_watch_core i_digital_watch_core (// Port Connections
 . CLK ( CLK),
 . rst_p ( BTN_SOUTH ),
 . enable ( SW),
 
 . sec_digits (sec_out ),
 
 );
endmodule
