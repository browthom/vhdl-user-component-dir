library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity count_to_eighteen is
port (clk, reset, enable, enable_auto_reset : in std_logic;
	  output : out std_logic_vector (4 downto 0));
end count_to_eighteen;

architecture Behavioral of count_to_eighteen is

signal temp_out : std_logic_vector (4 downto 0) := (others => '0');

begin
    process(clk, reset)
        begin
			if reset = '1' then
				temp_out <= (others => '0');
            elsif rising_edge(clk) then
                if enable = '1' then
                    if temp_out < 18 then
                        temp_out <= temp_out + 1;
                    elsif enable_auto_reset = '1' then
                        temp_out <= (others => '0');
                    end if;
                end if;
            end if;
        end process;
		
    output <= temp_out;
	
end Behavioral;
