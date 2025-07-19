vlib work
vmap work work

vlog  ../../hdl/lfsr_10.v
vlog  ../../hdl/reg_val.v
vlog  ../hdl/ck_rst_tb.v
vlog  ../hdl/lfsr_10_tst.v
vlog  ../hdl/reg_val_test.v

vsim work.reg_val_test
do wave.do

run -all

