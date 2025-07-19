vlib work
vmap work work

vlog      ../../hdl/exercitiu.v
vlog      ../hdl/ck_rst_tb.v
vlog      ../hdl/exercitiu_tb.v

vsim work.exercitiu_tb
do wave.do
add log -r /*

run -all

