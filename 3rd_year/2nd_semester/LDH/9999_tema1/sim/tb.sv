module tb;

   localparam int DISPLAYS = 6;

   logic                         clk;
   logic                         rst_ni;
   logic                         ack_i;
   logic [7:0]                   rd_data_i;
   logic                         req_o;
   logic                         rw_ni_o;
   logic [5:0]                   addr_o;
   logic [7:0]                   wr_data_o;
   logic                         init_done_o;
   logic signed [9:0]            accel_x_o;
   logic signed [9:0]            accel_y_o;
   logic                         row_o;
   logic [$clog2(DISPLAYS)-1:0]  col_o;
   logic [DISPLAYS-1:0][7:0]     seg_o;

   logic                         pending_r;
   logic [1:0]                   countdown_r;
   logic                         rw_lat_r;
   logic [5:0]                   addr_lat_r;
   logic [7:0]                   data_format_r;
   logic [7:0]                   power_ctl_r;
   int                           sample_index_r;

   dut #(
         .DISPLAYS (DISPLAYS)
         ) u_dut (
                  .clk_i       (clk),
                  .rst_ni      (rst_ni),
                  .ack_i       (ack_i),
                  .rd_data_i   (rd_data_i),
                  .req_o       (req_o),
                  .rw_ni_o     (rw_ni_o),
                  .addr_o      (addr_o),
                  .wr_data_o   (wr_data_o),
                  .init_done_o (init_done_o),
                  .accel_x_o   (accel_x_o),
                  .accel_y_o   (accel_y_o),
                  .row_o       (row_o),
                  .col_o       (col_o),
                  .seg_o       (seg_o)
                  );

   function automatic logic signed [9:0] sample_x(input int sample_index);
      case (sample_index % 4)
        0: sample_x = -10'sd192;
        1: sample_x = -10'sd64;
        2: sample_x = 10'sd0;
        default: sample_x = 10'sd128;
      endcase
   endfunction

   function automatic logic signed [9:0] sample_y(input int sample_index);
      case (sample_index % 4)
        0: sample_y = -10'sd96;
        1: sample_y = 10'sd96;
        2: sample_y = -10'sd32;
        default: sample_y = 10'sd32;
      endcase
   endfunction

   function automatic logic [7:0] read_data_for_addr(
                                                  input logic [5:0] addr,
                                                  input int         sample_index
                                                  );
      logic signed [9:0] cur_x;
      logic signed [9:0] cur_y;

      cur_x = sample_x(sample_index);
      cur_y = sample_y(sample_index);

      case (addr)
        6'h31: read_data_for_addr = data_format_r;
        6'h2D: read_data_for_addr = power_ctl_r;
        6'h32: read_data_for_addr = cur_x[7:0];
        6'h33: read_data_for_addr = {6'b0, cur_x[9:8]};
        6'h34: read_data_for_addr = cur_y[7:0];
        6'h35: read_data_for_addr = {6'b0, cur_y[9:8]};
        default: read_data_for_addr = 8'h00;
      endcase
   endfunction

   initial clk = 1'b0;
   always #5 clk = ~clk;

   always_ff @(posedge clk or negedge rst_ni) begin
      if (!rst_ni) begin
         ack_i         <= 1'b0;
         rd_data_i     <= '0;
         pending_r     <= 1'b0;
         countdown_r   <= '0;
         rw_lat_r      <= 1'b1;
         addr_lat_r    <= '0;
         data_format_r <= '0;
         power_ctl_r   <= '0;
         sample_index_r <= 0;
      end else begin
         ack_i <= 1'b0;

         if (!pending_r && req_o) begin
            pending_r   <= 1'b1;
            countdown_r <= 2'd2;
            rw_lat_r    <= rw_ni_o;
            addr_lat_r  <= addr_o;

            if (!rw_ni_o) begin
               if (addr_o == 6'h31)
                 data_format_r <= wr_data_o;
               else if (addr_o == 6'h2D)
                 power_ctl_r <= wr_data_o;
            end
         end else if (pending_r && countdown_r != 0) begin
            countdown_r <= countdown_r - 1'b1;
         end else if (pending_r) begin
            pending_r <= 1'b0;
            ack_i     <= 1'b1;

            if (rw_lat_r) begin
               rd_data_i <= read_data_for_addr(addr_lat_r, sample_index_r);

               if (addr_lat_r == 6'h35)
                 sample_index_r <= sample_index_r + 1;
            end
         end
      end
   end

   initial begin
      $dumpfile("wave.vcd");
      $dumpvars(0, tb);

      rst_ni = 1'b0;
      repeat (4) @(posedge clk);
      rst_ni = 1'b1;

      repeat (80) @(posedge clk);

      $finish;
   end

endmodule : tb
