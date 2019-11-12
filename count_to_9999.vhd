library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity count_to_9999 is
port (clk, reset, enable, enable_auto_reset : in std_logic;
	  bcd_a, bcd_b, bcd_c, bcd_d : out std_logic_vector (3 downto 0));
end count_to_9999;

architecture Behavioral of count_to_9999 is

signal bcd_a_temp, bcd_b_temp, bcd_c_temp, bcd_d_temp : std_logic_vector(3 downto 0);

begin   

process(clk, reset)
    begin
        if reset = '1' then
            bcd_a_temp <= (others => '0');
            bcd_b_temp <= (others => '0');
            bcd_c_temp <= (others => '0');
            bcd_d_temp <= (others => '0');
        elsif rising_edge(clk) then
            if enable = '1' then
                if not (bcd_d_temp = 9 and bcd_c_temp = 9 and bcd_b_temp = 9 and bcd_a_temp = 9) or enable_auto_reset = '1' then
                    if bcd_d_temp < 9 then
                        bcd_d_temp <= bcd_d_temp + 1;
                    else
                        bcd_d_temp <= (others => '0');
                        if bcd_c_temp < 9 then
                            bcd_c_temp <= bcd_c_temp + 1;
                        else
                            bcd_c_temp <= (others => '0');
                            if bcd_b_temp < 9 then
                                bcd_b_temp <= bcd_b_temp + 1;
                            else
                                bcd_b_temp <= (others => '0');
                                if bcd_a_temp < 9 then
                                    bcd_a_temp <= bcd_a_temp + 1;
                                elsif enable_auto_reset = '1' then
                                    bcd_a_temp <= (others => '0');
                                end if;
                            end if;
                        end if;
                    end if;
                end if;
            end if;
        end if;
    end process;
	
bcd_a <= bcd_a_temp;
bcd_b <= bcd_b_temp;
bcd_c <= bcd_c_temp;
bcd_d <= bcd_d_temp;

end Behavioral;
