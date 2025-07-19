// Proiect    : Electronica Digitala - colocviu
// Autor      : BAJCSI Elias-Robert
// An         : 2025
//---------------------------------------------------------------
// Descriere  : Mediu de testare verilog pentru biletul 4
//---------------------------------------------------------------

module colocviu_tb;
   wire clk;
   wire rst_n;
   reg  dataIn;
   wire dataOut;

   /* Instantiate a clock and an active-low reset signal */
   ck_rst_tb #(
               .CK_SEMIPERIOD ('d10)
               ) i_ck_rst_tb (
                              .clk    (clk),
                              .rst_n  (rst_n)
                              );

   /* Instantiate the design under test */
   colocviu DUT (.clk    (clk),
                 .rst_n  (rst_n),
                 .dataIn (dataIn),
                 .dataOut(dataOut)
                 );


   /* Send some data through dataIn */
   initial begin
      // -- Initiate values
      dataIn <= 1'bx;
      @(negedge rst_n);
      @(posedge rst_n);

      // -- Start sending data
      dataIn <= 1'b1;
      @(posedge clk);

      dataIn <= 1'b0;
      @(posedge clk);

      dataIn  <= 1'b1;
      repeat(2) @(posedge clk);

      dataIn <= 1'b0;
      repeat(2) @(posedge clk);

      dataIn <= 1'b1;
      repeat(3) @(posedge clk);

      dataIn <= 1'b0;
      repeat(4) @(posedge clk);

      $display ("%M %0t INFO: Final simulare.", $time);
      $stop;
   end

endmodule
