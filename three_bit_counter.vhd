library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity three_bit_counter is
port (clk, reset : in std_logic;
	  output : out std_logic_vector (2 downto 0));
end three_bit_counter;

architecture Behavioral of three_bit_counter is

signal temp_out : std_logic_vector (2 downto 0) := (others => '0');

begin
    process(clk, reset)
        begin
			if reset = '1' then
				temp_out <= (others => '0');
            elsif rising_edge(clk) then
                temp_out <= temp_out + 1;
            end if;
        end process;
		
    output <= temp_out;
    
end Behavioral;
