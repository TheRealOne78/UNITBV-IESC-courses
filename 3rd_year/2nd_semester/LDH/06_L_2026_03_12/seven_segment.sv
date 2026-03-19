module seven_segment(
                     input              row_i,
                     input              enable_i,
                     output logic [6:0] out_o
                     );
   
   always @(*) begin
      if (enable_i) begin
         if (row_i)
           out_o = 7'b1100011; // upper circle
         else
           out_o = 7'b0011101; // lower circle
      end else
         out_o = 7'b0000000;
   end
   
endmodule
