//---------------------------------------------------------------
// Proiect    : Electronica Digitala
//              Carte de invatatura
// Autor      : Dan NICULA 
// An         : 2025
//---------------------------------------------------------------
// Descriere  : Model TFF
//---------------------------------------------------------------

module tff (
input       clk   , // semnal de ceas, activ pe frontul crescator
input       rst_n , // semnal de reset asincron activ in 0
input       t     , // intrare T
output reg  q       // iesire Q
);

always @(posedge clk or negedge rst_n)
if (~rst_n) q <= 1'b0; else
if (t)      q <= ~q;  // complementeaza starea, in cazul t=1
                      // pastreaza starea, in cazul t=0

endmodule // tff

