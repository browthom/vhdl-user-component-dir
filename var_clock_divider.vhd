library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Author: Thomas Brown
-- Date: 11/13/19
-- Description: Variable Clock Divider Circuit
--              Divides clock frequency based on 'divider' value.
entity var_clock_divider is
port (clk : in std_logic;
      divider : in natural range 0 to 1000000000;
      clk_out : out std_logic);
end var_clock_divider;

architecture Behavioral of var_clock_divider is

signal count : natural range 0 to 1000000000 := 0;
signal temp_clk_out : std_logic := '0';

-- clk / 2 => Initial clock frequency
-- divider / (clk / 2) => period --- (1 / frequency (desired) )
--
-- e.g.
-- 100MHz / 2 => 50MHz
-- 30,000,000 / 50MHz => 0.6 seconds
-- 
-- Freq = clk / (2 * divider)
-- divider = clk / (2 * Freq)
--
-- e.g. 7-Seg Display Mux Counter Example:
-- 100MHz / (2 * 400Hz) => 0.125 * 10^6
begin
    clkDivider: process(clk, divider)
        begin
            if rising_edge(clk) then
            
                -- Reset count upon reaching divider value
                -- Toggle clock divider output
                if count = divider then
                    temp_clk_out <= not temp_clk_out;
                    count <= 0;
                    
                -- Continually count up while count is still
                -- less than divider
                elsif count < divider then
                    count <= count + 1;
                    
                -- For all other conditions (essentially count > divider),
                -- set divider to count. This is used when the 'divider'
                -- value is changed to a value than the current value of 
                -- 'count'.
                else
                    count <= divider;
                end if;
            end if;
        end process;

clk_out <= temp_clk_out;

end Behavioral;
