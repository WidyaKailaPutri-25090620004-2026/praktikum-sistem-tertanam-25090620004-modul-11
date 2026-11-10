library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity js11_full is
  Port ( clk      : in  STD_LOGIC;
         btnC     : in  STD_LOGIC;
         sw       : in  STD_LOGIC_VECTOR(3 downto 0);
         sel_pat  : in  STD_LOGIC;
         sel_mode : in  STD_LOGIC;
         vgaRed   : out STD_LOGIC_VECTOR(3 downto 0);
         vgaGreen : out STD_LOGIC_VECTOR(3 downto 0);
         vgaBlue  : out STD_LOGIC_VECTOR(3 downto 0);
         Hsync    : out STD_LOGIC;
         Vsync    : out STD_LOGIC );
end js11_full;

architecture Behavioral of js11_full is
  component clk_wiz_0
    port ( reset    : in  std_logic;
           clk_in1  : in  std_logic;
           clk_out1 : out std_logic;
           clk_out2 : out std_logic;
           locked   : out std_logic );
  end component;

  signal clk25, clk40, pclk, locked, rst, video_on : std_logic;
  signal h_count : integer range 0 to 1055;
  signal v_count : integer range 0 to 627;
  signal rgb     : std_logic_vector(11 downto 0);
begin
  rst <= btnC or (not locked);

  u_clk : clk_wiz_0
    port map (reset => '0', clk_in1 => clk,
              clk_out1 => clk25, clk_out2 => clk40, locked => locked);

  -- pilih pixel clock sesuai mode (SW15)
  u_mux : BUFGMUX
    port map (O => pclk, I0 => clk25, I1 => clk40, S => sel_mode);

  u_sync : entity work.vga_sync_dual
    port map (pclk => pclk, rst => rst, mode => sel_mode,
              hsync => Hsync, vsync => Vsync, video_on => video_on,
              h_count => h_count, v_count => v_count);

  u_pat : entity work.pattern_gen
    port map (h_count => h_count, v_count => v_count, sw => sw,
              sel_pat => sel_pat, sel_mode => sel_mode, rgb => rgb);

  vgaRed   <= rgb(11 downto 8) when video_on = '1' else "0000";
  vgaGreen <= rgb(7 downto 4)  when video_on = '1' else "0000";
  vgaBlue  <= rgb(3 downto 0)  when video_on = '1' else "0000";
end Behavioral;