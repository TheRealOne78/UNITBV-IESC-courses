//------------------------------------------------------------------------------
// Universitatea Transilvania din Brasov
// Departamentul de Electronica si Calculatoare
// Proiect     : Laborator HDL
// Modul       : counter
// Autor       : Dan NICULA (DN)
// Data        : Oct. 1, 2019
//------------------------------------------------------------------------------
// Descriere   : Numarator parametrizabil cu validare
//------------------------------------------------------------------------------
// Modificari  :
// Oct. 1, 2019 (DN): Initial 
//------------------------------------------------------------------------------

module counter #(
                 parameter WIDTH = 'd4, // numarul de biti
                 parameter MODULO = 17  // lungime ciclu de numarare
                 )(
                   input                   clk ,     // semnal de ceas,
                   input                   rst_n ,   // semnal de reset asincron activ 0

                   input                   ce ,      // chip enable
                   input                   ld ,      // load
                   input                   cu ,      // count up
                   input                   cd ,      // cound down
                   input [WIDTH -1:0]      data_in , // date de intrare

                   output reg [WIDTH -1:0] data_out  // date de iesire
                   );


// ce  ld cu cd | data_out+   functie
// -------------+----------------------
//  0   -  -  - | data_out    pastreaza starea (circuit neselectat)
//  1   1  -  - | data_in     presetare
//  1   0  1  - | data_out+1  numara in sens crescator MODULO
//  1   0  0  1 | data_out-1  numara in sens descrescator MODULO
//  1   0  0  0 | data_out    pastreaza starea

   always @(posedge clk or negedge rst_n)
     if (~rst_n)
       data_out <= {WIDTH{1'b0}};
     else if (ce) begin
        if (ld)
          data_out <= data_in;
        else if (~ld && cu)
          data_out <= data_out + 1;
        else if (~ld && ~cu && cd)
          data_out <= data_out - 1;
        else if (~ld && ~cu && ~cd)
          data_out <= data_out;
     end else
       data_out <= data_out;

endmodule // counter
