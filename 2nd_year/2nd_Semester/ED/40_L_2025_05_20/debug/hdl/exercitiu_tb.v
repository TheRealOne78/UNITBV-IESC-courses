
// Proiect    : Electronica Digitala
//              Carte de invatatura
// Autor      : Dan NICULA
// An         : 2025
//---------------------------------------------------------------
// Descriere  : Model test pentru TFF
//---------------------------------------------------------------


module exercitiu_tb;
   wire clk;
   wire rst_n;
   reg  data_in;
   wire data_out;

   ck_rst_tb #(
               .CK_SEMIPERIOD ('d10)
               ) i_ck_rst_tb (
                              .clk    (clk   ),
                              .rst_n  (rst_n )
                              );

   exercitiu DUT (.clk    (clk),
                 .rst_n   (rst_n),
                 .data_in (data_in),
                 .data_out(data_out)
                 );


   initial begin
      @(negedge rst_n);
      data_in <= 1'bx;
      @(posedge rst_n);

      data_in <= 1'b1;
      @(posedge clk);

      data_in <= 1'b0;
      @(posedge clk);

      data_in  <= 1'b1;
      repeat(2) @(posedge clk);

      data_in <= 1'b0;
      repeat(2) @(posedge clk);

      data_in <= 1'b1;
      repeat(3) @(posedge clk);

      data_in <= 1'b0;
      repeat(4) @(posedge clk);

      $display ("%M %0t INFO: Final simulare.", $time);
      $stop;
   end

endmodule
