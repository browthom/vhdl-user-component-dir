library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity serial_transmit is
port (clk : in std_logic;
      transmit_oneshot : in std_logic;
      switches : in std_logic_vector(7 downto 0);
      jtag_rx : out std_logic);
end serial_transmit;

architecture Behavioral of serial_transmit is

signal switch_buffer : std_logic_vector (7 downto 0) := b"0000_0000";
signal bit_number_send : natural := 0;
signal state : std_logic := '0';
signal baud_clk : std_logic := '0';

signal clk_div_signal : std_logic_vector (15 downto 0) := b"0000_0000_0000_0000";

begin

    state_machine: process (clk)
        begin
            if rising_edge(clk) then
            
                -- Put Transmitter in sending state
                if transmit_oneshot = '1' and state = '0' then
                    state <= '1';
                    switch_buffer <= switches;
                    
                -- Once sending state has completed,
                -- return to wait state
                elsif state = '1' and bit_number_send = 10 then
                    state <= '0';
                end if;
            end if;
        end process;  
        
    baud_clock: process(clk)
        begin
            if rising_edge(clk) then
                -- 100 MHz / 9600 Hz = 10,416.6 => Period
                -- 10,416.6 / 2 = 5,208.3 => Half Period
                -- 0b0010_1000_1011_0001 = 10,417(_10)
                if (clk_div_signal < 5208) then
                    clk_div_signal <= clk_div_signal + 1;
                else
                    clk_div_signal <= b"0000_0000_0000_0000";
                    
                    if (baud_clk = '0') then
                        baud_clk <= '1';
                    else
                        baud_clk <= '0';
                    end if;
                end if;
            end if;
        end process; 
        
    bit_number_increment: process(baud_clk)
        begin
            if rising_edge(baud_clk) then
                if state = '1' then
                    -- Increment bit
                    if (bit_number_send < 10) then
                        bit_number_send <= bit_number_send + 1;
                    end if;
                -- Reset bit send number for next write cycle
                elsif state = '0' then
                    bit_number_send <= 0;
                end if;
            end if;
        end process;
        
    transmit_data: process(baud_clk)
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
                    if bit_number_send >= 1 and bit_number_send <= 8 then
                        -- Send out bit
                        jtag_rx <= switch_buffer(bit_number_send-1);
                    elsif bit_number_send = 0 then
                        jtag_rx <= '0';
                    elsif bit_number_send = 9 then
                        jtag_rx <= '1';
                    end if;
                -- if waiting state
                elsif state = '0' then
                    jtag_rx <= '1';
                end if;
            end if;
        end process;        

end Behavioral;
