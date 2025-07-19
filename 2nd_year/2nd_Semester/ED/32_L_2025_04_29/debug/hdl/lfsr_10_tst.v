//------------------------------------------------------------------------------
// Universitatea Transilvania din Brasov
// Departamentul de Electronica si Calculatoare
// Proiect     : Laborator HDL
// Modul       : lfsr_10_tst
// Autor       : Dan NICULA (DN)
// Data        : Oct. 1, 2019
//------------------------------------------------------------------------------
// Descriere   : Test pentru LSFR, 10 biti X10+X7+1
//------------------------------------------------------------------------------
// Modificari  :
// Oct. 1, 2019 (DN): Initial 
//------------------------------------------------------------------------------

module lfsr_10_tst;
   wire         clk     ; // semnal de ceas,
   wire         rst_n   ; // semnal de reset asincron activ 0
   wire [9:0]   data_o  ; // iesirea lfsr

   wire         data_1  ; // data = 1

   ck_rst_tb #(
               .CK_SEMIPERIOD ('d10)
               ) i_ck_rst_tb (
                              .clk    (clk   ),
                              .rst_n  (rst_n )
                              );

   lfsr_10 i_lfsr_10(
                     .clk     (clk    ),
                     .rst_n   (rst_n  ),
                     .data_o  (data_o )
                     );

   assign data_1 = (data_o == 'd1);

   initial begin
      @(negedge rst_n);
      @(posedge rst_n);
      forever begin
         @(posedge clk)
           $display("%d %b", data_o, data_o);
         if (data_1) $stop;
      end
   end

endmodule // lfsr_10_tst
