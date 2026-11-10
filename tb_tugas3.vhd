library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_tugas3 is
end tb_tugas3;

architecture sim of tb_tugas3 is
  constant T40 : time := 25 ns;   -- 40 MHz
  constant T25 : time := 40 ns;   -- 25 MHz
  constant TOL : time := 1 ns;
  signal clk40, clk25 : std_logic := '0';
  signal rst : std_logic := '1';
  signal hs1, vs1, von1, hs0, vs0, von0 : std_logic;
  signal hc1, hc0 : integer range 0 to 1055;
  signal vc1, vc0 : integer range 0 to 627;
begin
  clk40 <= not clk40 after T40/2;
  clk25 <= not clk25 after T25/2;
  rst   <= '0' after 100 ns;

  u1 : entity work.vga_sync_dual
    port map (pclk => clk40, rst => rst, mode => '1', hsync => hs1, vsync => vs1,
              video_on => von1, h_count => hc1, v_count => vc1);
  u0 : entity work.vga_sync_dual
    port map (pclk => clk25, rst => rst, mode => '0', hsync => hs0, vsync => vs0,
              video_on => von0, h_count => hc0, v_count => vc0);

  -- 800x600: sync positif
  p_h1: process
    variable t0 : time;
  begin
    wait until rising_edge(hs1);  t0 := now;
    wait until falling_edge(hs1);
    assert abs((now - t0) - 128*T40) < TOL report "800x600: lebar Hsync salah" severity error;
    wait until rising_edge(hs1);
    assert abs((now - t0) - 1056*T40) < TOL report "800x600: periode Hsync salah" severity error;
    report "800x600: Hsync OK" severity note;
    wait;
  end process;

  p_v1: process
    variable t0 : time;
  begin
    wait until rising_edge(vs1);  t0 := now;
    wait until falling_edge(vs1);
    assert abs((now - t0) - 4*1056*T40) < TOL report "800x600: lebar Vsync salah" severity error;
    wait until rising_edge(vs1);
    assert abs((now - t0) - 628*1056*T40) < TOL report "800x600: periode Vsync salah" severity error;
    report "800x600: Vsync OK" severity note;
    wait;
  end process;

  -- 640x480: sync negatif
  p_h0: process
    variable t0 : time;
  begin
    wait until falling_edge(hs0);  t0 := now;
    wait until rising_edge(hs0);
    assert abs((now - t0) - 96*T25) < TOL report "640x480: lebar Hsync salah" severity error;
    wait until falling_edge(hs0);
    assert abs((now - t0) - 800*T25) < TOL report "640x480: periode Hsync salah" severity error;
    report "640x480: Hsync OK" severity note;
    wait;
  end process;

  p_v0: process
    variable t0 : time;
  begin
    wait until falling_edge(vs0);  t0 := now;
    wait until rising_edge(vs0);
    assert abs((now - t0) - 2*800*T25) < TOL report "640x480: lebar Vsync salah" severity error;
    wait until falling_edge(vs0);
    assert abs((now - t0) - 525*800*T25) < TOL report "640x480: periode Vsync salah" severity error;
    report "640x480: Vsync OK" severity note;
    wait;
  end process;
end sim;