vlib work
vmap work work

vlog      ../../hdl/seq_mul.v
vlog      ../hdl/ck_rst_tb.v
vlog      ../hdl/checker_rq_ack.v
vlog      ../hdl/seq_mul_test.v

vsim work.seq_mul_test 
do wave.do
add log -r /*

run -all

