library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity color_bar_pattern is
  Port ( h_count : in  integer range 0 to 799;
         v_count : in  integer range 0 to 524;
         sw      : in  STD_LOGIC_VECTOR(3 downto 0);
         rgb     : out STD_LOGIC_VECTOR(11 downto 0) );
end color_bar_pattern;

architecture Behavioral of color_bar_pattern is
  signal hu, vu : unsigned(9 downto 0);
  signal chk    : std_logic;
  signal box_x  : integer range 0 to 600;
  signal in_box : std_logic;
begin
  hu <= to_unsigned(h_count, 10);
  vu <= to_unsigned(v_count, 10);

  -- Tugas 1: papan catur (bit 5 = kotak 32x32 piksel)
  chk <= hu(5) xor vu(5);

  -- Tugas 2: posisi kotak = sw * 40 piksel (0..600)
  box_x  <= to_integer(unsigned(sw)) * 40;
  in_box <= '1' when (h_count >= box_x) and (h_count < box_x + 40) and
                     (v_count >= 200) and (v_count < 240) else '0';

  rgb <= x"F00" when in_box = '1' else   -- kotak merah
         x"FFF" when chk = '1'    else   -- kotak putih
         x"000";                         -- kotak hitam
end Behavioral;