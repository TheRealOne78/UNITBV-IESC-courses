module test;
   wire [7:0] data_a;   // operand A
   wire [7:0] data_b;   // operand B
   wire       a_less_b; // A < B
   wire       a_eq_b;   // A = B
   wire       a_gt_b;   // A > B

   gen_stimul u_gen_stimul (
                            .data_a(data_a),
                            .data_b(data_b)
                            );

   comp_8b_int u_comp_8b_int (
                              .data_a(data_a),
                              .data_b(data_b),
                              .a_less_b(a_less_b),
                              .a_eq_b(a_eq_b),
                              .a_gt_b(a_gt_b)
                              );

endmodule // test
