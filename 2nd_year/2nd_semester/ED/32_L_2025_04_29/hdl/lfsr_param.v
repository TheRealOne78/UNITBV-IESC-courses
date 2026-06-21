//------------------------------------------------------------------------------
// Universitatea Transilvania din Brasov
// Departamentul de Electronica si Calculatoare
// Proiect     : Laborator HDL
// Modul       : lfsr_param
// Autor       : Dan NICULA (DN)
// Data        : Oct. 1, 2019
//------------------------------------------------------------------------------
// Descriere   : LSFR paramewtrizabil
//------------------------------------------------------------------------------
// Modificari  :
// Oct. 1, 2019 (DN): Initial 
//------------------------------------------------------------------------------

module lfsr_param #(
                    parameter WIDTH = 'd10 ,           // numarul de biti
                    parameter POLINOM = 'b00_1000_0001 // polinomul caracteristic
                    // implicit X10+X7+1
                    )(
                      input                    clk ,   // semnal de ceas,
                      input                    rst_n , // semnal de reset asincron activ 0
                      output reg [WIDTH - 1:0] data_o  // iesirea lfsr
                      );

   always @(posedge clk or negedge rst_n)
     if (~rst_n)
       data_o <= 'd1;
     else
       data_o <= {^(data_o & POLINOM), data_o[WIDTH-1:1]};

endmodule // lfsr_param
