//------------------------------------------------------------------------------
// Universitatea Transilvania din Brasov
// Departamentul de Electronica si Calculatoare
// Proiect     : Laborator HDL
// Modul       : lfsr_4
// Autor       : Dan NICULA (DN)
// Data        : Oct. 1, 2019
//------------------------------------------------------------------------------
// Descriere   : LSFR, 4 biti X4+X3+1
//------------------------------------------------------------------------------
// Modificari  :
// Oct. 1, 2019 (DN): Initial 
//------------------------------------------------------------------------------

module lfsr_4 (
               input            clk ,   // semnal de ceas,
               input            rst_n , // semnal de reset asincron activ 0
               output reg [3:0] data_o  // iesirea lfsr
               );

   always @(posedge clk or negedge rst_n)
     if (~rst_n)
       data_o <= 4'b0001;
     else
       data_o <= {data_o[3] ^ data_o[0], data_o[3:1]};

endmodule // lfsr_4
