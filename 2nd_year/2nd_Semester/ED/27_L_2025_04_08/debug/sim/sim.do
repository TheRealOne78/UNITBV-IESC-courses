vlib work
vmap work work

vlog  ../../hdl/front.v
vlog  ../hdl/ck_rst_tb.v
vlog  ../hdl/front_test.v

vsim  work.front_test
do wave.do

add log -r /*
run -all

