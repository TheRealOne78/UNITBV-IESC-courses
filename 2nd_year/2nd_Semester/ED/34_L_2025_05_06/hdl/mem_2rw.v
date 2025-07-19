//---------------------------------------------------------------
// Proiect    : Electronica Digitala
//              Carte de invatatura
// Autor      : Dan NICULA 
// An         : 2025
//---------------------------------------------------------------
// Descriere  : Model de memorie 2RW
//---------------------------------------------------------------

///// 10 ////////////////////////////////////////////////////////
module mem_2rw  #(
parameter  ADDR_WIDTH = 8   ,
parameter  MEM_DEPTH  = 256 ,  // MEM_DEPTH <= 2^ADDR_WIDTH
parameter  WORD_BYTES =  8     // latimea datelor (biti) = 8 * WORD_BYTES
)(
input                             clk       , // ceas (front pozitiv)
// 1RW
input                             re1        , // read enable (activ 1)
input                             we1        , // write enable (activ 1)
input       [ADDR_WIDTH   -1 : 0] addr1      , // adresa scriere
input       [8*WORD_BYTES -1 : 0] wr_data1   , // date scrise
input       [WORD_BYTES   -1 : 0] be1        , // byte enable, (activ 1)
output reg  [8*WORD_BYTES -1 : 0] rd_data1   , // date citite
// 1RW
input                             re2        , // read enable (activ 1)
input                             we2        , // write enable (activ 1)
input       [ADDR_WIDTH   -1 : 0] addr2      , // adresa scriere
input       [8*WORD_BYTES -1 : 0] wr_data2   , // date scrise
input       [WORD_BYTES   -1 : 0] be2        , // byte enable, (activ 1)
output reg  [8*WORD_BYTES -1 : 0] rd_data2      // date citite
);
      
endmodule   // mem_2rw
