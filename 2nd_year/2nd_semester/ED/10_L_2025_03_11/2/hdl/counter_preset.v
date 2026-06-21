//------------------------------------------------------------------------------
// Universitatea Transilvania din Brasov
// Departamentul de Electronica si Calculatoare
// Proiect     : Laborator HDL
// Modul       : counter_preset
// Autor       : Dan NICULA (DN)
// Data        : Feb. 1, 2025
//------------------------------------------------------------------------------
// Descriere   : Numarator sincron presetabil
//------------------------------------------------------------------------------

module counter_preset #(
parameter WIDTH           = 'd8           // numar de biti ai numaratorului
) (
input                     clk           , // semnal de ceas
input                     rst_n         , // semnal de reset asincron, activ low
input                     count_up      , // comanda de numarare, activa high
input                     load          , // comanda presetare, activa high, 
                                          // prioritara fata de numarare
input      [WIDTH  -1:0]  data_preset   , // data presetare
output reg [WIDTH  -1:0]  counter_out   , // iesire numarator
output                    carry_out       // transport de iesire
);

always @(posedge clk or negedge rst_n) 
if (~rst_n  ) counter_out <= {WIDTH{1'b0}}; else  // resetare asincrona
if (load    ) counter_out <= data_preset; else    // presetare
if (count_up) counter_out <= counter_out + 1;     // numarare

assign carry_out = (~load)         & // nu se incarca si
                   count_up        & // numara si
                   (&counter_out);   // valoarea curenta este cea maxima, 11...1

endmodule // counter_preset

