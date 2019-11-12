library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity buffer_8_bit is
port (clk, reset, enable : in std_logic;
	  input : in std_logic_vector (7 downto 0);
	  output : out std_logic_vector (7 downto 0));
end buffer_8_bit;

architecture Behavioral of buffer_8_bit is

signal temp_out : std_logic_vector (7 downto 0) := (others => '0');

begin
    process(clk, reset)
        begin
			if reset = '1' then
				temp_out <= (others => '0');
            elsif rising_edge(clk) then
				if enable = '1' then
					temp_out <= input;
				end if;
            end if;
        end process;
		
    output <= temp_out;
	
end Behavioral;
