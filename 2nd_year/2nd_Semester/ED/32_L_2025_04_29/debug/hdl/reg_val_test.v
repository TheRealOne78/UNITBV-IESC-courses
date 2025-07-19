//------------------------------------------------------------------------------
// Universitatea Transilvania din Brasov
// Departamentul de Electronica si Calculatoare
// Proiect     : Laborator HDL
// Modul       : fsm_test
// Autor       : Dan NICULA (DN)
// Data        : Oct. 1, 2019
//------------------------------------------------------------------------------
// Descriere   : Test pentru FSM modelat în mai multe moduri
//------------------------------------------------------------------------------
// Modificari  :
// Oct. 1, 2019 (DN): Initial
//------------------------------------------------------------------------------

module reg_val_test;
   wire clk;
   wire rst_n;

   reg load;
   reg [8:0] data_in;

   wire [8:0] out;

   ck_rst_tb #(
               .CK_SEMIPERIOD ('d10)
               ) i_ck_rst_tb (
                              .clk    (clk   ),
                              .rst_n  (rst_n )
                              );

   initial begin
      @(negedge rst_n);
      load <= 1'bx;
      @(negedge rst_n);
      load <= 1'b0;
      repeat (5) @(posedge clk);

      load <= 1'b1;
      @(posedge clk);
      load  <= 1'b0;
      @(posedge clk);
      load <= 1'b1;
      @(posedge clk);

      load <= 1'b0;
      repeat(10) @(posedge clk);

      $display ("%M %0t INFO: Final simulare.", $time);
      $stop;
   end

   reg_val i_reg_val (.clk     (clk),
                      .rst_n   (rst_n),
                      .load    (load),
                      .data_in (data_in),
                      .data_out(data_out)
                      );

endmodule // fsm_test
