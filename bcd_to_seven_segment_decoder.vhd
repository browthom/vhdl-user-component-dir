library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Author: Thomas Brown
-- Date: 11/13/19
-- Description: Outputs the segment bits based on 4-bit BCD input.
--              Each segment number
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
entity bcd_seven_segment_decoder is
port (input : in std_logic_vector (3 downto 0);
      enable : in std_logic;
      seg_out : out std_logic_vector (7 downto 0));
end bcd_seven_segment_decoder;

architecture DataFlow of bcd_seven_segment_decoder is

begin

seg_out <= "11000000" when (input = "0000" and enable = '1') else -- "0" -> segments 0 1 2 3 4 5
           "11111001" when (input = "0001" and enable = '1') else -- "1" -> segments 1 2
           "10100100" when (input = "0010" and enable = '1') else -- "2" -> segments 0 1 3 4 6
           "10110000" when (input = "0011" and enable = '1') else -- "3" -> segments 0 1 2 3 6
           "10011001" when (input = "0100" and enable = '1') else -- "4" -> segments 1 2 5 6
           "10010010" when (input = "0101" and enable = '1') else -- "5" -> segments 0 2 3 5 6
           "10000010" when (input = "0110" and enable = '1') else -- "6" -> segments 0 2 3 4 5 6
           "11111000" when (input = "0111" and enable = '1') else -- "7" -> segments 0 1 2
           "10000000" when (input = "1000" and enable = '1') else -- "8" -> segments 0 1 2 3 4 5 6
           "10010000" when (input = "1001" and enable = '1') else -- "9" -> segments 0 1 2 3 5 6
           "10001000" when (input = "1010" and enable = '1') else -- "a" -> segments 0 1 2 4 5 6
           "10000011" when (input = "1011" and enable = '1') else -- "b" -> segments 2 3 4 5 6
           "10100111" when (input = "1100" and enable = '1') else -- "c" -> segments 3 4 6
           "10100001" when (input = "1101" and enable = '1') else -- "d" -> segments 1 2 3 4 6
           "10000110" when (input = "1110" and enable = '1') else -- "e" -> segments 0 3 4 5 6
           "10001110" when (input = "1111" and enable = '1') else -- "f" -> segments 0 4 5 6
           "11111111";
           
end DataFlow;
