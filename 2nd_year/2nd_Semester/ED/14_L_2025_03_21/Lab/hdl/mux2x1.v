//---------------------------------------------------------------
// Proiect    : Electronica Digitala
//              Carte de invatatura
// Autor      : Dan NICULA 
// An         : 2025
//---------------------------------------------------------------
// Descriere  : Multiplexor 2:1
//---------------------------------------------------------------

module mux2x1 (
               input  sel ,    // selectie
               input  data_0 , // data de intrare selectata pentru sel=0
               input  data_1 , // data de intrare selectata pentru sel=1
               output data_out // data de iesire
               );

   assign data_out = sel ? data_1 : data_0;

endmodule // mux2x1
