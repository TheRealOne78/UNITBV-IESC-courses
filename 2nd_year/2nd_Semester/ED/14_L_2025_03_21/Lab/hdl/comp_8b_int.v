//---------------------------------------------------------------
// Proiect    : Electronica Digitala
//              Carte de invatatura
// Autor      : Dan NICULA 
// An         : 2025
//---------------------------------------------------------------
// Descriere  : Comparator de 8 biti
//              operanzii sunt codificati in complement fata de 2
//              in domeniul -7 ... 7
//---------------------------------------------------------------

// operanzii sunt codificati in complement fata de 2
// in domeniul -127 ... 127
// Nu se vor utiliza declaratii de date "signed".
module comp_8b_int (
                    input [8 -1:0] data_a ,  // operand A
                    input [8 -1:0] data_b ,  // operand B
                    output         a_less_b, // A < B
                    output         a_eq_b ,  // A = B
                    output         a_gt_b    // A > B
                    );



endmodule //  comp_8b_int
