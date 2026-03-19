module position_ctrl #(
                       parameter int DISPLAYS = 6
                       )
   (
    input logic                         clk_i,
    input logic                         rst_ni,
    input logic                         tick_i,
    output logic [$clog2(DISPLAYS)-1:0] col_o,
    output logic                        row_o
    );
   
   localparam int W    = $clog2(DISPLAYS);
   localparam int LAST = DISPLAYS - 1;
   
   logic [W-1:0]  col_r;
   logic          row_r;
   logic          at_end;
   
   assign at_end = row_r ? (col_r == W'(LAST)) : ~|col_r;
   
   always_ff @(posedge clk_i or negedge rst_ni)
     if (~rst_ni) begin
        col_r <= '0;
        row_r <= 1'b0;
     end else if (tick_i) begin
        if (at_end)
          row_r <= ~row_r;
        else
          col_r <= col_r + (row_r ? W'(1) : W'(-1));
     end
   
   assign col_o = col_r;
   assign row_o = row_r;
   
endmodule : position_ctrl
