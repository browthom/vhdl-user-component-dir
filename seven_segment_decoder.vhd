library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Author: Thomas Brown
-- Date: 11/13/19
-- Description: Outputs segment turn. Each segment number
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
entity seven_segment_decoder is
port (input : in std_logic_vector (5 downto 0);
      enable : in std_logic;
      seg_out : out std_logic_vector (7 downto 0));
end seven_segment_decoder;

architecture DataFlow of seven_segment_decoder is

begin

seg_out <= "11000000" when (input = "000000" and enable = '1') else -- "0" -> segments 0 1 2 3 4 5
           "10000110" when (input = "000001" and enable = '1') else -- "1" -> segments 1 2
           "10100100" when (input = "000010" and enable = '1') else -- "2" -> segments 0 1 3 4 6
           "10110000" when (input = "000011" and enable = '1') else -- "3" -> segments 0 1 2 3 6
           "10011001" when (input = "000100" and enable = '1') else -- "4" -> segments 1 2 5 6
           "10010010" when (input = "000101" and enable = '1') else -- "5" -> segments 0 2 3 5 6
           "10000010" when (input = "000110" and enable = '1') else -- "6" -> segments 0 2 3 4 5 6
           "11111000" when (input = "000111" and enable = '1') else -- "7" -> segments 0 1 2
           "10000000" when (input = "001000" and enable = '1') else -- "8" -> segments 0 1 2 3 4 5 6
           "10010000" when (input = "001001" and enable = '1') else -- "9" -> segments 0 1 2 3 5 6
           "10001000" when (input = "001010" and enable = '1') else -- "a" -> leds 0 1 2 4 5 6
           "10000011" when (input = "001011" and enable = '1') else -- "b" -> leds 2 3 4 5 6
           "10100111" when (input = "001100" and enable = '1') else -- "c" -> leds 3 4 6
           "10100001" when (input = "001101" and enable = '1') else -- "d" -> leds 1 2 3 4 6
           "10000110" when (input = "001110" and enable = '1') else -- "e" -> leds 0 3 4 5 6
           "10001110" when (input = "001111" and enable = '1') else -- "f" -> leds 0 4 5 6
           "11000010" when (input = "010000" and enable = '1') else -- "g" -> leds 0 2 3 4 5
           "10001011" when (input = "010001" and enable = '1') else -- "h" -> leds 2 4 5 6
           "11111011" when (input = "010010" and enable = '1') else -- "i" -> leds 2
           "11110001" when (input = "010011" and enable = '1') else -- "j" -> leds 1 2 3
           -- no 'k' (input = "10100")
           "11000111" when (input = "010101" and enable = '1') else -- "l" -> leds 3 4 5
           "10101011" when (input = "010110" and enable = '1') else -- "m" 1st and 2nd -> leds 2 4 6
           "10101011" when (input = "010111" and enable = '1') else -- "n" -> leds 2 4 6
           "10100011" when (input = "011000" and enable = '1') else -- "o" -> leds 2 3 4 6
           "10001100" when (input = "011001" and enable = '1') else -- "p" -> leds 0 1 4 5 6
           "10011000" when (input = "011010" and enable = '1') else -- "q" -> leds 0 1 2 5 6
           "10101111" when (input = "011011" and enable = '1') else -- "r" -> leds 4 6
           "10010010" when (input = "011100" and enable = '1') else -- "s" -> leds 0 2 3 5 6
           "10000111" when (input = "011101" and enable = '1') else -- "t" -> leds 3 4 5 6
           "11100011" when (input = "011110" and enable = '1') else -- "u" -> leds 2 3 4
           "11000001" when (input = "011111" and enable = '1') else -- "v" -> leds 1 2 3 4 5
           "11100011" when (input = "100000" and enable = '1') else -- "w" 1st and 2nd -> leds 2 3 4
           -- no 'x' (input = "100001")
           "10010001" when (input = "100010" and enable = '1') else -- "y" -> leds 1 2 3 5 6
           -- no 'z' (input = "100011")
           "11111111";

end DataFlow;
