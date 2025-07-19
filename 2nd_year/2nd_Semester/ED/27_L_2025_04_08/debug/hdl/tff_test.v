//---------------------------------------------------------------
// Proiect    : Electronica Digitala
//              Carte de invatatura
// Autor      : Dan NICULA 
// An         : 2025
//---------------------------------------------------------------
// Descriere  : Model test pentru TFF
//---------------------------------------------------------------

module tff_test;
   wire clk;
   wire rst_n;
   reg  t;
   wire q_d;
   wire q_t;

   ck_rst_tb #(
               .CK_SEMIPERIOD ('d10)
               ) i_ck_rst_tb (
                              .clk    (clk   ),
                              .rst_n  (rst_n )
                              );

   initial begin
      t <= 1'bx;
      @(negedge rst_n);
      @(posedge rst_n);
      t <= 1'b0;
      @(posedge clk);
      @(posedge clk);
      t <= 1'b1;
      @(posedge clk);
      t <= 1'b0;
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      t <= 1'b1;
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      t <= 1'b0;
      @(posedge clk);
      t <= 1'b1;
      @(posedge clk);
      @(posedge clk);
      t <= 1'b0;
      @(posedge clk);
      @(posedge clk);
      t <= 1'b1;
      @(posedge clk);
      t <= 1'b0;
      @(posedge clk);

      $display ("%M %0t INFO: Final simulare.", $time);
      $stop;
   end

   tff i_tff(
             .clk   (clk  ),
             .rst_n (rst_n),
             .t     (t    ),
             .q     (q_t    )
             );

   dff i_dff(
             .clk   (clk  ),
             .d     (t    ),
             .q     (q_d    )
             );

endmodule // tff_test
