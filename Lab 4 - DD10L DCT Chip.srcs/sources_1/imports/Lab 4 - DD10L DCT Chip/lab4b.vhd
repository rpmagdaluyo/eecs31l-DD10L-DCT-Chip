----------------------------------------------------------------------
-- EECS31L/CSE31L Assignment4 DCT
--  Behavioral Model
----------------------------------------------------------------------
-- Student First Name : Richard
-- Student Last Name : Magdaluyo
-- Student ID : 45993793
----------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity DCT_beh is
        port (
                Clk :           in std_logic;
                Start :         in std_logic;
                Din :           in INTEGER;
                Done :          out std_logic;
                Dout :          out INTEGER
              );
end DCT_beh;

architecture behavioral of DCT_beh is
begin
        process
                type RF is array ( 0 to 7, 0 to 7 ) of INTEGER;
                --------------------------------------------------
                --you may modify below variables or declare new ones  
                --for the behavioral model
                --------------------------------------------------				
                variable i, j, k        : INTEGER;
                variable InBlock        : RF;
                variable COSBlock       : RF;
                variable TempBlock      : RF;
                variable OutBlock       : RF;
                variable A, B, P, Sum   : INTEGER; 
                
                type StateType is 
                    (Initial, GetInput, Compute, Output);
                signal CurrState, NextState: StateType;

        begin
                -------------------------------
                -- Initialize parameter matrix
                -------------------------------
                COSBlock := ( 
        ( 125,  122,    115,    103,    88,     69,     47,     24  ),
        ( 125,  103,    47,     -24,    -88,    -122,   -115,   -69  ),
        ( 125,  69,     -47,    -122,   -88,    24,     115,    103  ),
        ( 125,  24,     -115,   -69,    88,     103,    -47,    -122  ),
        ( 125,  -24,    -115,   69,     88,     -103,   -47,    122  ),
        ( 125,  -69,    -47,    122,    -88,    -24,    115,    -103  ),
        ( 125,  -103,   47,     24,     -88,    122,    -115,   69  ),
        ( 125,  -122,   115,    -103,   88,     -69,    47,     -24  )
                        );  

     -- add your code here
     -- Read Input Data
     for i in 0 to 7 loop
        for j in 0 to 7 loop
            wait until Clk = '1' and Clk'event;
            InBlock(i,j) := Din;
        end loop;
     end loop;
     
     -- Calculate the contents of TempBlock (which will be (COSBlock x f)
     for i in 0 to 7 loop
        for j in 0 to 7 loop
            Sum := 0;
            for k in 0 to 7 loop
                A := COSBlock(i,j);
                B := InBlock(i,j);
                P := A*B;
                Sum := Sum + P;
                if (k = 7) then
                    TempBlock(i,j) := Sum;
                end if;
            end loop;
        end loop;
     end loop;
     
     -- Calculate OutBlock (which is TempBlock x COSBlockT)
     for i in 0 to 7 loop
        for j in 0 to 7 loop
            Sum := 0;
            for k in 0 to 7 loop
                A := TempBlock(i,j);
                B := CosBlock(j,i);
                P := A*B;
                Sum := Sum + P;
                if (k = 7) then
                    OutBlock(i,j) := Sum;
                end if;
            end loop;
        end loop;
     end loop;  
     
     -- Let Output out;
     for i in 0 to 7 loop
        for j in 0 to 7 loop
            Dout <= OutBlock(i,j);
        end loop;
     end loop;          
                    
                        
                
    end process;
end behavioral;
