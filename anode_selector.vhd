library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Author: Thomas Brown
-- Date: 11/13/19
-- Description: Selects 1 of 4 anodes on the
--              seven segment display.
entity anode_selector is
port (sel : in std_logic_vector (1 downto 0);
      output : out std_logic_vector (3 downto 0));
end anode_selector;

architecture DataFlow of anode_selector is

begin

output <= "1110" when (sel = "00") else
          "1101" when (sel = "01") else
          "1011" when (sel = "10") else
          "0111" when (sel = "11") else
          "1111";

end DataFlow;
