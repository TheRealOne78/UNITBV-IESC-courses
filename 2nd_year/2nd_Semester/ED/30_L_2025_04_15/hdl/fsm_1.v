//------------------------------------------------------------------------------
// Universitatea Transilvania din Brasov
// Departamentul de Electronica si Calculatoare
// Proiect     : Laborator HDL
// Modul       : fsm_1
// Autor       : Dan NICULA (DN)
// Data        : Oct. 1, 2019
//------------------------------------------------------------------------------
// Descriere   : FSM modelata cu o singura specificatie always
//------------------------------------------------------------------------------
// Modificari  :
// Oct. 1, 2019 (DN): Initial
//------------------------------------------------------------------------------

module fsm_1 (
              input  clk ,     // semnal de ceas,
              input  rst_n ,   // semnal de reset asincron activ 0
              input  start ,   // start operatie
              input  zero ,    // indicator de stare
              output do_iter , // comanda pentru o iteratie
              output ready     // terminare operatie
              );
   reg [1:0] stare     ; // registru de stare

   // coduri stari (unice)
   localparam s_idle    = 2'b00;
   localparam s_initial = 2'b01;
   localparam s_iterate = 2'b10;
   localparam s_final   = 2'b11;

   // modeleaza atat circuitul combinational de stare
   // cat si registrul de stare
   always @(posedge clk or negedge rst_n)
     if (~rst_n) stare <= s_idle; else   // stare initiala a FSM
       case (stare)
         s_idle    :  if (start) stare <= s_initial;
         s_initial :  if (zero)  stare <= s_final; else
           stare <= s_iterate;
         s_iterate :  stare <= zero ? s_final : s_iterate;
         default   :  stare <= s_idle;  // s_final
       endcase

   // modeleaza circuitul combinational de iesire
   assign ready    = (stare == s_final  );
   assign do_iter  = (stare == s_iterate);

   // specificatii pasive pentru depanare
   wire dbg_idle    = (stare == s_idle   );
   wire dbg_initial = (stare == s_initial);
   wire dbg_iterate = (stare == s_iterate);
   wire dbg_final   = (stare == s_final  );

endmodule // fsm_1
