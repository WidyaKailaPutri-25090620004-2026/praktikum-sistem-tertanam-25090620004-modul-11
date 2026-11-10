library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pattern_gen is
  Port ( h_count  : in  integer range 0 to 1055;
         v_count  : in  integer range 0 to 627;
         sw       : in  STD_LOGIC_VECTOR(3 downto 0);
         sel_pat  : in  STD_LOGIC;
         sel_mode : in  STD_LOGIC;
         rgb      : out STD_LOGIC_VECTOR(11 downto 0) );
end pattern_gen;

architecture Behavioral of pattern_gen is
  signal hu, vu : unsigned(10 downto 0);
  signal chk    : std_logic;
  signal box_x  : integer range 0 to 600;
  signal in_box : std_logic;
  signal z      : integer range 0 to 15;
  signal bar    : std_logic_vector(11 downto 0);
begin
  hu <= to_unsigned(h_count, 11);
  vu <= to_unsigned(v_count, 11);

  -- Prosedur: 8 batang (lebar 80 px untuk 640, 100 px untuk 800)
  z <= h_count / 100 when sel_mode = '1' else h_count / 80;
  bar <= x"FFF" when z = 0 else
         x"FF0" when z = 1 else
         x"0FF" when z = 2 else
         x"0F0" when z = 3 else
         x"F0F" when z = 4 else
         x"F00" when z = 5 else
         x"00F" when z = 6 else
         x"000";

  -- Tugas 1: papan catur 32x32 piksel
  chk <= hu(5) xor vu(5);

  -- Tugas 2: kotak 40x40, x = sw * 40
  box_x  <= to_integer(unsigned(sw)) * 40;
  in_box <= '1' when (h_count >= box_x) and (h_count < box_x + 40) and
                     (v_count >= 200) and (v_count < 240) else '0';

  rgb <= bar   when sel_pat = '0' else
         x"F00" when in_box = '1' else
         x"FFF" when chk = '1'    else
         x"000";
end Behavioral;