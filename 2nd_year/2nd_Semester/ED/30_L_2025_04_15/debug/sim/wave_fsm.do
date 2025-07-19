onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /fsm_test/clk
add wave -noupdate /fsm_test/rst_n
add wave -noupdate /fsm_test/start
add wave -noupdate /fsm_test/zero
add wave -noupdate -divider FSM_1
add wave -noupdate -color Violet -itemcolor Violet /fsm_test/i_fsm_1/stare
add wave -noupdate -color Gold -itemcolor Gold /fsm_test/i_fsm_1/dbg_idle
add wave -noupdate -color Gold -itemcolor Gold /fsm_test/i_fsm_1/dbg_initial
add wave -noupdate -color Gold -itemcolor Gold /fsm_test/i_fsm_1/dbg_iterate
add wave -noupdate -color Gold -itemcolor Gold /fsm_test/i_fsm_1/dbg_final
add wave -noupdate /fsm_test/do_iter_1
add wave -noupdate /fsm_test/ready_1
add wave -noupdate -divider FSM_2
add wave -noupdate -color Violet -itemcolor Violet /fsm_test/i_fsm_2/stare
add wave -noupdate /fsm_test/do_iter_2
add wave -noupdate /fsm_test/ready_2
add wave -noupdate -divider FSM_3
add wave -noupdate -color Violet -itemcolor Violet /fsm_test/i_fsm_3/s_idle
add wave -noupdate -color Violet -itemcolor Violet /fsm_test/i_fsm_3/s_initial
add wave -noupdate -color Violet -itemcolor Violet /fsm_test/i_fsm_3/s_iterate
add wave -noupdate -color Violet -itemcolor Violet /fsm_test/i_fsm_3/s_final
add wave -noupdate /fsm_test/do_iter_3
add wave -noupdate /fsm_test/ready_3
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {457 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ns} {2828 ns}
