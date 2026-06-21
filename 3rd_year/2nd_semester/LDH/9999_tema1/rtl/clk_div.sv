module clk_div #(
                 parameter int CLK_FREQ = 50_000_000,
                 parameter int TICK_FREQ = 1
                 )
   (
    input logic  clk_i,
    input logic  rst_ni,
    output logic tick_o
    );
   
   localparam int COUNT_LIMIT = CLK_FREQ / TICK_FREQ - 1;
   localparam int W           = (COUNT_LIMIT > 0) ? $clog2(COUNT_LIMIT + 1) : 1;
   
   logic [W-1:0]  cnt;
   
   always_ff @(posedge clk_i or negedge rst_ni) begin
     if (~rst_ni) begin
        cnt    <= '0;
        tick_o <= 1'b0;
     end else if (cnt == W'(COUNT_LIMIT)) begin
        cnt    <= '0;
        tick_o <= 1'b1;
     end else begin
        cnt    <= cnt + 1'b1;
        tick_o <= 1'b0;
     end
   end
   
endmodule : clk_div
