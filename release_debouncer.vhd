library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity release_debouncer is
port (clk : in std_logic;
      button_press : in std_logic;
      output : out std_logic);
end release_debouncer;

architecture Behavioral of release_debouncer is

signal temp : unsigned (127 downto 0) := x"0000_0000_0000_0000_0000_0000_0000_0000";

begin
    bitshift: process (clk, button_press)
        begin
            if rising_edge(clk) then
                if button_press = '1' then
                    -- The bit-shifting 'or' operation must be done with the appropriate width
                    -- of bits specified.
                    -- The bottom statement is equivalent to bitwise 'or' with
                    -- (0 => '1', temp'left downto temp'right+1 => '0')
                    temp <= shift_left(temp, 1) or x"0000_0000_0000_0000_0000_0000_0000_0001";
                elsif button_press = '0' then
                    temp <= shift_left(temp, 1);
                end if;
            end if;
        end process;
        
    debounce_output: process(temp)
        begin
            -- If 'temp' has bit 127 set to '1' and all other bits are set to '0'
            if temp = x"8000_0000_0000_0000_0000_0000_0000_0000" then
                output <= '1';
            else   
                output <= '0';
            end if;
        end process;
        

end Behavioral;
