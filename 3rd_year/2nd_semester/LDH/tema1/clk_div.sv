module clk_div #(
                 parameter int CLK_FREQ = 50_000_000,
                 parameter int TICK_FREQ = 2
                 )
   (
    input logic  clk_i,
    input logic  rst_ni,
    output logic tick_o
    );
   
   localparam int LIMIT = CLK_FREQ / TICK_FREQ - 1;
   localparam int W     = (LIMIT > 0) ? $clog2(LIMIT + 1) : 1;
   
   logic [W-1:0]  cnt;
   
   always_ff @(posedge clk_i or negedge rst_ni)
     if (~rst_ni) begin
        cnt    <= '0;
        tick_o <= 1'b0;
     end else if (cnt == W'(LIMIT)) begin
        cnt    <= '0;
        tick_o <= 1'b1;
     end else begin
        cnt    <= cnt + 1'b1;
        tick_o <= 1'b0;
     end
   
endmodule : clk_div
