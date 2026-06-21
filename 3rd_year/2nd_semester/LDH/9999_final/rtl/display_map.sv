module display_map #(
                     parameter int DISPLAYS = 6
                     )
   (
    input logic                        row_i,
    input logic [$clog2(DISPLAYS)-1:0] col_i,
    output logic [DISPLAYS-1:0][7:0]   out_o
    );

   logic [DISPLAYS-1:0] enable;

   always_comb begin
      enable = '0;
      enable[col_i] = 1'b1;
   end

   genvar i;
   generate
      for (i = 0; i < DISPLAYS; i++) begin : gen_display
         seven_segment u_seven_segment (
                                        .row_i    (row_i),
                                        .enable_i (enable[i]),
                                        .out_o    (out_o[i])
                                        );
      end : gen_display
   endgenerate

endmodule : display_map
