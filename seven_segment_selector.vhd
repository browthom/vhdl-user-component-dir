library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Author: Thomas Brown
-- Date: 11/13/19
-- Description: Turns on one of the 7 segments based on
--              which input is driven. Each segment number
--              corresponds to an index of the 8-bit 'seg_out'
--              vector:
--                0
--              -----
--           5 |     | 1
--              -----
--           4 |  6  | 2
--              -----
--                3
--
entity seven_segment_selector is
port (input : in std_logic_vector (2 downto 0);
      enable : in std_logic;
      seg_out : out std_logic_vector (7 downto 0));
end seven_segment_selector;

architecture DataFlow of seven_segment_selector is

begin

seg_out <= "11111110" when (input = "000" and enable = '1') else -- segment 0
           "11111101" when (input = "001" and enable = '1') else -- segment 1
           "11111011" when (input = "010" and enable = '1') else -- segment 2
           "11110111" when (input = "011" and enable = '1') else -- segment 3
           "11101111" when (input = "100" and enable = '1') else -- segment 4
           "11011111" when (input = "101" and enable = '1') else -- segment 5
           "10111111" when (input = "110" and enable = '1') else -- segment 6
           "01111111" when (input = "111" and enable = '1') else -- decimal point
           "11111111";

end DataFlow;
