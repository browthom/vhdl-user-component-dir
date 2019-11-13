library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity fifo_2_bit_25_word is
port (clk : in std_logic;
	  wr_en : in std_logic;
	  wr_data : in std_logic_vector(1 downto 0);
	  af : out std_logic;
	  fifo_full : out std_logic;
	  rd_en : in std_logic;
	  rd_data : out std_logic_vector(1 downto 0);
	  ae : out std_logic;
	  fifo_empty : out std_logic);
end fifo_2_bit_25_word;

architecture Behavioral of fifo_2_bit_25_word is

type fifo_array is array (24 downto 0) of std_logic_vector (1 downto 0);
signal fifo_buffer : fifo_array := (others => "00");

-- Start the index pointer pointing to nothing
-- Index 25 happens when there is an empty fifo state
signal index_pointer : natural range 0 to 25 := 25;
signal rd_data_temp : std_logic_vector (1 downto 0) := "00";

begin
    
		
    push_pop: process(clk)
        begin
            if rising_edge(clk) then
            
                if wr_en = '1' and rd_en /= '1' then
                    fifo_buffer(24 downto 1) <= fifo_buffer(23 downto 0);
                    fifo_buffer(0) <= wr_data;
                    
                    -- If fifo is not empty
                    -- Increment pointer
                    if index_pointer < 24 then
                        index_pointer <= index_pointer + 1;
                    -- If fifo is empty
                    -- Set pointer to index 0
                    elsif index_pointer = 25 then
                        index_pointer <= 0;
                    end if;
				end if;
				if rd_en = '1' and wr_en /= '1' then
                    -- If fifo is not empty, then read
                    if index_pointer /= 25 then
                        -- Clear specified data in fifo buffer and send it
                        fifo_buffer(index_pointer) <= (others => '0');
                        rd_data_temp <= fifo_buffer(index_pointer);
                        
                        -- Decrement pointer if fifo had more than
                        -- one data entry
                        if index_pointer > 0 then
                            index_pointer <= index_pointer - 1;
                        -- Return pointer to 25 to indicate fifo is empty
                        else
                            index_pointer <= 25;
                        end if;
                    end if;
                end if;
            end if;
        end process;
	
rd_data <= rd_data_temp;
	
end Behavioral;
