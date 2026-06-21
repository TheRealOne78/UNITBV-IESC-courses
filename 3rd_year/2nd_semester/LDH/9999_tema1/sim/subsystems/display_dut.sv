module display_dut #(
                     parameter int DISPLAYS = 6
                     )
   (
    input  logic signed [9:0]            accel_x_i,
    input  logic signed [9:0]            accel_y_i,
    output logic                         row_o,
    output logic [$clog2(DISPLAYS)-1:0]  col_o,
    output logic [DISPLAYS-1:0][7:0]     seg_o
    );

   logic [DISPLAYS-1:0][7:0] seg_active_high;

   position_ctrl #(
                   .DISPLAYS (DISPLAYS),
                   .X_RAW_PER_COLUMN (64)
                   ) u_position_ctrl (
                                      .accel_x_i (accel_x_i),
                                      .accel_y_i (accel_y_i),
                                      .row_o     (row_o),
                                      .col_o     (col_o)
                                      );

   display_map #(
                 .DISPLAYS (DISPLAYS)
                 ) u_display_map (
                                  .row_i (row_o),
                                  .col_i (col_o),
                                  .out_o (seg_active_high)
                                  );

   assign seg_o = ~seg_active_high;

endmodule : display_dut
