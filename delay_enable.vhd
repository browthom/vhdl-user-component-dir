library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity delay_enable is
port (clk, reset, invert : in std_logic;
      delay_value : in natural range 0 to 1000000000;
	  enable : out std_logic);
end delay_enable;

architecture Behavioral of delay_enable is

signal delay_temp : natural range 0 to 1000000000 := 0;

begin

    process(clk, reset, invert)
        begin
            if reset = '1' then
				if invert = '0' then
					enable <= '0';
				elsif invert = '1' then
					enable <= '1';
				end if;
            elsif rising_edge(clk) then
                if delay_temp = delay_value then
					if invert = '0' then
						enable <= '1';
					elsif invert = '1' then
						enable <= '0';
					end if;
                end if;
            end if;
        end process;
		
	process(clk, reset)
		begin
			if reset = '1' then
				delay_temp <= 0;
			elsif rising_edge(clk) then
			
				if delay_temp < delay_value then
					delay_temp <= delay_temp + 1;
					
				elsif delay_temp > delay_value then
					delay_temp <= delay_value;
				end if;
            end if;
		end process;
	
end Behavioral;
