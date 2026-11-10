library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_vga_sync is
end tb_vga_sync;

architecture sim of tb_vga_sync is
  constant T_PCLK : time := 40 ns;  -- 25 MHz
  signal pclk, rst : std_logic := '0';
  signal hsync, vsync, video_on : std_logic;
  signal h_count : integer range 0 to 799;
  signal v_count : integer range 0 to 524;
begin
  uut: entity work.vga_sync
    port map (pclk => pclk, rst => rst, hsync => hsync, vsync => vsync,
              video_on => video_on, h_count => h_count, v_count => v_count);

  pclk <= not pclk after T_PCLK/2;
  rst  <= '1', '0' after 100 ns;

  -- Cek hsync: lebar pulsa 96 clk, periode 800 clk
  p_h: process
    variable t0 : time;
  begin
    wait for 200 ns;
    for i in 1 to 3 loop
      wait until falling_edge(hsync);
      t0 := now;
      wait until rising_edge(hsync);
      assert (now - t0) = 96*T_PCLK
        report "Lebar pulsa hsync salah" severity error;
      wait until falling_edge(hsync);
      assert (now - t0) = 800*T_PCLK
        report "Periode hsync salah" severity error;
    end loop;
    wait;
  end process;

  -- Cek vsync: lebar pulsa 2 baris, periode 525 baris
  p_v: process
    variable t0 : time;
  begin
    wait for 200 ns;
    wait until falling_edge(vsync);
    t0 := now;
    wait until rising_edge(vsync);
    assert (now - t0) = 2*800*T_PCLK
      report "Lebar pulsa vsync salah" severity error;
    wait until falling_edge(vsync);
    assert (now - t0) = 525*800*T_PCLK
      report "Periode vsync salah" severity error;
    report "Simulasi selesai: pewaktuan VGA OK" severity note;
    wait;
  end process;
end sim;