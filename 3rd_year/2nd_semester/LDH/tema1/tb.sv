module tb;
   
   localparam int DISPLAYS = 6;
   localparam int STEPS    = 3 * 2 * DISPLAYS;
   
   logic          clk;
   logic          rst_ni;
   logic          row;
   logic [$clog2(DISPLAYS)-1:0] col;
   logic [DISPLAYS-1:0][6:0]    seg;
   
   dut #(
         .DISPLAYS (DISPLAYS)
         ) u_dut (
                  .clk    (clk),
                  .rst_ni (rst_ni),
                  .row    (row),
                  .col    (col),
                  .seg    (seg)
                  );
   
   initial clk = 1'b0;
   always #5 clk = ~clk;
   
   initial begin
      $dumpfile("wave.vcd");
      $dumpvars(0, tb);
      
      rst_ni = 1'b0;
      repeat (4) @(posedge clk);
      rst_ni = 1'b1;
      
      repeat (STEPS) @(posedge clk);
      
      $finish;
   end
   
endmodule : tb
