--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   
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
 
ENTITY tb_beh IS
END tb_beh;
 
ARCHITECTURE behavior OF tb_beh IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DCT_beh
    PORT(
         Clk : IN  std_logic;
         Start : IN  std_logic;
         Din : IN  integer;
         Done : OUT  std_logic;
         Dout : OUT  integer
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Start : std_logic := '0';
   signal Din : integer := 0;

 	--Outputs
   signal Done : std_logic;
   signal Dout : integer;

   -- Clock period definitions
   constant Clk_period : time := 68 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DCT_beh PORT MAP (
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

                -- variable Result : RF := (
				   -- (...),
				   -- (...),
				   -- (...),
				   -- (...),
				   -- (...),
				   -- (...),
				   -- (...),
				   -- (...)
				 -- );
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
				WRITE (stringbuff, string'("Verification completed. Simulation Ends at "));
				WRITE (stringbuff, now);
				WRITELINE (output, stringbuff);
				wait;
        end process;

END;