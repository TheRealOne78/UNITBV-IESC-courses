onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mem_crop_test/i_mem_src/clk
add wave -noupdate -divider SRC
add wave -noupdate /mem_crop_test/i_mem_src/ce
add wave -noupdate -radix unsigned /mem_crop_test/i_mem_src/addr
add wave -noupdate -radix hexadecimal /mem_crop_test/i_mem_src/rd_data
add wave -noupdate -divider DST
add wave -noupdate -radix unsigned /mem_crop_test/i_mem_dst/ce
add wave -noupdate -radix unsigned /mem_crop_test/i_mem_dst/addr
add wave -noupdate -radix hexadecimal /mem_crop_test/i_mem_dst/wr_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {10345 ps} 0}
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
configure wave -timelineunits ps
update
WaveRestoreZoom {9692 ps} {10956 ps}
