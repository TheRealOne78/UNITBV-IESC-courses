//---------------------------------------------------------------
// Proiect    : Electronica Digitala
//              Carte de invatatura
// Autor      : Dan NICULA 
// An         : 2025
//---------------------------------------------------------------
// Descriere  : Model de memorie 1R1W
//---------------------------------------------------------------

///// 10 ////////////////////////////////////////////////////////
module mem_1r1w  #(
parameter  ADDR_WIDTH = 8   ,
parameter  MEM_DEPTH  = 256 ,  // MEM_DEPTH <= 2^ADDR_WIDTH
parameter  WORD_BYTES =  8     // latimea datelor (biti) = 8 * WORD_BYTES
)(
input                             clk       , // ceas (front pozitiv)
// 1R
input                             re        , // read enable (activ 1)
input       [ADDR_WIDTH   -1 : 0] rd_addr   , // adresa citire
output reg  [8*WORD_BYTES -1 : 0] rd_data   ,  // date citite
// 1W
input                             we        , // write enable (activ 1)
input       [ADDR_WIDTH   -1 : 0] wr_addr   , // adresa scriere
input       [8*WORD_BYTES -1 : 0] wr_data   , // date scrise
input       [WORD_BYTES   -1 : 0] be          // byte enable, (activ 1)
);
      
endmodule   // mem_1r1w
