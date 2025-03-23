vlib work
vmap work work

vlog  ../../hdl/comp_8b_int.v
vlog  ../hdl/gen_stimul.v
vlog  ../hdl/test.v

vsim -gui work.test

add log -r /*

#do wave.do

run -all
