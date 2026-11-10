transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib riviera/xpm
vlib riviera/xil_defaultlib

vmap xpm riviera/xpm
vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xpm  -incr "+incdir+C:/AMDDesignTools/2026.1/Vivado/data/rsb/busdef" "+incdir+../../ipstatic" -l xpm -l xil_defaultlib \
"C:/AMDDesignTools/2026.1/Vivado/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -93  -incr \
"C:/AMDDesignTools/2026.1/Vivado/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+C:/AMDDesignTools/2026.1/Vivado/data/rsb/busdef" "+incdir+../../ipstatic" -l xpm -l xil_defaultlib \
"../../../js11_vga.gen/sources_1/ip/clk_wiz_0/clk_wiz_0_clk_wiz.v" \
"../../../js11_vga.gen/sources_1/ip/clk_wiz_0/clk_wiz_0.v" \

vcom -work xil_defaultlib -93  -incr \
"../../../color_bar_pattern.vhd" \
"../../../vga_sync.vhd" \
"../../../js11_vga.srcs/sources_1/new/js11_top.vhd" \
"../../../vga_sync_dual.vhd" \
"../../../pattern_gen.vhd" \
"../../../js11_full.vhd" \
"../../../tb_js11_top.vhd" \
"../../../tb_vga_sync.vhd" \
"../../../tb_tugas1.vhd" \
"../../../tb_tugas2.vhd" \
"../../../tb_tugas3.vhd" \

vlog -work xil_defaultlib \
"glbl.v"

