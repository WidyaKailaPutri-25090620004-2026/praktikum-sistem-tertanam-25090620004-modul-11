library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_tugas1 is
end tb_tugas1;

architecture sim of tb_tugas1 is
  signal pclk     : std_logic := '0';
  signal rst      : std_logic := '1';
  signal hsync, vsync, video_on : std_logic;
  signal h_count  : integer range 0 to 799;
  signal v_count  : integer range 0 to 524;
  signal sw       : std_logic_vector(3 downto 0) := "0000";
  signal rgb      : std_logic_vector(11 downto 0);
begin
  pclk <= not pclk after 20 ns;   -- 25 MHz
  rst  <= '0' after 100 ns;

  u_sync : entity work.vga_sync
    port map (pclk => pclk, rst => rst, hsync => hsync, vsync => vsync,
              video_on => video_on, h_count => h_count, v_count => v_count);

  u_pat : entity work.color_bar_pattern
    port map (h_count => h_count, v_count => v_count, sw => sw, rgb => rgb);
end sim;