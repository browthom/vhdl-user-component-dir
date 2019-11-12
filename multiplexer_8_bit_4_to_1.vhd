library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity multiplexer_8_bit_4_to_1 is
port ( input_1, input_2, input_3, input_4 : in std_logic_vector (7 downto 0);
       sel : in std_logic_vector (1 downto 0);
       output : out std_logic_vector (7 downto 0));
end multiplexer_8_bit_4_to_1;

architecture DataFlow of multiplexer_8_bit_4_to_1 is

begin

    output <= input_1 when (sel = "00") else
              input_2 when (sel = "01") else
              input_3 when (sel = "10") else
              input_4 when (sel = "11") else
              "11111111";

end DataFlow;
