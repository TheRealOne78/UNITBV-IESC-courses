// Proiect    : Electronica Digitala
//              Carte de invatatura
// Autor      : Dan NICULA
// An         : 2025
//---------------------------------------------------------------
// Descriere  : Model test pentru TFF
//---------------------------------------------------------------

module flip_flops_test;
   wire clk;
   wire rst_n;
   reg  j;
   reg  k;
   wire q;

   ck_rst_tb #(
               .CK_SEMIPERIOD ('d10)
               ) i_ck_rst_tb (
                              .clk    (clk   ),
                              .rst_n  (rst_n )
                              );

   initial begin
      j <= 1'bx;
      k <= 1'bx;
      @(negedge rst_n);
      @(posedge clk);
      j <= 1'b0;
      k <= 1'b0;
      @(posedge clk);
      j <= 1'b0;
      k <= 1'b1;
      @(posedge clk);
      j <= 1'b1;
      k <= 1'b0;
      @(posedge clk);
      j <= 1'b1;
      k <= 1'b1;
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      j <= 1'b0;
      k <= 1'b1;
      @(posedge clk);
      j <= 1'b1;
      k <= 1'b1;
      @(posedge clk);
      j <= 1'b0;
      k <= 1'b1;
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);

      $display ("%M %0t INFO: Final simulare.", $time);
      $stop;
   end

   jkff i_jkff(
               .clk(clk),
               .rst_n (rst_n),
               .j(j),
               .k(k),
               .q(q)
               );

   //tff i_tff(
   //          .clk   (clk  ),
   //          .rst_n (rst_n),
   //          .t     (t    ),
   //          .q     (q_t    )
   //          );

   //dff i_dff(
   //          .clk   (clk  ),
   //          .d     (t    ),
   //          .q     (q_d    )
   //          );

endmodule // tff_test
