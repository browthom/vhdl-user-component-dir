library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Author: Thomas Brown
-- Date: 11/13/19
-- Description: VHDL model that infers a D-Flip Flop
entity flip_flop is
port (clk, D, R, enable : in std_logic;
      Q : out std_logic);
end flip_flop;

architecture Behavioral of flip_flop is

begin

    process(clk, R)
        begin
            if R = '1' then
                Q <= '0';
            elsif rising_edge(clk) then
                if enable = '1' then
                    Q <= D;
                end if;
            end if;
        end process;

end Behavioral;
