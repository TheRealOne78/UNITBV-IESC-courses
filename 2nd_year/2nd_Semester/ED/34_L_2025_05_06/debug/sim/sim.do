vlib work
vmap work work

vlog  ../../hdl/mem_1rw.v
vlog  ../hdl/ck_rst_tb.v
vlog  ../hdl/transfer_data.v
vlog  ../hdl/mem_crop_test.v

vsim -gui work.mem_crop_test
do wave.do
add log -r /*

run -all

