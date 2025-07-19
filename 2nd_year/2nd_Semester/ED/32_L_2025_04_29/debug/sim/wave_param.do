onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radixshowbase 1 /lfsr_param_tst/clk
add wave -noupdate -radixshowbase 1 /lfsr_param_tst/rst_n
add wave -noupdate -radixshowbase 1 /lfsr_param_tst/data_4
add wave -noupdate -radix unsigned -radixshowbase 0 /lfsr_param_tst/data_4
add wave -noupdate -radixshowbase 1 /lfsr_param_tst/data_10
add wave -noupdate -radix unsigned -radixshowbase 0 /lfsr_param_tst/data_10
add wave -noupdate -radixshowbase 1 /lfsr_param_tst/lfsr4_data_1
add wave -noupdate -radixshowbase 1 /lfsr_param_tst/lfsr10_data_1
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {8029 ns} 0}
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
WaveRestoreZoom {913 ns} {1370 ns}
