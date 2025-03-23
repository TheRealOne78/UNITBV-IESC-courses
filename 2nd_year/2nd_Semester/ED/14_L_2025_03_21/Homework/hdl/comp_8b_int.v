// operanzii sunt codificati in complement fata de 2
// in domeniul -7 ... 7
module comp_8b_int (
                    input [8 -1:0] data_a ,  // operand A
                    input [8 -1:0] data_b ,  // operand B
                    output         a_less_b, // A < B
                    output         a_eq_b ,  // A = B
                    output         a_gt_b    // A > B
                    );

   assign a_less_b = (data_a[7] & ~data_b[7]) |
                     (~(data_a[7] ^ data_b[7]) & (data_a < data_b));

   assign a_gt_b   = (~data_a[7] & data_b[7]) |
                     (~(data_a[7] ^ data_b[7]) & (data_a > data_b));

   assign a_eq_b   = (data_a == data_b);

endmodule //  comp_8b_int
