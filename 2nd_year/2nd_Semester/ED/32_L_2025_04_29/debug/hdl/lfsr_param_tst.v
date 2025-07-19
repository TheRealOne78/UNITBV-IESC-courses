//------------------------------------------------------------------------------
// Universitatea Transilvania din Brasov
// Departamentul de Electronica si Calculatoare
// Proiect     : Laborator HDL
// Modul       : lfsr_param_tst
// Autor       : Dan NICULA (DN)
// Data        : Oct. 1, 2019
//------------------------------------------------------------------------------
// Descriere   : Test pentru LSFR, 10 biti X10+X7+1
//------------------------------------------------------------------------------
// Modificari  :
// Oct. 1, 2019 (DN): Initial 
//------------------------------------------------------------------------------

module lfsr_param_tst;
   wire             clk     ; // semnal de ceas,
   wire             rst_n   ; // semnal de reset asincron activ 0
   wire [4  -1:0]   data_4  ; // iesirea lfsr pe 4 biti
   wire [10 -1:0]   data_10 ; // iesirea lfsr pe 10 biti

   wire             lfsr4_data_1   ; // data = 1 pentru lfsr4
   wire             lfsr10_data_1  ; // data = 1 pentru lfsr10

   ck_rst_tb #(
               .CK_SEMIPERIOD ('d10)
               ) i_ck_rst_tb (
                              .clk    (clk   ),
                              .rst_n  (rst_n )
                              );

   lfsr_param #(
                .WIDTH     ('d4            ),
                .POLINOM   (4'b1001        )
                ) i_lfsr_4 (
                            .clk     (clk    ),
                            .rst_n   (rst_n  ),
                            .data_o  (data_4 )
                            );

   lfsr_param #(
                .WIDTH     ('d10            ),
                .POLINOM   (10'b00_1000_0001)
                ) i_lfsr_10 (
                             .clk     (clk    ),
                             .rst_n   (rst_n  ),
                             .data_o  (data_10 )
                             );

   assign lfsr4_data_1  = (data_4 == 'd1);
   assign lfsr10_data_1 = (data_10 == 'd1);

   initial begin
      @(negedge rst_n);
      @(posedge rst_n);
      forever begin
         @(posedge clk)
           if (lfsr10_data_1) $stop;
      end
   end

endmodule // lfsr_param_tst
