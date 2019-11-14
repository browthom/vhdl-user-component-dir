library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Author: Thomas Brown
-- Date: 11/13/19
-- Description: Output a 2-bit value based on one 
--              of the selected inputs.
--              input_0 = '1' => "00"
--              input_1 = '1' => "01"
--              input_2 = '1' => "10"
--              If more than one input is high, then
--              the lowest numbered input takes
--              precedence.
entity two_bit_select is
port (input_0, input_1, input_2 : in std_logic;
      sel_out : out std_logic_vector(1 downto 0));
end two_bit_select;

architecture DataFlow of two_bit_select is

begin

sel_out <= "00" when input_0 = '1' else
           "01" when input_1 = '1' else
           "10" when input_2 = '1' else
           "11";
           
end DataFlow;
