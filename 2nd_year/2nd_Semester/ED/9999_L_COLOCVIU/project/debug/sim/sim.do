vlib work
vmap work work

vlog ../../hdl/colocviu.v
vlog ../hdl/ck_rst_tb.v
vlog ../hdl/colocviu_tb.v

vsim work.colocviu_tb
add log -r /*

run -all
