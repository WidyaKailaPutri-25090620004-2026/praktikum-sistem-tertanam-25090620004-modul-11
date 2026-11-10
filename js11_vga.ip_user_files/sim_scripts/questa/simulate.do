onbreak {quit -f}
onerror {quit -f}

vsim  -lib xil_defaultlib tb_tugas3_opt

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

do {tb_tugas3.udo}

run 1000ns

quit -force
