----------------------------------------------------------------------
-- EECS31L/CSE31L Assignment4 DCT
--  Behavioral Model
----------------------------------------------------------------------
-- Student First Name : 
-- Student Last Name : 
-- Student ID : 
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

     --add your code here    

end behavioral;
