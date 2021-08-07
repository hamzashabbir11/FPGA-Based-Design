library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


--Component lcd_driver
--    PORT(	Clk	      : IN    STD_LOGIC;
--	    rs       	: OUT   STD_LOGIC;
--          rw       	: OUT   STD_LOGIC;
--          enable   	: OUT   STD_LOGIC;
--          lcd_data 	: OUT 	 STD_LOGIC_VECTOR(3 DOWNTO 0);
--	    index	    :	OUT   std_logic_vector (7 downto 0); 
--	    char	     : IN	   std_logic_vector (7 downto 0) 
--				);
--end component;
--
--Please also connect:
--	SF_CE0   			<= '1';
--
---- Instantiation of the LCD Display driver --------------
--pLcd:			lcd_driver port map (	Clk			=> 	CLK, 
-- rs      =>  LCD_RS,
--rw      =>  LCD_RW,
--enable  =>  LCD_E,
--lcd_data=>	SF_D,
--index		=>  LcdIndex,
--char		=>  LcdChar);
--
--	with LcdIncex select
--		LcdChar 	<=	conv_std_logic_vector (68,8)	when x"00",
--									conv_std_logic_vector (68,8)	when x"01",
--									"0011" & sBcd1 (3 downto 0)   when x"02",
--									"0011" & sBcd2 (3 downto 0)   when x"40",																
--									"00000000"										when OTHERS;
--



ENTITY lcd_driver IS
    PORT(	Clk	    	: IN    STD_LOGIC;
					rs       	: OUT   STD_LOGIC;
          rw       	: OUT   STD_LOGIC;
          enable   	: OUT   STD_LOGIC;
          lcd_data 	: OUT 	STD_LOGIC_VECTOR(3 DOWNTO 0);

					index			:	OUT		std_logic_vector (7 downto 0);
					char			: IN		std_logic_vector (7 downto 0) 
				);
END lcd_driver;



--------------------------------------------------------------
ARCHITECTURE behavioral OF lcd_driver IS

--	type 		charSTATE_TYPE is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11 );
--	signal	charState : charSTATE_TYPE := S0;

	type 		charSTATE_TYPE is (I0, I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15, I16, S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11 );
	signal	charState : charSTATE_TYPE := I0;

constant	t_InstrWait	: integer := 100000;	-- 2 ms
constant 	t_WRPulse		: integer := 10;			-- 0,2 us (200 ns)
constant 	t_SetupHold	: integer := 10;			
constant 	t_DatWait		: integer := 2500;	  -- 50 us


TYPE STATE_TYPE IS (init, 
										wait_for_data,
										
										write_addrH1, write_addrH2, write_addrH3,
										write_addrL1, write_addrL2, write_addrL3,
										chk_busyI1, 
										chk_busyI2,
										write_dataH1, write_dataH2, write_dataH3,
										write_dataL1, write_dataL2, write_dataL3,
										chk_busyD1
										);

SIGNAL state : STATE_TYPE := init;

signal	sLcdAdr : STD_LOGIC_VECTOR(7 DOWNTO 0);
signal	sLcdDat : STD_LOGIC_VECTOR(7 DOWNTO 0);
signal  sLcdWR  : STD_LOGIC;
signal  sLcdRDY : STD_LOGIC;


SIGNAL int_addr : STD_LOGIC_VECTOR( 7 DOWNTO 0 );
SIGNAL int_data : STD_LOGIC_VECTOR( 7 DOWNTO 0 );
SIGNAL enrwrs 	: STD_LOGIC_VECTOR( 2 DOWNTO 0 );

-----------------------------------------------------------------------
BEGIN


pTextOut:	process (Clk)
					variable Cnt : std_logic_vector (31 downto 0);
					variable i	 : std_logic_vector ( 7 downto 0);  --integer range 0 TO 40;
					begin
						
--						index <= conv_std_logic_vector (i,8);
						index <= i;
						
						if rising_edge (CLK) then
							CASE charState IS
							
									when I0	  => 	sLcdWR 			<= '0';
																sLcdAdr 		<= x"01";  -- wait
																cnt := (others => '0');
																charState  	<= I1;
																
									when I1		=>	sLcdWR 	<= '0';
																cnt := cnt + 1 ;
																if (cnt > 800000) then    
																	charState 	<= I2;
																end if;
--- 
									when I2	  => 	sLcdAdr 		<= x"01";  -- Command 3
																sLcdDat 		<= x"03";
																sLcdWR  		<= '1';
																cnt := (others => '0');
																charState  	<= I3;
																
									when I3		=>	sLcdWR 	<= '0';
																cnt := cnt + 1 ;
																if (cnt > 250000) then    
																	charState 	<= I4;
																end if;
--- 
									when I4	  => 	sLcdAdr 		<= x"01";  -- Command 3
																sLcdDat 		<= x"03";
																sLcdWR  		<= '1';
																cnt := (others => '0');
																charState  	<= I5;
																
									when I5		=>	sLcdWR 	<= '0';
																cnt := cnt + 1 ;
																if (cnt > 5000) then    
																	charState 	<= I6;
																end if;
--- 
									when I6	  => 	sLcdAdr 		<= x"01";  -- Command 3
																sLcdDat 		<= x"03";
																sLcdWR  		<= '1';
																cnt := (others => '0');
																charState  	<= I7;
																
									when I7	=>		sLcdWR 	<= '0';
																cnt := cnt + 1 ;
																if (cnt > 5000) then    
																	charState 	<= I8;
																end if;
 --- 
									when I8	  => 	sLcdAdr 		<= x"01";  -- Command 2
																sLcdDat 		<= x"02";
																sLcdWR  		<= '1';
																cnt := (others => '0');
																charState  	<= I9;
																
									when I9	=>		sLcdWR 	<= '0';
																cnt := cnt + 1 ;
																if (cnt > 5000) then    
																	charState 	<= I10;
																end if;
																
---------

									when I10	  => 	sLcdAdr 		<= x"01";  -- Command 28
																sLcdDat 		<= x"28";
																sLcdWR  		<= '1';
																cnt := (others => '0');
																charState  	<= I11;
																
									when I11	=>		sLcdWR 	<= '0';
																cnt := cnt + 1 ;
																if (cnt > 5000) then    
																	charState 	<= I12;
																end if;
---------

									when I12	  => 	sLcdAdr 		<= x"01";  -- Command 06
																sLcdDat 		<= x"06";
																sLcdWR  		<= '1';
																cnt := (others => '0');
																charState  	<= I13;
																
									when I13	=>		sLcdWR 	<= '0';
																cnt := cnt + 1 ;
																if (cnt > 5000) then    
																	charState 	<= I14;
																end if;
---------

									when I14	  => 	sLcdAdr 		<= x"01";  -- Command 0C
																sLcdDat 		<= x"0c";
																sLcdWR  		<= '1';
																cnt := (others => '0');
																charState  	<= I15;
																
									when I15	=>		sLcdWR 	<= '0';
																cnt := cnt + 1 ;
																if (cnt > 5000) then    
																	charState 	<= I16;
																end if;
																
									when I16	=>	charState 	<= S0;							
																
--------------------------------------------------------------							
---- CLR
									when S0 	=> 	sLcdWR <= '0';
																sLcdAdr <= x"01";  -- Clear Display
																sLcdDat <= x"20";  -- Space
																if (sLcdRDY = '1')	then 
																		sLcdWR  <= '1';
																		cnt := (others => '0');
																		charState   <= S1;
																end if;
																
									when S1 	=>	sLcdWR 	<= '0';
																cnt := cnt + 1 ;
																if (cnt > conv_std_logic_vector (100000, 16)) then    -- 100.000 = 2ms
																	charState 	<= S2;
																	i := (others=>'0');
																end if;

----1															
									when S2 	=> 	if (char = "00000000") 
																then			-- NULL CHARACTER
																	if (i >= x"79") then
																		cnt := (others => '0');
																		charState <= S11;
																	else 
																		i := i + 1;
																		charState <= S2;
																	end if;
																else
																	sLcdWR  <= '0';
																	sLcdAdr <= '1' &  i(6 downto 0);		--x"81";			-- the Character Location
																	sLcdDat <= char; 																	--Memory(i);  -- conv_std_logic_vector (66,8);										
																	if (sLcdRDY = '1')	then
																			sLcdWR  <= '1';
																			cnt := (others => '0');
																			charState   <= S3;
																	end if;
																
																end if;
																
									when S3 	=>	sLcdWR 	<= '0';									
																charState 	<= S4;

									when S4 	=>	sLcdWR 	<= '0';									
																if (sLcdRDY = '1') then
																	charState 	<= S2;
																	i := i + 1;
																end if;

--- Wait Loop		
															
--									when S10		=>  if (i < 20) then
--																		i := x"40";
--																		charState 	<= S2;
--																	else
--																		cnt := (others => '0');
--																		charState 	<= S11;
--																	end if;
--
									when S11		=>	cnt := cnt + 1;
																	if (cnt > 10000000) then -- wait 200 ms : 5 updates /Sec.
																		charState <= S0;					
																	end if;
																
									when others => charState <= S0;
							end case;
						end if;
					end process;





-----------------------------------------------------------------------
	enable	<= enrwrs(2);
	rw			<= enrwrs(1);
	rs			<= enrwrs(0);

pLcdInstr:
	process (Clk)
	variable counter : INTEGER RANGE 0 TO 50000000 := 0; 
	begin
		if rising_edge (Clk) THEN
		CASE state IS
		
			WHEN init =>
					-- state <= wait_for_data;
			
					counter := counter + 1;
					if ( counter >= 500000 ) then			-- 10 ms
						counter := 0;
						state <= wait_for_data;
					end if;
		

---- WAIT for new Data HERE
		
			WHEN wait_for_data =>
				counter := 0;
				if (sLcdWR = '1') then
					int_addr <= sLcdAdr;
					int_data <= sLcdDat;
					state <= write_addrH1; -- chk_busy1;
				end if;


-- Address:  High NIBBLE
			WHEN write_addrH1 =>
				counter := counter + 1;
				IF ( counter >= t_WRPulse ) THEN		-- 2 us WR Time
					counter := 0;
					state <= write_addrH2;
				END IF;
				
			WHEN write_addrH2 =>
				counter := counter + 1;
				IF (counter >= t_SetupHold) THEN
					counter := 0;
					state <= write_addrL1;
				END IF;

-- Address LOW NIBBLE
			WHEN write_addrL1 =>
				counter := counter + 1;
				IF ( counter >= t_WRPulse ) THEN
					counter := 0;
					state <= write_addrL2;
				END IF;
			
			WHEN write_addrL2 =>
				counter := counter + 1;
				IF (counter >= t_SetupHold) THEN
					counter := 0;
					state <= chk_busyI1;
				END IF;


--- WAIT 
			WHEN chk_busyI1 =>
				counter := counter + 1;
				if ( counter >= t_DatWait ) then				
					counter := 0;
					if (int_addr(7) = '1') then
						state <= write_dataH2;
					else
						state <= chk_busyI2;
					end if;	
				END IF;

--- WAIT 
			WHEN chk_busyI2 =>
				counter := counter + 1;
				if ( counter >= t_InstrWait ) then				
					counter := 0;
					state <= write_dataH2;
				END IF;


---------- NOW the DATA --------------------------------------------------
				 
-- DATA High NIBBLE 
--			WHEN write_dataH1 =>
--				counter := counter + 1;
--				IF ( counter >= t_WRPulse ) THEN
--					counter := 0;
--					state <= write_dataH2;
--				END IF;
				
			WHEN write_dataH2 =>
				counter := counter + 1;
				IF ( counter >= t_WRPulse ) THEN
					counter := 0;
					state <= write_dataH3;
				END IF;
				
			WHEN write_dataH3 =>
				counter := counter + 1;
				IF (counter >= t_SetupHold) THEN
					counter := 0;
					state <= write_dataL2;
				END IF;
				 
-- DATA Low NIBBLE 
--			WHEN write_dataL1 =>
--				counter := counter + 1;
--				IF ( counter >= t_WRPulse ) THEN
--					counter := 0;
--					state <= write_dataL2;
--				END IF;
				
			WHEN write_dataL2 =>
				counter := counter + 1;
				IF ( counter >= t_WRPulse ) THEN
					counter := 0;
					state <= write_dataL3;
				END IF;
				
			WHEN write_dataL3 =>
				counter := counter + 1;
				IF (counter >= t_SetupHold) THEN
					counter := 0;
					state <= chk_busyD1;
				END IF;				 

--- WAIT 
			WHEN chk_busyD1 =>
				counter := counter + 1;
				if ( counter >= t_DatWait ) then		-- 50 us		
					counter := 0;
					state <= wait_for_data;   --write_dataH1;
				END IF;				 
			 
				 
			WHEN OTHERS => state <= init;
		END CASE;
	END IF;
END PROCESS;



	sLcdRDY <= '1' WHEN (state = wait_for_data) ELSE '0';



	with state select
	lcd_data <=	
						"ZZZZ"		WHEN init,

						int_addr(7 downto 4)	WHEN write_addrH1,
						int_addr(7 downto 4)	WHEN write_addrH2,
						int_addr(3 downto 0)	WHEN write_addrL1,
						int_addr(3 downto 0)	WHEN write_addrL2,
									
						int_data(7 downto 4)	WHEN write_dataH1,
						int_data(7 downto 4)	WHEN write_dataH2,
						int_data(7 downto 4)	WHEN write_dataH3,
						
						int_data(3 downto 0)	WHEN write_dataL1,
						int_data(3 downto 0)	WHEN write_dataL2,
						int_data(3 downto 0)	WHEN write_dataL3,

						"ZZZZ"								WHEN wait_for_data,
						"ZZZZ"								WHEN OTHERS;

--  ENABLE RW RS

	WITH state SELECT
		enrwrs <=	"000"		WHEN init,
							"000"		WHEN wait_for_data,
							
							"100"		WHEN write_addrH1,
							"000"		WHEN write_addrH2,
							"100"		WHEN write_addrL1,
							"000"		WHEN write_addrL2,
	
							"001"		WHEN write_dataH1,			-- LcdData:	
							"101"		WHEN write_dataH2,    -- output LCD Data: ENABLE = 1;
							"001"		WHEN write_dataH3,
	
							"001"		WHEN write_dataL1,			-- LcdData:	
							"101"		WHEN write_dataL2,    -- output LCD Data: ENABLE = 1;
							"001"		WHEN write_dataL3,
							
							"000"		WHEN OTHERS;

END behavioral;
