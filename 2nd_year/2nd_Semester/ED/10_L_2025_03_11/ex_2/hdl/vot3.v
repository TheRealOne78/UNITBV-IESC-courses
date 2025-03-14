//------------------------------------------------------------------------------
// Universitatea Transilvania din Brasov
// Departamentul de Electronica si Calculatoare
// Proiect     : Laborator HDL
// Modul       : vot3
// Autor       : Dan NICULA (DN)
// Data        : Feb. 1, 2025
//------------------------------------------------------------------------------
// Descriere   : Generator de semnale de ceas si de reset asincron (activ low)
//------------------------------------------------------------------------------

module vot3 (
input   v1, // primul votant
input   v2, // al doilea votant
input   v3, // al treilea votant
output  vot // rezultat vot
);

assign vot = (v1 & v2) | (v1 & v3) | (v2 & v3);
// assign vot = (v1 + v2 + v3) > 1;

endmodule   // vot3