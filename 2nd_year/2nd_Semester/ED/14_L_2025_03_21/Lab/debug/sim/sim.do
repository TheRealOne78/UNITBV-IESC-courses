vlib work
vmap work work

vlog  ../../hdl/mux4x1.v
vlog  ../hdl/gen_stimul.v
vlog  ../hdl/test.v

vsim -gui work.test

add log -r /*

#do wave.do

run -all
