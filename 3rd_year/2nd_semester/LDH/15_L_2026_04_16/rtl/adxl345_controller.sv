// Handle ADXL345 initialisation
//
// _on_reset: writes POWER_CTL = 0x08 (measurement mode) via spi_pyh
// _on_KEY[1] falling edge: issues one SPI read of register SW[5:0]
// Output: led_o

module adxl345_controller (
                           input logic        clk_i ,
                           input logic        rst_ni ,
                           
                           // Board inputs
                           input logic        key_ni ,
                           input logic [5:0]  sw_i ,
                           
                           // spi_phy request-acknowledge interface
                           input logic        ack_i ,
                           input logic [7:0]  rd_data_i,
                           output logic       req_o ,
                           output logic       rw_no ,  // 1 = read , 0 = write
                           output logic [5:0] addr_o ,
                           output logic [7:0] wr_data_o,
                           
                           output logic [7:0] led_o
                           );
   
   logic key_s0, key_s1, key_prev;
   
   always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
         key_s0   <= 1'b1;
         key_s1   <= 1'b1;
         key_prev <= 1'b1;
      end else begin
         key_s0   <= key_ni;   // 1st ff 
         key_s1   <= key_s0;   // 2nd ff (stable?)
         key_prev <= key_s1;   // 1ck copy
      end
   end
   
   // Single-cycle pulse when the button is first pressed
   logic key_fall;
   assign key_fall = key_prev & ~key_s1;
   
   // ----------------------------------------------------------------
   //  FSM
   // ----------------------------------------------------------------
   typedef enum logic [1:0] {
                             ST_INIT,       // write req
                             ST_INIT_WAIT,  // init ack
                             ST_IDLE,       // button press
                             ST_READ_WAIT   // read ack
                             } state_t;
   
   state_t       state;
   logic [7:0]   led_reg;
   
   assign led_o = led_reg;
   
   always_ff @(posedge clk_i or negedge rst_ni) begin
      if (!rst_ni) begin
         state     <= ST_INIT;
         req_o     <= 1'b0;
         rw_no     <= 1'b0;
         addr_o    <= 6'h2D;   // POWER_CTL address
         wr_data_o <= 8'h08;   // Measure bit
         led_reg   <= 8'h00;
      end else begin
         case (state)
           
           // Enable measurement mode -- POWER_CTL
           ST_INIT: begin
              req_o     <= 1'b1;
              rw_no     <= 1'b0;      // w
              addr_o    <= 6'h2D;     // POWER_CTL
              wr_data_o <= 8'h08;     // 3rd bit
              state     <= ST_INIT_WAIT;
           end
           
           ST_INIT_WAIT: begin
              if (ack_i) begin
                 req_o <= 1'b0;
                 state <= ST_IDLE;
              end
           end
           
           // Sleep for button press
           ST_IDLE: begin
              req_o <= 1'b0;
              if (key_fall) begin
                 req_o     <= 1'b1;
                 rw_no     <= 1'b1; // r
                 addr_o    <= sw_i;
                 wr_data_o <= 8'h00;
                 state     <= ST_READ_WAIT;
              end
           end
           
           ST_READ_WAIT: begin
              if (ack_i) begin
                 led_reg <= rd_data_i;
                 req_o   <= 1'b0;
                 state   <= ST_IDLE;
              end
           end
           
           default: state <= ST_IDLE;
           
         endcase
      end
   end
   
endmodule : adxl345_controller
