library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity seven_segment_selector is
port (input : in std_logic_vector (2 downto 0);
	  enable : in std_logic;
      seg_out : out std_logic_vector (7 downto 0));
end seven_segment_selector;

architecture DataFlow of seven_segment_selector is

begin
    seg_out <= "11111110" when (input = "000" and enable = '1') else -- "seg a"
               "11111101" when (input = "001" and enable = '1') else -- "seg b"
               "11111011" when (input = "010" and enable = '1') else -- "seg c"
               "11110111" when (input = "011" and enable = '1') else -- "seg d"
               "11101111" when (input = "100" and enable = '1') else -- "seg e"
               "11011111" when (input = "101" and enable = '1') else -- "seg f"
               "10111111" when (input = "110" and enable = '1') else -- "seg g"
               "01111111" when (input = "111" and enable = '1') else -- "dp"
			   "11111111";
            
end DataFlow;
