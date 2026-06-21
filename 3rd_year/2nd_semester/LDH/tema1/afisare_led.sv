module afisare_led #(
                     parameter int DISPLAYS = 6
                     )
   (
    input logic                        row_i,
    input logic [$clog2(DISPLAYS)-1:0] col_i,
    output logic [DISPLAYS-1:0][6:0]   out_o
    );
   
   genvar i;
   generate
      for (i = 0; i < DISPLAYS; i++) begin : gen_disp
         seven_segment disp (
                             .row_i    (row_i),
                             .enable_i (col_i == i),
                             .out_o    (out_o[i])
                             );
      end
   endgenerate
   
endmodule : afisare_led
