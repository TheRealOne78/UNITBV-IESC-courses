//---------------------------------------------------------------
// Proiect    : Electronica Digitala
//              Carte de invatatura
// Autor      : Dan NICULA 
// An         : 2025
//---------------------------------------------------------------
// Descriere  : Demultiplexor 1:2^N
//---------------------------------------------------------------

module dmux1x2N #(
parameter WIDTH_SEL             = 'd1   // numar de biti 
                                        // pentru selectie
) ( 
input  [WIDTH_SEL     -1:0] sel      ,  // selectie, N biti
input                       data_in  ,  // date intrare
output [(1<<WIDTH_SEL)-1:0] data_out    // date iesire, 2^N biti
);

assign data_out = {(1<<WIDTH_SEL){data_in}} & (1 << sel);

endmodule // dmux1x2N
