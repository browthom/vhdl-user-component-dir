library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Name: Thomas Brown; Based on code written by Dr. Parikh
-- Course: EGR 426-901
--
--      Divides the clock frequency based on the 'divider' value
--		that acts as an index to the clk_div vector.
entity var_clock_divider_2 is
port (clk : in std_logic;
	  divider : in natural range 0 to 25;
      clk_out : out std_logic);
end var_clock_divider_2;

architecture Behavioral of var_clock_divider_2 is

-- clock divider vector
signal clk_div: STD_LOGIC_VECTOR (25 downto 0);

begin
    clkDivider: process(clk)
        begin
            if rising_edge(clk) then
                clk_div <= clk_div + 1;
            end if;
        end process;
        
    Counter: process(clk_div, divider)
        begin
            if (clk_div(divider) = '1') then
                clk_out <= '1';
            else
                clk_out <= '0';
            end if;
        end process;

end Behavioral;
