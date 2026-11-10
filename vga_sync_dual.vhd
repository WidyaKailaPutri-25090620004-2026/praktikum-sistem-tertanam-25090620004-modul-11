library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity vga_sync_dual is
  Port ( pclk     : in  STD_LOGIC;
         rst      : in  STD_LOGIC;
         mode     : in  STD_LOGIC;
         hsync    : out STD_LOGIC;
         vsync    : out STD_LOGIC;
         video_on : out STD_LOGIC;
         h_count  : out integer range 0 to 1055;
         v_count  : out integer range 0 to 627 );
end vga_sync_dual;

architecture Behavioral of vga_sync_dual is
  signal hc : integer range 0 to 1055 := 0;
  signal vc : integer range 0 to 627  := 0;
  signal h_total, v_total, h_disp, v_disp : integer;
begin
  h_total <= 1056 when mode = '1' else 800;
  v_total <= 628  when mode = '1' else 525;
  h_disp  <= 800  when mode = '1' else 640;
  v_disp  <= 600  when mode = '1' else 480;

  process(pclk)
  begin
    if rising_edge(pclk) then
      if rst = '1' then
        hc <= 0; vc <= 0;
      elsif hc >= h_total-1 then
        hc <= 0;
        if vc >= v_total-1 then vc <= 0; else vc <= vc + 1; end if;
      else
        hc <= hc + 1;
      end if;
    end if;
  end process;

  hsync <= '1' when (mode = '1' and hc >= 840 and hc < 968) else
           '0' when (mode = '0' and hc >= 656 and hc < 752) else
           '0' when mode = '1' else '1';
  vsync <= '1' when (mode = '1' and vc >= 601 and vc < 605) else
           '0' when (mode = '0' and vc >= 490 and vc < 492) else
           '0' when mode = '1' else '1';

  video_on <= '1' when (hc < h_disp) and (vc < v_disp) else '0';
  h_count  <= hc;
  v_count  <= vc;
end Behavioral;