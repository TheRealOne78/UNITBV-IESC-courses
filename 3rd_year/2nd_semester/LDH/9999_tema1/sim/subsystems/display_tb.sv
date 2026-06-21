module display_tb;

   localparam int DISPLAYS = 6;

   logic signed [9:0]            accel_x_i;
   logic signed [9:0]            accel_y_i;
   logic                         row_o;
   logic [$clog2(DISPLAYS)-1:0]  col_o;
   logic [DISPLAYS-1:0][7:0]     seg_o;

   display_dut #(
                 .DISPLAYS (DISPLAYS)
                 ) u_dut (
                          .accel_x_i (accel_x_i),
                          .accel_y_i (accel_y_i),
                          .row_o     (row_o),
                          .col_o     (col_o),
                          .seg_o     (seg_o)
                          );

   initial begin
      $dumpfile("display_wave.vcd");
      $dumpvars(0, display_tb);

      accel_x_i = -10'sd192;
      accel_y_i = -10'sd64;
      #20;

      accel_x_i = -10'sd64;
      accel_y_i = 10'sd64;
      #20;

      accel_x_i = 10'sd0;
      accel_y_i = -10'sd32;
      #20;

      accel_x_i = 10'sd160;
      accel_y_i = 10'sd32;
      #20;

      $finish;
   end

endmodule : display_tb
