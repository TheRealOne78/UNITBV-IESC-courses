//-----------------------------------------------------------------------------
// Universitatea Transilvania din Brasov
// Departamentul de Electronica si Calculatoare
// Proiect     : Laborator HDL
// Modul       : fsm_2
// Autor       : Dan NICULA (DN)
// Data        : Oct. 1, 2019
//------------------------------------------------------------------------------
// Descriere   : FSM modelata cu specificatie always pentru registru de stare
//               si circuit de stare modelat cu always combinational
//------------------------------------------------------------------------------
// Modificari  :
// Oct. 1, 2019 (DN): Initial
//------------------------------------------------------------------------------

module graph (input  clk ,     // semnal de ceas,
              input  rst_n ,   // semnal de reset asincron activ 0
              input  in ,    // indicator de stare
              output out // comanda pentru o iteratie
              );

   reg [1:0] stare_prezenta;
   reg [1:0] stare_viitoare;

   // coduri stari (unice)
   localparam s0 = 2'b00;
   localparam s1 = 2'b11;
   localparam s2 = 2'b10;
   localparam s3 = 2'b01;

   // modeleaza registrul de stare
   always @(posedge clk or negedge rst_n)
     if (~rst_n) stare_prezenta <= s0; else   // stare initiala a FSM
       stare_prezenta <= stare_viitoare;

   // modeleaza circuitul combinational de stare
   always @(*)
     case (stare_prezenta)
       s0:
         stare_viitoare <= in ? s0 : s2;
       s1:
         stare_viitoare <= in ? s2 : s0;
       s2:
         stare_viitoare <= in ? s2 : s3;
       s3:
         stare_viitoare <= in ? s0 : s1;
     endcase

   // modeleaza circuitul combinational de iesire
   assign out = (stare_prezenta == s1) | (stare_prezenta == s2);

endmodule // graph
