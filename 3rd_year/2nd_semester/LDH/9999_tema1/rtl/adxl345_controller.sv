module adxl345_controller (
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

   localparam int STEP_COUNT = 7;
   localparam int LOOP_START = 2;

   localparam logic [5:0] ADDR_DATA_FORMAT = 6'h31;
   localparam logic [5:0] ADDR_POWER_CTL   = 6'h2D;
   localparam logic [5:0] ADDR_DATAX0      = 6'h32;
   localparam logic [5:0] ADDR_DATAX1      = 6'h33;
   localparam logic [5:0] ADDR_DATAY0      = 6'h34;
   localparam logic [5:0] ADDR_DATAY1      = 6'h35;

   localparam logic [7:0] VAL_DATA_FORMAT = 8'h40;
   localparam logic [7:0] VAL_POWER_CTL   = 8'h08;

   typedef enum logic [1:0] {
                             STEP_WRITE = 2'd0,
                             STEP_READ  = 2'd1,
                             STEP_JUMP  = 2'd2
                             } step_kind_t;

   typedef enum logic [2:0] {
                             CAPTURE_NONE = 3'd0,
                             CAPTURE_X0   = 3'd1,
                             CAPTURE_X1   = 3'd2,
                             CAPTURE_Y0   = 3'd3,
                             CAPTURE_Y1   = 3'd4
                             } capture_kind_t;

   logic [$clog2(STEP_COUNT)-1:0] step_r;
   logic                           waiting_for_ack_r;
   logic [7:0]                     x_lsb_r;
   logic [7:0]                     y_lsb_r;
   logic signed [9:0]              x_sample_r;

   step_kind_t                     step_kind;
   capture_kind_t                  capture_kind;
   logic                           step_rw_ni;
   logic [5:0]                     step_addr;
   logic [7:0]                     step_wr_data;
   logic [$clog2(STEP_COUNT)-1:0]  jump_step;

   always_comb begin
      step_kind    = STEP_JUMP;
      capture_kind = CAPTURE_NONE;
      step_rw_ni   = 1'b1;
      step_addr    = '0;
      step_wr_data = '0;
      jump_step    = $clog2(STEP_COUNT)'(LOOP_START);

      // Steps 0-1 configure the sensor, then steps 2-5 read X and Y forever.
      case (step_r)
        0: begin
           step_kind    = STEP_WRITE;
           step_rw_ni   = 1'b0;
           step_addr    = ADDR_DATA_FORMAT;
           step_wr_data = VAL_DATA_FORMAT;
        end
        1: begin
           step_kind    = STEP_WRITE;
           step_rw_ni   = 1'b0;
           step_addr    = ADDR_POWER_CTL;
           step_wr_data = VAL_POWER_CTL;
        end
        2: begin
           step_kind    = STEP_READ;
           capture_kind = CAPTURE_X0;
           step_addr    = ADDR_DATAX0;
        end
        3: begin
           step_kind    = STEP_READ;
           capture_kind = CAPTURE_X1;
           step_addr    = ADDR_DATAX1;
        end
        4: begin
           step_kind    = STEP_READ;
           capture_kind = CAPTURE_Y0;
           step_addr    = ADDR_DATAY0;
        end
        5: begin
           step_kind    = STEP_READ;
           capture_kind = CAPTURE_Y1;
           step_addr    = ADDR_DATAY1;
        end
        default: begin
           step_kind = STEP_JUMP;
        end
      endcase
   end

   always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
         step_r            <= '0;
         waiting_for_ack_r <= 1'b0;
         req_o             <= 1'b0;
         rw_ni_o           <= 1'b1;
         addr_o            <= '0;
         wr_data_o         <= '0;
         init_done_o       <= 1'b0;
         accel_x_o         <= '0;
         accel_y_o         <= '0;
         x_lsb_r           <= '0;
         y_lsb_r           <= '0;
         x_sample_r        <= '0;
      end else begin
         req_o <= 1'b0;

         if (step_kind == STEP_JUMP) begin
            step_r <= jump_step;
         end else if (!waiting_for_ack_r) begin
            req_o             <= 1'b1;
            waiting_for_ack_r <= 1'b1;
            rw_ni_o           <= step_rw_ni;
            addr_o            <= step_addr;
            wr_data_o         <= step_wr_data;
         end else if (ack_i) begin
            waiting_for_ack_r <= 1'b0;

            case (capture_kind)
              CAPTURE_X0: x_lsb_r <= rd_data_i;
              CAPTURE_X1: x_sample_r <= {rd_data_i[1:0], x_lsb_r};
              CAPTURE_Y0: y_lsb_r <= rd_data_i;
              CAPTURE_Y1: begin
                 accel_x_o <= x_sample_r;
                 accel_y_o <= {rd_data_i[1:0], y_lsb_r};
              end
              default: begin end
            endcase

            if (step_r == 1)
              init_done_o <= 1'b1;

            if (step_r == $clog2(STEP_COUNT)'(STEP_COUNT - 2))
              step_r <= $clog2(STEP_COUNT)'(STEP_COUNT - 1);
            else
              step_r <= step_r + 1'b1;
         end
      end
   end

endmodule : adxl345_controller
