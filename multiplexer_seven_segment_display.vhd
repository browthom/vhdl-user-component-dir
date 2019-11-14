library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Author: Thomas Brown
-- Date: 11/13/19
-- Description: VHDL model that drives a seven segment display
entity multiplexer_seven_segment_display is
port (clk : in std_logic;
      input_1, input_2, input_3, input_4 : in std_logic_vector (7 downto 0);
      seg_out : out std_logic_vector (7 downto 0);
      anode_out : out std_logic_vector (3 downto 0));
end multiplexer_seven_segment_display;

architecture Structural of multiplexer_seven_segment_display is

component anode_selector is
port (sel : in std_logic_vector (1 downto 0);
      output : out std_logic_vector (3 downto 0));
end component;

component multiplexer_8_bit_4_to_1 is
port (input_1, input_2, input_3, input_4 : in std_logic_vector (7 downto 0);
      sel : in std_logic_vector (1 downto 0);
      output : out std_logic_vector (7 downto 0));
end component;

component two_bit_counter is
port (clk, reset : in std_logic;
      output : out std_logic_vector (1 downto 0));
end component;

component var_clock_divider_2 is
port (clk : in std_logic;
      divider : in natural range 0 to 25;
      clk_out : out std_logic);
end component;

signal mux_clk : std_logic;
signal mux_sel : std_logic_vector(1 downto 0);

begin

-- 7-Segment Display Circuit
mux_clk_div: var_clock_divider_2 port map (clk => clk,
                                           divider => 17,
                                           clk_out => mux_clk);

mux_cntr: two_bit_counter port map (clk => mux_clk,
                                    reset => '0',
                                    output => mux_sel);

anode_sel: anode_selector port map (sel => mux_sel,
                                    output => anode_out);

M1: multiplexer_8_bit_4_to_1 port map (input_1 => input_1,
                                       input_2 => input_2,
                                       input_3 => input_3,
                                       input_4 => input_4,
                                       sel => mux_sel,
                                       output => seg_out);

end Structural;
