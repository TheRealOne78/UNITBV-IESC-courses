//------------------------------------------------------------------------------
// Universitatea Transilvania din Brasov
// Departamentul de Electronica si Calculatoare
// Proiect     : Laborator HDL
// Modul       : vot3_test
// Autor       : Dan NICULA (DN)
// Data        : Feb. 1, 2025
//------------------------------------------------------------------------------
// Descriere   : Mediu de testare pentru vot3
//------------------------------------------------------------------------------

module vot3_test ;
reg [2:0] comb_in ;
wire      vot     ; // rezultat vot

vot3 DUT(
.v1   (comb_in[0]   ) ,
.v2   (comb_in[1]   ) ,
.v3   (comb_in[2]   ) ,
.vot  (vot          )  
);

initial begin
  comb_in = 3'b000;
  repeat (8) begin
    comb_in = comb_in + 1;
    #10;
  end
  #10;
  $display("End simulation");
  $stop;
end

endmodule   // vot3_test