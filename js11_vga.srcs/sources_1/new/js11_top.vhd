library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity js11_top is
  Port ( clk      : in  STD_LOGIC;
         btnC     : in  STD_LOGIC;
         sw       : in  STD_LOGIC_VECTOR(3 downto 0);
         vgaRed   : out STD_LOGIC_VECTOR(3 downto 0);
         vgaGreen : out STD_LOGIC_VECTOR(3 downto 0);
         vgaBlue  : out STD_LOGIC_VECTOR(3 downto 0);
         Hsync    : out STD_LOGIC;
         Vsync    : out STD_LOGIC );
end js11_top;

architecture Behavioral of js11_top is
  component clk_wiz_0
    port ( reset    : in  std_logic;
           clk_in1  : in  std_logic;
           clk_out1 : out std_logic;
           locked   : out std_logic );
  end component;

  signal pclk, locked, rst, video_on : std_logic;
  signal h_count : integer range 0 to 799;
  signal v_count : integer range 0 to 524;
  signal rgb     : std_logic_vector(11 downto 0);
begin
  rst <= btnC or (not locked);

  u_clk : clk_wiz_0
    port map (reset => '0', clk_in1 => clk, clk_out1 => pclk, locked => locked);

  u_sync : entity work.vga_sync
    port map (pclk => pclk, rst => rst, hsync => Hsync, vsync => Vsync,
              video_on => video_on, h_count => h_count, v_count => v_count);

  u_pat : entity work.color_bar_pattern
    port map (h_count => h_count, v_count => v_count, sw => sw, rgb => rgb);

  vgaRed   <= rgb(11 downto 8) when video_on = '1' else "0000";
  vgaGreen <= rgb(7 downto 4)  when video_on = '1' else "0000";
  vgaBlue  <= rgb(3 downto 0)  when video_on = '1' else "0000";
end Behavioral;