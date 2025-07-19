vlib work
vmap work work

vlog  ../../hdl/lfsr_10.v
vlog  ../hdl/ck_rst_tb.v
vlog  ../hdl/lfsr_10_tst.v

vsim -novopt work.lfsr_10_tst 
do wave_lfsr_10.do

run -all

