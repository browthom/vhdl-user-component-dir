library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity vga_controller is
port (clk : in std_logic;
	  hcount, vcount : out std_logic_vector(10 downto 0);
      hsync, vsync : out std_logic);
end vga_controller;

architecture Behavioral of vga_controller is

signal hcount_temp, vcount_temp : std_logic_vector(10 downto 0) := (others => '0');
signal hsync_temp, vsync_temp : std_logic := '0';

begin

    horizontal_counter: process(clk)
        begin
            if rising_edge(clk) then
				hcount_temp <= hcount_temp + 1;
            end if;
        end process;
		
    vertical_counter: process(clk)
        begin
            if rising_edge(clk) then
				if enable = '1' then
					vcount_temp <= vcount_temp + 1;
				end if;
            end if;
        end process;
		
	horizontal_zero_detect: process(hcount_temp)
		begin
			
		end process;
	
		
end Behavioral;
