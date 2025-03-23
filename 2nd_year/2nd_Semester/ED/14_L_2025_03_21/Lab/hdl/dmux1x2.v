//---------------------------------------------------------------
// Proiect    : Electronica Digitala
//              Carte de invatatura
// Autor      : Dan NICULA 
// An         : 2025
//---------------------------------------------------------------
// Descriere  : Demultiplexor 1:2
//---------------------------------------------------------------

module dmux1x2 (
input   sel        , // selectie
input   data_in    , // data de intrare 
output  data_out0  , // data de iesire pentru sel=0
output  data_out1    // data de iesire pentru sel=1
);

assign data_out0 = ~sel & data_in;
assign data_out1 =  sel & data_in;

endmodule // dmux1x2
