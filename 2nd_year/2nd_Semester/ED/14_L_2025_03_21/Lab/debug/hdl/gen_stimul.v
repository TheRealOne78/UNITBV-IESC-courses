//---------------------------------------------------------------
// Proiect    : Electronica Digitala
//              Carte de invatatura
// Autor      : Dan NICULA 
// An         : 2025
//---------------------------------------------------------------
// Descriere  : Generator de stimuli parametrizabil
//---------------------------------------------------------------

module gen_stimul #(
                    parameter NO_OUT = 4
                    )(
                      output reg [NO_OUT-1:0] stimul
                      );

   initial begin
      stimul = 'b0;
      repeat (1 << NO_OUT) begin
         #20;
         stimul = stimul + 1;
      end
      #10;
      $display("End simulation");
      $stop;
   end

endmodule   // gen_stimul
