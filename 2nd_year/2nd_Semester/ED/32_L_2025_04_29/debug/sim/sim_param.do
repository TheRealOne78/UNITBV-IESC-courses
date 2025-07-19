vlib work
vmap work work

vlog  ../../hdl/lfsr_param.v
vlog  ../hdl/ck_rst_tb.v
vlog  ../hdl/lfsr_param_tst.v

vsim -novopt work.lfsr_param_tst 
do wave_param.do

run -all

