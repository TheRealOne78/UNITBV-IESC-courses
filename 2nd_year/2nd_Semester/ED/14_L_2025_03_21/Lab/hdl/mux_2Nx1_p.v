//---------------------------------------------------------------
// Proiect    : Electronica Digitala
//              Carte de invatatura
// Autor      : Dan NICULA 
// An         : 2025
//---------------------------------------------------------------
// Descriere  : Multiplexor 2^N:1, date de latime parametrizabila
//---------------------------------------------------------------

module mux_2Nx1_p #(
parameter WIDTH_SEL            = 'd1, // numar de biti de selectie
parameter WIDTH_DATA           = 'd1  // numar de biti de date
// dimensiunea mux-ului este 2^WIDTH_SEL : 1 
// date reprezentate pe WIDTH_DATA biti
// pentru MUX 2:1 parametrii sunt cei impliciti
) (
input    [WIDTH_SEL                  -1:0] sel      , // selectie
input    [WIDTH_DATA*(1<<WIDTH_SEL)  -1:0] data_in  , // data de intrare
output   [WIDTH_DATA                 -1:0] data_out   // data de iesire
);

assign  data_out = data_in[(WIDTH_DATA*sel)+:WIDTH_DATA];

endmodule // mux_2Nx1_p

