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
                variable COSBlockT       : RF;
                variable TempBlock      : RF;
                variable OutBlock       : RF;
                variable A, B, P, Sum   : INTEGER; 
                
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

                COSBlockT := ( 
        ( 125,  125,    125,    125,    125,     125,     125,     125  ),
        ( 122,  103,    69,     24,     -24,     -69,     -103,    -122  ),
        ( 115,  47,     -47,    -115,   -115,    -47,     47,      115  ),
        ( 103,  -24,    -122,   -69,    69,     122,      24,      -103  ),
        ( 88,   -88,    -88,    88,     88,     -88,      -88,     88  ),
        ( 69,   -122,   24,     103,    -103,    -24,     122,     -69  ),
        ( 47,   -115,   115,    -47,    -47,    115,      -115,    47  ),
        ( 24,   -69,    103,    -122,   122,    -103,     69,      -24  )
                        );                  
                        

     -- add your code here
     -- Wait until Start = '1'
     wait until Start = '1';
     Done <= '0';
     wait until Clk = '1' and Clk'event;
     
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
                A := COSBlock(i,k);
                B := InBlock(k,j);
                P := A*B;
                Sum := Sum + P;
                if (k = 7) then
                    wait until Clk = '1' and Clk'event;
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
                A := TempBlock(i,k);
                B := CosBlockT(k,j);
                P := A*B;
                Sum := Sum + P;
                if (k = 7) then
                    wait until Clk = '1' and Clk'event;
                    OutBlock(i,j) := Sum;
                end if;
            end loop;
        end loop;
     end loop;  
     
     wait until Clk = '1' and Clk'event;
     Done <= '1';
     
     -- Let Output out;
     for i in 0 to 7 loop
        for j in 0 to 7 loop
            wait until Clk = '1' and Clk'event;
            Done <= '0';
            Dout <= OutBlock(i,j);
        end loop;
     end loop;          
                    
                                        
    end process;
end behavioral;
