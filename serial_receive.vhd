library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Author: Thomas Brown
-- Date: 11/13/19
-- Description: Takes an 8-bit input (parallel data)
--              and transmits the 8-bit data serially
--              when transmit oneshot is set to '1'.
--              
entity serial_receive is
port (clk : in std_logic;
      jtag_tx : in std_logic;
      output : out std_logic_vector(7 downto 0));
end serial_receive;

architecture Behavioral of serial_receive is

signal buffer_1, buffer_2 : std_logic_vector (7 downto 0) := (others => '0');
signal bit_number_receive : natural range 0 to 10 := 0;
-- States: '0' - Waiting State; '1' - Receiving State
signal state : std_logic := '0';
signal baud_clk : std_logic := '0';
signal jtag_rx_temp : std_logic := '1';
signal baud_reset : std_logic := '0';

signal clk_div_signal : std_logic_vector (15 downto 0) := (others => '0');

begin

state_machine: process (clk)
    begin
        if rising_edge(clk) then

            -- Put Transmitter in sending state
            if jtag_tx = '0' and state = '0' then
                state <= '1';
                baud_reset <= '1';
                
            -- Once sending state has completed,
            -- return to wait state
            elsif state = '1' and bit_number_receive = 10 then
                state <= '0';
                --baud_reset <= '1';
            else
                baud_reset <= '0';
            end if;
            
        end if;
    end process;  

baud_clock: process(clk, baud_reset)
    begin
        if baud_reset = '1' then
            clk_div_signal <= (others => '0');
            baud_clk <= '0';
        elsif rising_edge(clk) then
            -- 100 MHz / 9600 Hz = 10,416.6 => Period
            -- 10,416.6 / 2 = 5,208.3 => Half Period
            -- 0b0010_1000_1011_0001 = 10,417(_10)
            if (clk_div_signal < 5208) then
                clk_div_signal <= clk_div_signal + 1;
            else
                clk_div_signal <= (others => '0');
    
                baud_clk <= not baud_clk;
            end if;
        end if;
end process; 

bit_number_increment: process(baud_clk, baud_reset)
    begin
        if baud_reset = '1' then
            bit_number_receive <= 0;
        elsif rising_edge(baud_clk) then
            if state = '1' then
                -- Increment bit
                if (bit_number_receive < 10) then
                    bit_number_receive <= bit_number_receive + 1;
                end if;
            -- Reset bit send number for next write cycle
            elsif state = '0' then
                bit_number_receive <= 0;
            end if;
        end if;
    end process;

receive_data: process(baud_clk)
    begin
        -- The entire system should work off of one clk.
        -- Thus, just doing 'rising_edge(baud_clk)' is not advised.
        -- Resource: https://forums.xilinx.com/t5/Synthesis/LUT-Driving-Clock-Pin-How-to-rewrite/td-p/809310
        -- *Update: The above information isn't applicable to this code anymore,
        -- but is still a good information for future coding.

        -- While in transmitting state
        if rising_edge(baud_clk) then
            -- if sending state
            if state = '1' then
                -- Ensure that the index out of bounds condition
                -- never happens
                if bit_number_receive < 8 then
                    -- Send out bit
                    buffer_1(bit_number_receive) <= jtag_tx;
                else
                    buffer_2 <= buffer_1;
                end if;
                
            -- if waiting state
            elsif state = '0' then
            
            end if;
        end if;
    end process;        

output <= buffer_2;

end Behavioral;
