library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity press_debouncer is
Port (clk : in std_logic;
      button_press : in std_logic;
      output : out std_logic);
end press_debouncer;

architecture Behavioral of press_debouncer is

signal temp : unsigned (127 downto 0) := (others => '0');

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
            -- If 'temp' has bit 0 set to '1' and all other bits are set to '0'
            -- It's okay not to specify the entire bit width as we are not doing
            -- a bitwise manipulation here. We are just using an if-statment.
            if temp = 1 then
                output <= '1';
            else   
                output <= '0';
            end if;
        end process;
        

end Behavioral;
