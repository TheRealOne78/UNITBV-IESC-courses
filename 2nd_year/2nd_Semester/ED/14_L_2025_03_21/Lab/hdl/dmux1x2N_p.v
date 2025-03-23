//---------------------------------------------------------------
// Proiect    : Electronica Digitala
//              Carte de invatatura
// Autor      : Dan NICULA 
// An         : 2025
//---------------------------------------------------------------
// Descriere  : Demultiplexor 1:2^N, 
//                dimensiunea dmux-ului este 1 : 2^WIDTH_SEL
//                date reprezentate pe WIDTH_DATA biti
//                pentru DMUX 1:2 parametrii sunt cei impliciti
//---------------------------------------------------------------

module dmux1x2N_p #(
parameter WIDTH_SEL        = 'd1 , // numar de biti de selectie
parameter WIDTH_DATA       = 'd1   // numar de biti de date

) (
input      [WIDTH_SEL                -1:0] sel      , // selectie
input      [WIDTH_DATA               -1:0] data_in  , // data in
output reg [WIDTH_DATA*(1<<WIDTH_SEL)-1:0] data_out   // data out
);

reg     [WIDTH_SEL -1:0] i;

always @(*)
for (i=0; i<(1<<WIDTH_SEL); i=i+1)
  data_out[(WIDTH_DATA*i)+:WIDTH_DATA] = (sel == i) & data_in;

endmodule // dmux1x2N_p

