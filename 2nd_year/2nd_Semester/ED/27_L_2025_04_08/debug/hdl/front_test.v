// Proiect    : Electronica Digitala
//              Carte de invatatura
// Autor      : Dan NICULA
// An         : 2025
//---------------------------------------------------------------
// Descriere  : Model test pentru TFF
//---------------------------------------------------------------

module front_test;
   wire clk;
   wire rst_n;
   reg  in;
   wire pos_edge;
   wire neg_edge;
   wire any_edge;

   ck_rst_tb #(
               .CK_SEMIPERIOD ('d10)
               ) i_ck_rst_tb (
                              .clk(clk   ),
                              .rst_n(rst_n )
                              );

   initial begin
      in <= 1'bx;
      @(negedge rst_n);
      @(posedge clk);
      in <= 1'b1;
      @(posedge clk);
      in <= 1'b0;
      @(posedge clk);
      in <= 1'b1;
      @(posedge clk);
      in <= 1'b0;
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);
      in <= 1'b1;
      @(posedge clk);
      @(posedge clk);
      @(posedge clk);

      $display ("%M %0t INFO: Final simulare.", $time);
      $stop;
   end


   front i_front(
                 .clk(clk),
                 .rst_n(rst_n),
                 .in(in),
                 .pos_edge(pos_edge),
                 .neg_edge(neg_edge),
                 .any_edge(any_edge)
             );

endmodule // tff_test
