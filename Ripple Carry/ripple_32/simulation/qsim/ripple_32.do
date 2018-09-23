onerror {quit -f}
vlib work
vlog -work work ripple_32.vo
vlog -work work ripple_32.vt
vsim -novopt -c -t 1ps -L cycloneiv_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.ripple_32_vlg_vec_tst
vcd file -direction ripple_32.msim.vcd
vcd add -internal ripple_32_vlg_vec_tst/*
vcd add -internal ripple_32_vlg_vec_tst/i1/*
add wave /*
run -all
