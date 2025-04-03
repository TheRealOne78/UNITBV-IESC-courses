//---------------------------------------------------------------
// Proiect    : Electronica Digitala
//              Carte de invatatura
// Autor      : Dan NICULA 
// An         : 2025
//---------------------------------------------------------------
// Descriere  : Regsitru DFF 8 biti
//---------------------------------------------------------------

module dff8 (
input             clk , // ceas, activ pe frontul crescator
input       [7:0] d   , // intrare D
output reg  [7:0] q     // iesire Q
);
always @(posedge clk)
  q <= d ;

endmodule // dff8