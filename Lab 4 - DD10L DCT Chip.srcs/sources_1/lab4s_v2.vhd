----------------------------------------------------------------------
-- EECS31L/CSE31L Assignment4 DCT - v2
-- Structural Model
-- Author: 
-- ucinetid: rmagdalu
----------------------------------------------------------------------
-- Version 2-22-2018

Library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_MISC.all;
use IEEE.STD_LOGIC_ARITH.all;

----------------integer register--------------------

Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_misc.all;
use IEEE.std_logic_arith.all;


Entity Reg is
      Generic ( Delay:   Time := 4 ns ); 
      Port (    Clk : In    std_logic;
                Din : In    INTEGER;
                Rst:  In    std_logic;
                Ld : In    std_logic;
                Dout : Out   INTEGER );
End Reg;

Architecture BEHAVIORAL of Reg is

   Begin
    P: Process (Clk)
    Variable Value : INTEGER := 0;
    Begin
     if( Clk'event and Clk = '1' ) then
       if (Rst = '1') then
           Dout <= 0;           
       elsif( Ld = '1' ) then
           Dout <=  Din after Delay;
       End if;
     End if; 
    End Process P;
End BEHAVIORAL;

-----------256x32(integer) Register file-------------------

Library ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
 
Entity RegFile IS
   Generic ( Delay:   Time := 8 ns );
   Port (R_addr1,R_addr2,W_addr: IN std_logic_vector(7 DOWNTO 0);
         R_en1,R_en2, W_en: IN std_logic;
         R_data1, R_data2: OUT INTEGER; 
         W_data: IN INTEGER; 
         Clk: IN std_logic );
End RegFile;

Architecture Behavioral OF RegFile IS 
    type RF is array ( 0 to 31, 0 to 7 ) of INTEGER;
    signal Storage : RF := (
             --------OutBlock--------
            ( 0, 0, 0, 0, 0, 0, 0, 0 ),
            ( 0, 0, 0, 0, 0, 0, 0, 0 ),
            ( 0, 0, 0, 0, 0, 0, 0, 0 ),
            ( 0, 0, 0, 0, 0, 0, 0, 0 ),
            ( 0, 0, 0, 0, 0, 0, 0, 0 ),
            ( 0, 0, 0, 0, 0, 0, 0, 0 ),
            ( 0, 0, 0, 0, 0, 0, 0, 0 ),
            ( 0, 0, 0, 0, 0, 0, 0, 0 ),
             --------TempBlock--------
            ( 0, 0, 0, 0, 0, 0, 0, 0 ),
            ( 0, 0, 0, 0, 0, 0, 0, 0 ),
            ( 0, 0, 0, 0, 0, 0, 0, 0 ),
            ( 0, 0, 0, 0, 0, 0, 0, 0 ),
            ( 0, 0, 0, 0, 0, 0, 0, 0 ),
            ( 0, 0, 0, 0, 0, 0, 0, 0 ),
            ( 0, 0, 0, 0, 0, 0, 0, 0 ),
            ( 0, 0, 0, 0, 0, 0, 0, 0 ),
             --------InBlock--------
            ( 0, 0, 0, 0, 0, 0, 0, 0 ),
            ( 0, 0, 0, 0, 0, 0, 0, 0 ),
            ( 0, 0, 0, 0, 0, 0, 0, 0 ),
            ( 0, 0, 0, 0, 0, 0, 0, 0 ),
            ( 0, 0, 0, 0, 0, 0, 0, 0 ),
            ( 0, 0, 0, 0, 0, 0, 0, 0 ),
            ( 0, 0, 0, 0, 0, 0, 0, 0 ),
            ( 0, 0, 0, 0, 0, 0, 0, 0 ),
           --------COS-------------
            ( 125, 122,  115, 103,  88,  69,   47,   24  ),
            ( 125, 103,  47,  -24,  -88, -122, -115, -69  ),
            ( 125, 69,   -47, -122, -88, 24,   115,  103  ),
            ( 125, 24,   -115, -69, 88,  103,  -47,  -122  ),
            ( 125, -24,  -115, 69,  88,  -103, -47,  122  ),
            ( 125, -69,  -47, 122,  -88, -24,  115,  -103  ),
            ( 125, -103, 47,  24,   -88, 122,  -115, 69  ),
            ( 125, -122, 115, -103, 88,  -69,  47,   -24 )          
            );
Begin
    WriteProcess: Process(Clk)
    Variable col_w:std_logic_vector(2 DOWNTO 0);    
    Variable row_w:std_logic_vector(4 DOWNTO 0);
    Begin
          row_w := W_addr(7 downto 3);
          col_w := W_addr(2 downto 0);
        
    if( Clk'event and Clk = '1' ) then   
      if(W_en = '1') then 
        -- write --
        Storage( CONV_INTEGER(row_w), CONV_INTEGER(col_w)) <= W_data after Delay;
      End if;
        
    End if;
    
    End Process;

    ReadProcess: Process(R_en1, R_addr1, R_en2, R_addr2,Storage)
    Variable  col_r1, col_r2:std_logic_vector(2 DOWNTO 0);  
    Variable  row_r1, row_r2:std_logic_vector(4 DOWNTO 0);
    Begin
        row_r1 := R_addr1(7 downto 3);
        col_r1 := R_addr1(2 downto 0);
        row_r2 := R_addr2(7 downto 3);
        col_r2 := R_addr2(2 downto 0);
    
    if(R_en1 = '1') then 
        R_data1 <= Storage( CONV_INTEGER(row_r1), CONV_INTEGER(col_r1) ) after Delay;
    else
        R_data1 <= INTEGER'left;    
    End if;
    
    if(R_en2 = '1') then 
        R_data2 <= Storage( CONV_INTEGER(row_r2), CONV_INTEGER(col_r2) ) after Delay;
    else
        R_data2 <= INTEGER'left;    
    End if;
    End Process;
End Behavioral;


-------------------------------Counter------------------------------

Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_misc.all;
use IEEE.std_logic_arith.all;



Entity Counter is
      Generic ( Delay:   Time := 8 ns );
      Port (    Clk : In    std_logic;
                Inc : In    std_logic;
                Rst : In    std_logic;
                i : Out   std_logic_vector(2 downto 0);
                j : Out   std_logic_vector(2 downto 0);
                k : Out   std_logic_vector(2 downto 0) );
End Counter;

Architecture BEHAVIORAL of Counter is

   Begin
    P: Process ( Clk )
    Variable Value : UNSIGNED( 8 downto 0 ) := "000000000";
    Begin
        if( Clk'event and Clk = '1' ) then 
            if( Rst = '1' ) then
                Value := "000000000";
            elsif( Inc = '1' ) then
                Value := Value + 1;
            End if;
        End if;
                i(2) <= Value(8) after Delay;
                i(1) <= Value(7) after Delay;
                i(0) <= Value(6) after Delay;
                j(2) <= Value(5) after Delay; 
                j(1) <= Value(4) after Delay;
                j(0) <= Value(3) after Delay;
                k(2) <= Value(2) after Delay;
                k(1) <= Value(1) after Delay; 
                k(0) <= Value(0) after Delay;                    
    End Process P;

End BEHAVIORAL;

---------------------------Multiplier--------------------------

library IEEE;
   use IEEE.std_logic_1164.all;
   use IEEE.std_logic_misc.all;
   use IEEE.std_logic_arith.all;


entity Multiplier is
          generic ( Delay:   Time := 25 ns );
       Port (A : In    integer;
             B : In    integer;
             Product : Out   integer );
end Multiplier;

architecture BEHAVIORAL of Multiplier is
   begin
    P: process ( A, B )
        variable Result : integer := 0;
    begin
        if( A /= integer'left and B /= integer'left ) then
            Result := A * B;
        end if;
        Product <= Result after Delay;
    end process P;
end BEHAVIORAL;


-------------------------Adder-------------------------------

library IEEE;
   use IEEE.std_logic_1164.all;
   use IEEE.std_logic_misc.all;
   use IEEE.std_logic_arith.all;


entity Adder is
         generic ( Delay:   Time := 15 ns ); 
      Port (     A : In    integer;
                 B : In    integer;
                 Sum : Out   integer );
end Adder;

architecture BEHAVIORAL of Adder is

   begin
    P: process ( A, B )
        variable Result : integer := 0;
    begin
        if( A /= integer'left and B /= integer'left ) then
            Result := A + B;
        end if;
        Sum <= Result after Delay;
    end process P;

end BEHAVIORAL;


----------------------32-bit(integer) Mux----------------------

Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_misc.all;
use IEEE.std_logic_arith.all;



Entity MuxInt is
      Generic ( Delay:   Time := 4 ns );
      Port (    C : In    std_logic;
                D0 : In    INTEGER;
                D1 : In    INTEGER;
                Dout : Out   INTEGER );
End MuxInt;

Architecture BEHAVIORAL of MuxInt is
   Begin
    P: Process ( D0, D1, C )
    Variable data_out : INTEGER;
    Begin
        if( C = '0' ) then
            data_out := D0;
        else
            data_out := D1;
        End if;
        Dout <= data_out after Delay;
    End Process P;
End BEHAVIORAL;


--------------------3-bit Mux--------------------------
Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_misc.all;
use IEEE.std_logic_arith.all;



Entity Mux3 is
      Generic ( Delay:   Time := 4 ns );
      Port (    C : In    std_logic;
                D0 : In    std_logic_vector(2 downto 0);
                D1 : In    std_logic_vector(2 downto 0);
                Dout : Out   std_logic_vector(2 downto 0) );
End Mux3;

Architecture BEHAVIORAL of Mux3 is

   Begin
    P: Process ( D0, D1, C )
        Begin
        if( C = '0' ) then
            Dout <= D0 after Delay;
        else
            Dout <= D1 after Delay;
        End if;
        
    End Process P;
End BEHAVIORAL;

---------- 32-bit (integer) Three-state Buffer ----------

Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_misc.all;
use IEEE.std_logic_arith.all;


Entity ThreeStateBuff IS
    Generic ( Delay:   Time := 1 ns );
    Port (Control_Input: IN std_logic;
          Data_Input: IN INTEGER;
          Output: OUT INTEGER );
End ThreeStateBuff;

Architecture Beh OF ThreeStateBuff IS
Begin
    Process (Control_Input, Data_Input)
    Begin
        IF (Control_Input = '1') THEN
            Output <= Data_Input AFTER Delay;
        ELSE
            Output <= INTEGER'left AFTER Delay;
        End IF;
    End Process;
End Beh;

  

 -------------------------------------------------------------
 --      Controller
 -------------------------------------------------------------
Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_misc.all;
use IEEE.std_logic_arith.all;



Entity Controller is
     Generic ( Delay:   Time := 6.4 ns );
     Port (  Clk   : In    std_logic;
             Start : In    std_logic;
             Count : In    std_logic_vector(8 downto 0);
             Inc : Out   std_logic := '0';
             R_en1 : Out   std_logic := '0';
             R_en2 : Out   std_logic := '0';
             W_en : Out   std_logic := '0';
             LoadSum : Out   std_logic := '0';               
             Rst_counter : Out   std_logic := '0';
             Rst_sum : Out   std_logic := '0'; 
             Rst_p : Out   std_logic := '0'; 
             Sel1 : Out   std_logic := '0';
             Sel2 : Out   std_logic := '0';
             Sel3 : Out   std_logic := '0';
             Sel4 : Out   std_logic := '0';
             Sel5 : Out   std_logic := '0';
             Sel6 : Out   std_logic := '0';
             Sel7 : Out   std_logic := '0'; 
             Oe   : Out   std_logic := '0';                  
             Done : Out   std_logic := '0');
End Controller;

Architecture BEHAVIORAL of Controller is

  -- you can have as many states as necessary
  -- no need to encode unless you really want to
  -- type STATE_VALUE is ( ... ); 
  -- SIGNAL CurrState :   STATE_VALUE;
  -- SIGNAL NextState :   STATE_VALUE;
  type StateType is
          (Initial, Input, Output);
      signal CurrState, NextState: StateType;

begin
 StateReg: process (Clk, CurrState)
			begin
				if(Clk = '1' and Clk'event) then
					CurrState <= NextState after Delay;
				end if;	
			end process StateReg;
 
 CombLogic: process(CurrState, Start, Count)
            -- some suggested variables, you can use or you can remove.
            -- variable  NextStateValue : STATE_VALUE := <initialize your state here>;
            -- variable  VarDone : std_logic;
            variable  i, j, k : INTEGER;
        
        begin
           
            -- convert from our Count std_logic_vector into an integer we can use easier
            -- optional to use; you can add/remove whatever code you feel necessary for the Controller
            if( Count(0) /= 'U' and Start /= 'U' ) then
                i := CONV_INTEGER( unsigned(Count( 8 downto 6 )) );
                j := CONV_INTEGER( unsigned(Count( 5 downto 3 )) );
                k := CONV_INTEGER( unsigned(Count( 2 downto 0 )) );
            end if; 
            
            case CurrState is
                when Initial =>
                    Rst_counter <= '1';
                    
                    if(Start = '1') then
                        NextState <= Input;
                    else
                        NextState <= Initial;
                    end if;
                            
				when Input =>        
                    Rst_counter <= '0';
                                        
                    W_en <= '1';
                    				
				    if(Count = "000111111") then
				        NextState <= Output; -- Placeholder for now
				    else    
				        Inc <= '1';
					    NextState <= Input;
					end if;
					
				when Output =>
				    Inc <= '0';
                    W_en <= '0';
				    if(Count = X"003F") then				    
				        NextState <= Initial;
				    else    
				        NextState <= Output;
				    end if;
            end case;
        end process; 

End BEHAVIORAL;

 -------------------------------------------------------------
 --      top level: structure for DCT
 --      minimal clock cycle = ??? ns
 -------------------------------------------------------------
 
Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_misc.all;
use IEEE.std_logic_arith.all;


Entity DCT_str IS
      Port (
                Clk :           in std_logic;
                Start :         in std_logic;
                Din :           in INTEGER;
                Done :          out std_logic;
                Dout :          out INTEGER
              );
End DCT_str;


Architecture struct OF DCT_str IS

COMPONENT Multiplier IS
      PORT ( A : In    integer;
             B : In    integer;
             Product : Out   integer );
END COMPONENT;

COMPONENT Adder IS
      PORT (     A : In    integer;
                 B : In    integer;
                 Sum : Out   integer );
END COMPONENT;

COMPONENT Counter IS
      Port (    Clk : In    std_logic;
                Inc : In    std_logic;
                Rst : In    std_logic;
                i : Out   std_logic_vector(2 downto 0);
                j : Out   std_logic_vector(2 downto 0);
                k : Out   std_logic_vector(2 downto 0)  );
End COMPONENT;

COMPONENT MuxInt is
       Port (    C : In    std_logic;
                D0 : In    INTEGER;
                D1 : In    INTEGER;
                Dout : Out   INTEGER );
End COMPONENT;

COMPONENT Mux3 is
      Port (    C : In    std_logic;
                D0 : In    std_logic_vector(2 downto 0);
                D1 : In    std_logic_vector(2 downto 0);
                Dout : Out   std_logic_vector(2 downto 0) );
End COMPONENT;

COMPONENT Reg is
      Port (    Clk : In    std_logic;
                DIN : In    INTEGER;
                Rst : In    std_logic;
                Ld : In    std_logic;
                Dout : Out   INTEGER );
End COMPONENT;

COMPONENT RegFile IS
      Port (    R_addr1,R_addr2,W_addr: IN std_logic_vector(7 DOWNTO 0);
                R_en1,R_en2, W_en: IN std_logic;
                R_data1, R_data2: OUT INTEGER; 
                W_data: IN INTEGER; 
                Clk: IN std_logic );
End COMPONENT;

COMPONENT ThreeStateBuff IS
      Port (    Control_Input: IN std_logic;
                Data_Input: IN INTEGER;
                Output: OUT INTEGER );
End COMPONENT;

COMPONENT Controller IS
      Port (    Clk   : In    std_logic;
                Start : In    std_logic;
                Count : In    std_logic_vector(8 downto 0);
                Inc : Out   std_logic ;
                R_en1 : Out   std_logic ;
                R_en2 : Out   std_logic ;
                W_en : Out   std_logic ;
                LoadSum : Out   std_logic ;              
                Rst_counter : Out   std_logic;
                Rst_sum : Out   std_logic; 
                Rst_p : Out   std_logic := '0'; 
                Sel1 : Out   std_logic;
                Sel2 : Out   std_logic ;
                Sel3 : Out   std_logic ;
                Sel4 : Out   std_logic ;
                Sel5 : Out   std_logic ;
                Sel6 : Out   std_logic ;
                Sel7 : Out   std_logic ;
                Oe   : Out   std_logic ;                 
                Done : Out   std_logic );
End COMPONENT;

--------------------------------------------------
--you may modify below signals or declare new ones  
--for the interconnections of the structural model
--------------------------------------------------

SIGNAL Inc, Rst_counter, Rst_sum, Rst_p:std_logic;
SIGNAL R_en1_s, R_en2_s :std_logic;
SIGNAL W_en_s :std_logic;
SIGNAL Sel1_s, Sel2_s,Sel3_s,Sel4_s,Sel5_s,Sel6_s,Sel7_s:std_logic;
SIGNAL muxout1,muxout2,muxout3: std_logic_vector(2 downto 0);
SIGNAL muxout4, muxout5, muxout6: INTEGER;
SIGNAL mult_out: INTEGER;
SIGNAL add_out: INTEGER;
SIGNAL R_data1_out, R_data2_out : INTEGER;
SIGNAL i_s, j_s, k_s: std_logic_vector(2 downto 0);
SIGNAL W_addr_s: std_logic_vector(7 downto 0); -- Hardwires 10 to first two bits of W_addr
SIGNAL Count_s: std_logic_vector(8 downto 0);
SIGNAL LoadSum: std_logic;
SIGNAL reg_sum_out,reg_p_out,reg_a_out,reg_b_out: INTEGER;
SIGNAL Oe_s :std_logic;

Begin
    W_addr_s <= "10" & j_s & k_s;
    Count_s <= i_s & j_s & k_s;    
    -- Add Your Port Mapping Code Here
    Controller_1: Controller port map(
        Clk => Clk,
        Start => Start,
        Count => Count_s,
        Inc => Inc,
        R_en1 => R_en1_s,
        R_en2 => R_en2_s,
        W_en => W_en_s,
        LoadSum => LoadSum,
        Rst_counter => Rst_counter,
        Rst_sum => Rst_sum,
        Rst_p => Rst_p, 
        Sel1 => Sel1_s,
        Sel2 => Sel2_s,
        Sel3 => Sel3_s,
        Sel4 => Sel4_s,
        Sel5 => Sel5_s,
        Sel6 => Sel6_s,
        Sel7 => Sel7_s,
        Oe   => Oe_s,                 
        Done => Done);        
            
    RegFile_1: RegFile port map(
        R_addr1 => "00000000",
        R_addr2 => "00000000",
        W_addr => W_addr_s,
        R_en1 => R_en1_s,
        R_en2 => R_en2_s,
        W_en => W_en_s,
        R_data1 => R_data1_out,
        R_data2 => R_data2_out,
        W_data => Din,                    
        Clk => Clk);
    
    Counter_1: Counter port map(
        Clk => Clk,
        Inc => Inc,
        Rst => Rst_counter,
        i => i_s,
        j => j_s,
        k => k_s);                
End struct;
 