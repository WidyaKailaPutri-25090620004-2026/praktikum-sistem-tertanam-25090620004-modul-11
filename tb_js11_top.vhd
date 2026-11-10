library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_js11_top is
end tb_js11_top;

architecture sim of tb_js11_top is
  signal clk      : std_logic := '0';
  signal btnC     : std_logic := '0';
  signal sw       : std_logic_vector(3 downto 0) := "0000";
  signal vgaRed   : std_logic_vector(3 downto 0);
  signal vgaGreen : std_logic_vector(3 downto 0);
  signal vgaBlue  : std_logic_vector(3 downto 0);
  signal Hsync, Vsync : std_logic;
  constant T_PCLK : time := 40 ns;
  constant TOL    : time := 5 ns;
begin
  uut: entity work.js11_top
    port map (clk => clk, btnC => btnC, sw => sw,
              vgaRed => vgaRed, vgaGreen => vgaGreen, vgaBlue => vgaBlue,
              Hsync => Hsync, Vsync => Vsync);

  clk <= not clk after 5 ns;   -- 100 MHz

  p_h: process
    variable t0 : time;
  begin
    wait until falling_edge(Hsync);
    for i in 1 to 5 loop
      t0 := now;
      wait for 1 us;
      assert vgaRed = "0000" and vgaGreen = "0000" and vgaBlue = "0000"
        report "RGB tidak hitam saat blanking" severity error;
      wait until rising_edge(Hsync);
      assert abs((now - t0) - 96*T_PCLK) < TOL
        report "Lebar pulsa Hsync salah" severity error;
      wait until falling_edge(Hsync);
      assert abs((now - t0) - 800*T_PCLK) < TOL
        report "Periode Hsync salah" severity error;
    end loop;
    report "Cek Hsync selesai" severity note;
    wait;
  end process;

  p_v: process
    variable t0 : time;
  begin
    wait until falling_edge(Vsync);
    t0 := now;
    wait until rising_edge(Vsync);
    assert abs((now - t0) - 2*800*T_PCLK) < TOL
      report "Lebar pulsa Vsync salah" severity error;
    wait until falling_edge(Vsync);
    assert abs((now - t0) - 525*800*T_PCLK) < TOL
      report "Periode Vsync salah" severity error;
    report "Cek Vsync selesai: seluruh rangkaian OK" severity note;
    wait;
  end process;
end sim;