//------------------------------------------------------------------------------
// Universitatea Transilvania din Brasov
// Departamentul de Electronica si Calculatoare
// Proiect     : Laborator HDL
// Modul       : gen_stimul
// Autor       : Dan NICULA (DN)
// Data        : Feb. 1, 2025
//------------------------------------------------------------------------------
// Descriere   : Generator de stimuli parametrizabil
//------------------------------------------------------------------------------

module gen_stimul #(
parameter NO_OUT = 4
)(
output reg [NO_OUT-1:0] stimul
);

initial begin
  stimul = 'b0;
  repeat (1 << NO_OUT) begin
    #10;
    stimul = stimul + 1;
  end
  #100;
  $display("End simulation");
  $stop;
end

endmodule   // gen_stimul