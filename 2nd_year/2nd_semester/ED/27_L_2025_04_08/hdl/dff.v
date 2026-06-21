//---------------------------------------------------------------
// Proiect    : Electronica Digitala
//              Carte de invatatura
// Autor      : Dan NICULA 
// An         : 2025
//---------------------------------------------------------------
// Descriere  : Model DFF
//---------------------------------------------------------------

module dff (
input       clk , // semnal de ceas, activ pe frontul crescator
input       d   , // intrare D
output reg  q     // iesire Q
);

always @(posedge clk)
  q <= d ;

endmodule // dff