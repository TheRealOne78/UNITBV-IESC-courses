//------------------------------------------------------------------------------
// Universitatea Transilvania din Brasov
// Departamentul de Electronica si Calculatoare
// Proiect     : Laborator HDL
// Modul       : fsm_3
// Autor       : Dan NICULA (DN)
// Data        : Oct. 1, 2019
//------------------------------------------------------------------------------
// Descriere   : FSM modelata one-hot
//------------------------------------------------------------------------------
// Modificari  :
// Oct. 1, 2019 (DN): Initial 
//------------------------------------------------------------------------------

module fsm_3 (
input     clk       , // semnal de ceas, 
input     rst_n     , // semnal de reset asincron activ 0
input     start     , // start operatie
input     zero      , // indicator de stare
output    do_iter   , // comanda pentru o iteratie
output    ready       // terminare operatie
);

// coduri stari (unice)
reg       s_idle    ;
reg       s_initial ;
reg       s_iterate ;
reg       s_final   ;

// modeleaza cate un bit pentru fiecare stare
always @(posedge clk or negedge rst_n)
if (~rst_n) s_idle    <=  1'b1; else                // stare initiala a FSM
            s_idle    <=  s_final               |   // arce care intra in stare 
                          (s_idle & (~start))   ;
always @(posedge clk or negedge rst_n)  
if (~rst_n) s_initial <=  1'b0; else    
            s_initial <=  s_idle & start        ;
always @(posedge clk or negedge rst_n)
if (~rst_n) s_iterate <=  1'b0; else  
            s_iterate <=  (s_initial & (~zero)) | 
                          (s_iterate & (~zero)) ;            
always @(posedge clk or negedge rst_n)
if (~rst_n) s_final   <=  1'b0; else   
            s_final   <=  (s_initial & zero)    | 
                          (s_iterate & zero)    ;

// modeleaza circuitul combinational de iesire
assign ready    = s_final  ;
assign do_iter  = s_iterate;

initial begin
  @(negedge rst_n);
  @(posedge rst_n);
  forever begin
    @(posedge clk)
    if ((s_idle + s_initial + s_iterate + s_final) != 'd1) begin
      $display ("%M %0t EROARE stare one-hot (stare=%b%b%b%b)", $time, 
        s_idle, s_initial, s_iterate, s_final);
      $stop;
    end
  end
end

endmodule // fsm_3
