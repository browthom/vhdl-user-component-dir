library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity count_up_and_delay is
port (clk : in std_logic;
      delay_value : in natural range 0 to 1000;
      count_value : in natural range 0 to 1000;
      output : out std_logic_vector (4 downto 0));
end count_up_and_delay;

architecture Behavioral of count_up_and_delay is

signal temp_out : std_logic_vector (4 downto 0) := (others => '0');
signal delay : natural range 1 to 1000 := 1;
signal state : std_logic := '0';

begin

process(clk)
    begin
        if rising_edge(clk) then
            if state = '0' and temp_out = 18 then
                state <= '1';
            elsif state = '1' and delay = 3 then
                state <= '0';
            end if;
        end if;
    end process;

process(clk)
    begin
        if rising_edge(clk) then
            if state = '0' then
                if temp_out < count_value then
                    temp_out <= temp_out + 1;
                end if;
            else
                temp_out <= (others => '0');
            end if;
        end if;
    end process;

process(clk)
    begin
        if rising_edge(clk) then
            if state = '1' then
                if delay < delay_value then
                    delay <= delay + 1;
                end if;
            else
                delay <= 1;
            end if;
        end if;
    end process;

output <= temp_out;

end Behavioral;
