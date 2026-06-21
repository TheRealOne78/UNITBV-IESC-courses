module adxl345_controller_tb;

   logic              clk;
   logic              rst_ni;
   logic              ack_i;
   logic [7:0]        rd_data_i;
   logic              req_o;
   logic              rw_ni_o;
   logic [5:0]        addr_o;
   logic [7:0]        wr_data_o;
   logic              init_done_o;
   logic signed [9:0] accel_x_o;
   logic signed [9:0] accel_y_o;

   logic              pending_r;
   logic [1:0]        countdown_r;
   logic              rw_lat_r;
   logic [5:0]        addr_lat_r;

   adxl345_controller_dut u_dut (
                                 .clk_i      (clk),
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

   initial clk = 1'b0;
   always #5 clk = ~clk;

   always_ff @(posedge clk or negedge rst_ni) begin
      if (!rst_ni) begin
         ack_i       <= 1'b0;
         rd_data_i   <= '0;
         pending_r   <= 1'b0;
         countdown_r <= '0;
         rw_lat_r    <= 1'b1;
         addr_lat_r  <= '0;
      end else begin
         ack_i <= 1'b0;

         if (!pending_r && req_o) begin
            pending_r   <= 1'b1;
            countdown_r <= 2'd1;
            rw_lat_r    <= rw_ni_o;
            addr_lat_r  <= addr_o;
         end else if (pending_r && countdown_r != 0) begin
            countdown_r <= countdown_r - 1'b1;
         end else if (pending_r) begin
            pending_r <= 1'b0;
            ack_i     <= 1'b1;

            if (rw_lat_r) begin
               case (addr_lat_r)
                 6'h32: rd_data_i <= 8'h80;
                 6'h33: rd_data_i <= 8'h01;
                 6'h34: rd_data_i <= 8'h40;
                 6'h35: rd_data_i <= 8'h03;
                 default: rd_data_i <= 8'h00;
               endcase
            end
         end
      end
   end

   initial begin
      $dumpfile("adxl345_controller_wave.vcd");
      $dumpvars(0, adxl345_controller_tb);

      rst_ni = 1'b0;
      repeat (4) @(posedge clk);
      rst_ni = 1'b1;

      repeat (40) @(posedge clk);

      $finish;
   end

endmodule : adxl345_controller_tb
