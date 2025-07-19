//------------------------------------------------------------------------------
// Universitatea Transilvania din Brasov
// Departamentul de Electronica si Calculatoare
// Proiect     : Laborator HDL
// Modul       : lfsr_10
// Autor       : Dan NICULA (DN)
// Data        : Oct. 1, 2019
//------------------------------------------------------------------------------
// Descriere   : LSFR, 10 biti X10+X7+1
//------------------------------------------------------------------------------
// Modificari  :
// Oct. 1, 2019 (DN): Initial 
//------------------------------------------------------------------------------

module lfsr_10 (
                input            clk ,   // semnal de ceas,
                input            rst_n , // semnal de reset asincron activ 0
                output reg [9:0] data_o  // iesirea lfsr
                );

   always @(posedge clk or negedge rst_n)
     if (~rst_n)
       data_o <= 10'b00_0000_0001;
     else
       data_o <= {data_o[7] ^ data_o[0], data_o[9:1]};

endmodule // lfsr_10
