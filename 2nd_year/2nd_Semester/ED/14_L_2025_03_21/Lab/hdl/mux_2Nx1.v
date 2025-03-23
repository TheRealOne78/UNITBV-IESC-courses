//---------------------------------------------------------------
// Proiect    : Electronica Digitala
//              Carte de invatatura
// Autor      : Dan NICULA 
// An         : 2025
//---------------------------------------------------------------
// Descriere  : Multiplexor 2^N:1
//---------------------------------------------------------------

module mux_2Nx1 #(
parameter WIDTH_SEL            = 'd1      // numar de biti 
                                          // pentru selectie
)(
input   [WIDTH_SEL       -1:0] sel      , // selectie
input   [(1<<WIDTH_SEL)  -1:0] data_in  , // data de intrare
output                         data_out   // data de iesire
);

assign data_out = data_in[sel];

endmodule // mux_2Nx1
