//------------------------------------------------------------------------------
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

module fsm_2 (
input     clk       , // semnal de ceas, 
input     rst_n     , // semnal de reset asincron activ 0
input     start     , // start operatie
input     zero      , // indicator de stare
output    do_iter   , // comanda pentru o iteratie
output    ready       // terminare operatie
);

reg [1:0] stare_prezenta;
reg [1:0] stare_viitoare;

// coduri stari (unice)
localparam s_idle    = 2'b00;
localparam s_initial = 2'b11;
localparam s_iterate = 2'b10;
localparam s_final   = 2'b01;

// modeleaza registrul de stare
always @(posedge clk or negedge rst_n)
if (~rst_n) stare_prezenta <= s_idle; else   // stare initiala a FSM
            stare_prezenta <= stare_viitoare;
            
// modeleaza circuitul combinational de stare
always @(*)
case (stare_prezenta)
s_idle    :  if (start) stare_viitoare <= s_initial; else
                        stare_viitoare <= s_idle;
s_initial :  if (zero)  stare_viitoare <= s_final; else
                        stare_viitoare <= s_iterate;
s_iterate :  stare_viitoare <= zero ? s_final : s_iterate;
default   :  stare_viitoare <= s_idle;  // s_final
endcase
            
// modeleaza circuitul combinational de iesire
assign ready    = (stare_prezenta == s_final  );
assign do_iter  = (stare_prezenta == s_iterate);

endmodule // fsm_2
