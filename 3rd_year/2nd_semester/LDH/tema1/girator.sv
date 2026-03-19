module girator #(
                 parameter int DISPLAYS = 6,
                 parameter int CLK_FREQ = 50_000_000,
                 parameter int TICK_FREQ = 2
                 )
   (
    input logic                         clk_i,
    input logic                         rst_ni,
    output logic                        row_o,
    output logic [$clog2(DISPLAYS)-1:0] col_o,
    output logic [DISPLAYS-1:0][6:0]    seg_o
    );
   
   logic                     tick;
   logic [DISPLAYS-1:0][6:0] seg_active_high;
   
   clk_div #(
             .CLK_FREQ  (CLK_FREQ),
             .TICK_FREQ (TICK_FREQ)
             ) u_clk_div (
                          .clk_i  (clk_i),
                          .rst_ni (rst_ni),
                          .tick_o (tick)
                          );
   
   position_ctrl #(
                   .DISPLAYS (DISPLAYS)
                   ) u_pos_ctrl (
                                 .clk_i  (clk_i),
                                 .rst_ni (rst_ni),
                                 .tick_i (tick),
                                 .col_o  (col_o),
                                 .row_o  (row_o)
                                 );
   
   afisare_led #(
                 .DISPLAYS (DISPLAYS)
                 ) u_afisare (
                              .row_i (row_o),
                              .col_i (col_o),
                              .out_o (seg_active_high)
                              );
   
   assign seg_o = ~seg_active_high;
   
endmodule : girator
