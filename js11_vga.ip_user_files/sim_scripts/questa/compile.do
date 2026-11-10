vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xpm
vlib questa_lib/msim/xil_defaultlib

vmap xpm questa_lib/msim/xpm
vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xpm  -incr -mfcu  -sv "+incdir+C:/AMDDesignTools/2026.1/Vivado/data/rsb/busdef" "+incdir+../../ipstatic" \
"C:/AMDDesignTools/2026.1/Vivado/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm  -93  \
"C:/AMDDesignTools/2026.1/Vivado/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -incr -mfcu  "+incdir+C:/AMDDesignTools/2026.1/Vivado/data/rsb/busdef" "+incdir+../../ipstatic" \
"../../../js11_vga.gen/sources_1/ip/clk_wiz_0/clk_wiz_0_clk_wiz.v" \
"../../../js11_vga.gen/sources_1/ip/clk_wiz_0/clk_wiz_0.v" \

vcom -work xil_defaultlib  -93  \
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

