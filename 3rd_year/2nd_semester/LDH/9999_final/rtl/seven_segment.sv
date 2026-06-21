module seven_segment(
                     input              row_i,
                     input              enable_i,
                     output logic [7:0] out_o
                     );
   
   always_comb begin
      if (enable_i) begin
         if (row_i)
           out_o = 8'b01100011; // upper circle
         else
           out_o = 8'b01011100; // lower circle
      end else
        out_o = 8'b00000000;
   end
   
endmodule : seven_segment
