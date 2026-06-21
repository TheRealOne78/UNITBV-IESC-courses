module dut #(
             parameter int DISPLAYS = 6,
             parameter int X_RAW_PER_COLUMN = 64
             )
   (
    input logic                         clk_i,
    input logic                         rst_ni,
    input logic                         ack_i,
    input logic [7:0]                   rd_data_i,
    output logic                        req_o,
    output logic                        rw_ni_o,
    output logic [5:0]                  addr_o,
    output logic [7:0]                  wr_data_o,
   output logic                        init_done_o,
   output logic signed [9:0]           accel_x_o,
   output logic signed [9:0]           accel_y_o,
   output logic                        row_o,
    output logic [$clog2(DISPLAYS)-1:0] col_o,
    output logic [DISPLAYS-1:0][7:0]    seg_o
    );

   logic [DISPLAYS-1:0][7:0] seg_active_high;

   adxl345_controller u_adxl345_controller (
                                            .clk_i      (clk_i),
                                            .rst_ni     (rst_ni),
                                            .ack_i      (ack_i),
                                            .rd_data_i  (rd_data_i),
                                            .req_o      (req_o),
                                            .rw_ni_o    (rw_ni_o),
                                            .addr_o     (addr_o),
                                            .wr_data_o  (wr_data_o),
                                            .init_done_o(init_done_o),
                                            .accel_x_o  (accel_x_o),
                                            .accel_y_o  (accel_y_o)
                                            );

   position_ctrl #(
                   .DISPLAYS (DISPLAYS),
                   .X_RAW_PER_COLUMN (X_RAW_PER_COLUMN)
                   ) u_position_ctrl (
                                      .accel_x_i (accel_x_o),
                                      .accel_y_i (accel_y_o),
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

endmodule : dut
