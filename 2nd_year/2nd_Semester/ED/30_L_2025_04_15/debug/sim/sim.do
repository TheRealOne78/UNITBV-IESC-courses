vlib work
vmap work work

vlog  ../../hdl/fsm_1.v
vlog  ../../hdl/fsm_2.v
vlog  ../../hdl/fsm_3.v
vlog  ../../hdl/graph.v
vlog  ../../hdl/fsm_casex.v
vlog  ../hdl/fsm_test.v
vlog  ../hdl/ck_rst_tb.v

#vsim -novopt work.fsm_test
vsim -gui work.fsm_test
do wave_fsm.do

run -all
