module dut #(
             parameter int DISPLAYS = 6,
             parameter int CLK_FREQ = 50_000_000,
             parameter int TICK_FREQ = CLK_FREQ
             )
   (
    input logic                         clk,
    input logic                         rst_ni,
    output logic                        row,
    output logic [$clog2(DISPLAYS)-1:0] col,
    output logic [DISPLAYS-1:0][6:0]    seg
    );
   
   girator #(
             .DISPLAYS  (DISPLAYS),
             .CLK_FREQ  (CLK_FREQ),
             .TICK_FREQ (TICK_FREQ)
             ) u_girator (
                          .clk_i (clk),
                          .rst_ni (rst_ni),
                          .row_o (row),
                          .col_o (col),
                          .seg_o (seg)
                          );
   
endmodule : dut
