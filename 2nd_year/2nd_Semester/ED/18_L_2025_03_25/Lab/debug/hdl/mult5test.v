module test;

   parameter NO_OUT = 6;

   wire [NO_OUT-1 : 0] stimul;
   wire                data_out;

   gen_stimul #(
      .NO_OUT(NO_OUT)
                )
   u_gen_stimul (.stimul(stimul));

   mux4x1 u_mux_4_1(
                    .sel (stimul[5:4]),
                    .data_in(stimul[3:0]),
                    .data_out(data_out)
                    );

endmodule // test
