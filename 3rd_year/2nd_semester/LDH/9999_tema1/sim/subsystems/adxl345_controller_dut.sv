module adxl345_controller_dut (
                               input  logic              clk_i,
                               input  logic              rst_ni,
                               input  logic              ack_i,
                               input  logic [7:0]        rd_data_i,
                               output logic              req_o,
                               output logic              rw_ni_o,
                               output logic [5:0]        addr_o,
                               output logic [7:0]        wr_data_o,
                               output logic              init_done_o,
                               output logic signed [9:0] accel_x_o,
                               output logic signed [9:0] accel_y_o
                               );

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

endmodule : adxl345_controller_dut
