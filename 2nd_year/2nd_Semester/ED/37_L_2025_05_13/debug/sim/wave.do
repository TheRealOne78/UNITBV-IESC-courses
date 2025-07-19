onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /seq_mul_test/i_seq_mul/clk
add wave -noupdate /seq_mul_test/i_seq_mul/rst_n
add wave -noupdate /seq_mul_test/i_seq_mul/req
add wave -noupdate -radix hexadecimal /seq_mul_test/i_seq_mul/req_data
add wave -noupdate -radix unsigned -radixshowbase 0 /seq_mul_test/i_seq_mul/op1
add wave -noupdate -radix unsigned -radixshowbase 0 /seq_mul_test/i_seq_mul/op2
add wave -noupdate /seq_mul_test/i_seq_mul/ack
add wave -noupdate -radix unsigned -radixshowbase 0 /seq_mul_test/i_seq_mul/ack_data
add wave -noupdate /seq_mul_test/i_seq_mul/start
add wave -noupdate -radix unsigned /seq_mul_test/i_seq_mul/iteration
add wave -noupdate /seq_mul_test/i_seq_mul/stop_op2_1
add wave -noupdate /seq_mul_test/i_seq_mul/stop_op_0
add wave -noupdate /seq_mul_test/i_seq_mul/stop_op_n0
add wave -noupdate /seq_mul_test/i_seq_mul/op1_eq_0
add wave -noupdate /seq_mul_test/i_seq_mul/op2_eq_0
add wave -noupdate /seq_mul_test/i_seq_mul/op2_eq_1
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {991 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 127
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {1124 ps}
