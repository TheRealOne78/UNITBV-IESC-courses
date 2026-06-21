//------------------------------------------------------------------------------
// Universitatea Transilvania din Brasov
// Departamentul de Electronica si Calculatoare
// Proiect     : Laborator HDL
// Modul       : vot3_stim_test
// Autor       : Dan NICULA (DN)
// Data        : Feb. 1, 2025
//------------------------------------------------------------------------------
// Descriere   : Mediu de testare cu generator de stimuli pentru vot3
//------------------------------------------------------------------------------

module vot3_stim_test ;
wire    v1  ;
wire    v2  ;
wire    v3  ;
wire    vot ; // rezultat vot

vot3 DUT(
.v1   (v1   ) ,
.v2   (v2   ) ,
.v3   (v3   ) ,
.vot  (vot  )  
);

gen_stimul #(
.NO_OUT (3)
) gen_stimul (
.stimul ({v3, v2, v1})
);

endmodule   // vot3_stim_test