## Clock 100 MHz
set_property -dict {PACKAGE_PIN W5 IOSTANDARD LVCMOS33} [get_ports clk]
create_clock -period 10.000 -name sys_clk [get_ports clk]

## Tombol tengah (btnC) = reset
set_property -dict {PACKAGE_PIN U18 IOSTANDARD LVCMOS33} [get_ports btnC]

## Switch SW0 - SW3: posisi kotak (Tugas 2)
set_property -dict {PACKAGE_PIN V17 IOSTANDARD LVCMOS33} [get_ports {sw[0]}]
set_property -dict {PACKAGE_PIN V16 IOSTANDARD LVCMOS33} [get_ports {sw[1]}]
set_property -dict {PACKAGE_PIN W16 IOSTANDARD LVCMOS33} [get_ports {sw[2]}]
set_property -dict {PACKAGE_PIN W17 IOSTANDARD LVCMOS33} [get_ports {sw[3]}]

## SW14 = pilih pola (0: 8 batang warna, 1: papan catur + kotak)
set_property -dict {PACKAGE_PIN R2 IOSTANDARD LVCMOS33} [get_ports sel_pat]

## SW15 = pilih mode (0: 640x480, 1: 800x600)
set_property -dict {PACKAGE_PIN T1 IOSTANDARD LVCMOS33} [get_ports sel_mode]

## VGA Merah
set_property -dict {PACKAGE_PIN G19 IOSTANDARD LVCMOS33} [get_ports {vgaRed[0]}]
set_property -dict {PACKAGE_PIN H19 IOSTANDARD LVCMOS33} [get_ports {vgaRed[1]}]
set_property -dict {PACKAGE_PIN J19 IOSTANDARD LVCMOS33} [get_ports {vgaRed[2]}]
set_property -dict {PACKAGE_PIN N19 IOSTANDARD LVCMOS33} [get_ports {vgaRed[3]}]

## VGA Hijau
set_property -dict {PACKAGE_PIN J17 IOSTANDARD LVCMOS33} [get_ports {vgaGreen[0]}]
set_property -dict {PACKAGE_PIN H17 IOSTANDARD LVCMOS33} [get_ports {vgaGreen[1]}]
set_property -dict {PACKAGE_PIN G17 IOSTANDARD LVCMOS33} [get_ports {vgaGreen[2]}]
set_property -dict {PACKAGE_PIN D17 IOSTANDARD LVCMOS33} [get_ports {vgaGreen[3]}]

## VGA Biru
set_property -dict {PACKAGE_PIN N18 IOSTANDARD LVCMOS33} [get_ports {vgaBlue[0]}]
set_property -dict {PACKAGE_PIN L18 IOSTANDARD LVCMOS33} [get_ports {vgaBlue[1]}]
set_property -dict {PACKAGE_PIN K18 IOSTANDARD LVCMOS33} [get_ports {vgaBlue[2]}]
set_property -dict {PACKAGE_PIN J18 IOSTANDARD LVCMOS33} [get_ports {vgaBlue[3]}]

## Sinkronisasi VGA
set_property -dict {PACKAGE_PIN P19 IOSTANDARD LVCMOS33} [get_ports Hsync]
set_property -dict {PACKAGE_PIN R19 IOSTANDARD LVCMOS33} [get_ports Vsync]

## Switch pemilih bukan jalur timing kritis, abaikan analisis