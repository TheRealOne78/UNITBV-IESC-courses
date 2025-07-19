onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tff_test/i_tff/clk
add wave -noupdate /tff_test/i_tff/rst_n
add wave -noupdate /tff_test/i_tff/t
add wave -noupdate /tff_test/i_tff/q
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 79
configure wave -valuecolwidth 38
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {464 ps}
