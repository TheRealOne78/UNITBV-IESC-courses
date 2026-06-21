//------------------------------------------------------------------------------
// Universitatea Transilvania din Brasov
// Departamentul de Electronica si Calculatoare
// Proiect     : Laborator HDL
// Modul       : fsm_casex
// Autor       : Dan NICULA (DN)
// Data        : Oct. 1, 2019
//------------------------------------------------------------------------------
// Descriere   : FSM modelat cu o singura specificatie always cu casex
//------------------------------------------------------------------------------
// Modificari  :
// Oct. 1, 2019 (DN): Initial 
//------------------------------------------------------------------------------

module fsm_casex (
input             clk       , // semnal de ceas, 
input             rst_n     , // semnal de reset asincron activ 0
// intrari        
input             start     , 
input             sfarsit   ,
input             jos       , 
input             mijloc    , 
input             sus       , 
output reg [2:0]  stare       // registru de stare si iesirea
);

// coduri stari (unice)
localparam s_idle         = 3'b000;
localparam s_initial      = 3'b001;
localparam s_regular      = 3'b010;
localparam s_single_up    = 3'b011;
localparam s_single_down  = 3'b100;

// modeleaza atat circuitul combinational de stare
// cat si registrul de stare
always @(posedge clk or negedge rst_n)
if (~rst_n)  stare       <= s_idle; else   // stare initiala a FSM
casex ({start, jos, mijloc, sus, sfarsit, stare})
{5'b1_x_x_x_x, s_idle}    :   stare       <= s_initial    ;
{5'bx_x_1_x_x, s_initial} :   stare       <= s_regular    ;
{5'bx_x_0_x_x, s_initial} :   stare       <= s_single_up  ;
{5'bx_x_x_x_1, s_regular} :   stare       <= s_idle       ; // sfarsit
{5'bx_x_1_x_0, s_regular} :   stare       <= s_regular    ; // mijloc
{5'bx_x_0_1_0, s_regular} :   stare       <= s_single_up  ; // sus
{5'bx_1_0_0_0, s_regular} :   stare       <= s_single_down; // jos
// . . .     
default                   :  // {5'b00_x_x_x_x, s_idle} 
                              stare       <= s_idle       ;
endcase
            
endmodule // fsm_casex


