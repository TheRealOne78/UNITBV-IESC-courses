vlib work
vmap work work

vlog  ../../hdl/tff.v
vlog  ../../hdl/dff.v
vlog  ../hdl/ck_rst_tb.v
vlog  ../hdl/tff_test.v

vsim  work.tff_test
do wave.do

add log -r /*
run -all

