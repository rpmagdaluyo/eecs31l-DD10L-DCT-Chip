--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   v2
-- Design Name:   
-- Module Name:   
-- Project Name:  
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DCT_str
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE std.textio.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_str IS
END tb_str;
 
ARCHITECTURE behavior OF tb_str IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DCT_str
    PORT(
         Clk : IN  std_logic;
         Start : IN  std_logic;
         Din : IN  INTEGER;
         Done : OUT  std_logic;
         Dout : OUT  INTEGER
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Start : std_logic := '0';
   signal Din : INTEGER := 0;

    --Outputs
   signal Done : std_logic;
   signal Dout : INTEGER;

   -- Clock period definitions
   -- Adjust to your actual clock cycle!
   constant Clk_period : time := 8 ns;
 
BEGIN
 
    -- Instantiate the Unit Under Test (UUT)
   uut: DCT_str PORT MAP (
          Clk => Clk,
          Start => Start,
          Din => Din,
          Done => Done,
          Dout => Dout
        );

   -- Clock process definitions
   Clk_process :process
   begin
        Clk <= '0';
        wait for Clk_period/2;
        Clk <= '1';
        wait for Clk_period/2;
   end process;
 

    Start <= '0' after 0 ns,
             '1' after 50 ns,
             '0' after 100 ns;

   -- Stimulus process
   stim_proc: process
		          variable stringbuff : LINE;
					 variable a:integer:= 1;
                type RF is array ( 0 to 7, 0 to 7 ) of INTEGER;

                variable Result : RF := (
				    (34636140,  -7147140,  8946420,  -649740,  5747700,  1549380, 4048380,  2848860),
				    (-10426185, 2151435,   -2693055, 195585,   -1730175, -466395, -1218645, -857565),
				    (60613245,  -12507495, 15656235, -1137045, 10058475, 2711415, 7084665,  4985505),
				    (-7775460,  1604460,   -2008380, 145860,   -1290300, -347820, -908820,  -639540),
				    (35343000,   -7293000,   9129000, -663000, 5865000,  1581000, 4131000,  2907000),
				    (24209955,   -4995705,  6253365,  -454155,  4017525,  1082985, 2829735, 1991295),
				    (13960485,  -2880735,  3605955,  -261885,  2316675,  624495,  1631745,  1148265),
				    (26153820,  -5396820,  6755460,  -490620,  4340100,  1169940, 3056940,  2151180)
				    );
        begin
		       	WRITE (stringbuff, string'("Starts Structural Simulation at "));
		      	WRITE (stringbuff, now);
			    WRITELINE (output, stringbuff);
                ---------------------------------
                --      Handshaking/synchronizing
                ---------------------------------
                wait until Start =  '1';
                
                ---------------------------------
                --      Feed Data -- Sandwich Case
                ---------------------------------
                for i in 0 to 7 loop
                        wait until Clk = '1';
                        Din <= 255;
                end loop;

				-- continue feeding in rest of sandwich
				for i in 0 to 4 loop
				    for i in 0 to 7 loop
				        wait until Clk = '1';
				        Din <= 0;
				    end loop;
				end loop;
				
				for i in 0 to 1 loop
				    for i in 0 to 7 loop
				        wait until Clk = '1';
				        Din <= 255;
				    end loop;
				end loop;                

                ---------------------------------
                --      Handshaking/synchronizing
                ---------------------------------
                wait until Done = '1';
				wait for 5 ns;
                wait until Clk = '1' AND Clk'EVENT; 

				--------------------------------
				--      Verify
				--------------------------------
				
				-- for each clock cycle now, start comparing values
				for i in 0 to 7 loop
					for j in 0 to 7 loop
					    wait until Clk = '1';
						assert Dout = Result(i,j) report "Dout not equal to desired output" severity warning;
					end loop;
				end loop;
						
				WRITE (stringbuff, string'("Verification completed. Simulation Ends at "));
				WRITE (stringbuff, now);
				WRITELINE (output, stringbuff);
				wait;
        end process;

END;