library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity press_release_debouncer is
port (clk : in std_logic;
      button_press : in std_logic;
      output : out std_logic);
end press_release_debouncer;

architecture Behavioral of press_release_debouncer is

signal temp : unsigned (127 downto 0) := (others => '0');
signal state, next_state: std_logic := '0';

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
        
    state_register: process(clk)
        begin
            if rising_edge(clk) then
                state <= next_state;
            end if;
        end process;
    
    state_machine: process(state, temp)
        begin
            if state = '0' then
                if temp = 1 then
                    next_state <= '1';
                else
                    next_state <= state;
                end if;
            elsif state = '1' then
                if temp = x"8000_0000_0000_0000_0000_0000_0000_0000" then
                    next_state <= '0';
                else
                    next_state <= state;
                end if;
            else
                next_state <= state;
            end if;
        end process;
    
    outputs: process(state)
        begin
            if state = '0' then
                output <= '0';
            else
                output <= '1';
            end if;
        end process;
        

end Behavioral;
