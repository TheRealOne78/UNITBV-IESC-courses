//------------------------------------------------------------------------------
// Universitatea Transilvania din Brasov
// Departamentul de Electronica si Calculatoare
// Proiect     : Laborator HDL
// Modul       : counter_preset_tb
// Autor       : Dan NICULA (DN)
// Data        : Feb. 1, 2025
//------------------------------------------------------------------------------
// Descriere   : Generator de stimuli pentru numarator sincron presetabil, 
//               counter_preset
//------------------------------------------------------------------------------

module counter_preset_tb #(
parameter WIDTH           = 'd8           // numar de biti ai numaratorului
) (
input                     clk           , // semnal de ceas
input                     rst_n         , // semnal de reset asincron, activ low
output reg                count_up      , // comanda de numarare, activa high
output reg                load          , // comanda presetare, activa high, 
                                          // prioritara fata de numarare
output reg [WIDTH  -1:0]  data_preset     // data presetare
);

initial begin
  count_up    <= 1'bx;
  load        <= 1'bx;
  data_preset <= {WIDTH{1'bx}};
  
  // initializeaza numaratorul la 0, la activarea reset asincron
  @(negedge rst_n);
  count_up    <= 1'b0;
  load        <= 1'b0;
  data_preset <= {WIDTH{1'bx}};
  @(posedge rst_n);

  // numarator initializat, asteapta
  repeat (5) @(posedge clk);
  
  // numara de la 0 la 15 si reia numararea de la 0
  count_up    <= 1'b1;
  repeat (20) @(posedge clk); 
  
  // dezactiveaza numararea si asteapta
  count_up    <= 1'b0;
  repeat (5) @(posedge clk);

  // preseteaza starea in 13
  load        <= 1'b1;
  data_preset <= 'd13;
  @(posedge clk);
  load        <= 1'b0;
  data_preset <= 'bx;
  @(posedge clk);

  // asteapta
  repeat (5) @(posedge clk);

  // reia numararea de la valoarea presetata
  count_up    <= 1'b1;
  repeat (20) @(posedge clk); 

  // dezactiveaza numararea si asteapta
  count_up    <= 1'b0;
  repeat (5) @(posedge clk);

  $display ("%M %0t INFO: Final simulare.", $time);
  $stop;
  
end

endmodule // counter_preset_tb
