//---------------------------------------------------------------
// Proiect    : Electronica Digitala
//              Carte de invatatura
// Autor      : Dan NICULA 
// An         : 2025
//---------------------------------------------------------------
// Descriere  : Multiplexor 4:1
//---------------------------------------------------------------

module mux4x1 (
               input [1:0] sel ,     // selectie, 2 biti
               input [3:0] data_in , // data de intrare, 2^2 biti
               output reg  data_out  // data de iesire
               );

   always @(*) case(sel)
                 2'b01  : data_out = data_in[1];
                 2'b10  : data_out = data_in[2];
                 2'b11  : data_out = data_in[3];
                 default: data_out = data_in[0];
               endcase

endmodule // mux4x1
