module seven_segment(
                     input              seven_seg_pkg::seven_seg_char_t char_i,
                     input logic        enable_i,
                     output logic [7:0] out_o
                     );
   
   import seven_seg_pkg::*;
   
   always_comb begin
      if (!enable_i) begin
         out_o = 8'b00000000;
      end else begin
         case (char_i)
           
           // digits
           CHAR_0: out_o = 8'b00111111;
           CHAR_1: out_o = 8'b00000110;
           CHAR_2: out_o = 8'b01011011;
           CHAR_3: out_o = 8'b01001111;
           CHAR_4: out_o = 8'b01100110;
           CHAR_5: out_o = 8'b01101101;
           CHAR_6: out_o = 8'b01111101;
           CHAR_7: out_o = 8'b00000111;
           CHAR_8: out_o = 8'b01111111;
           CHAR_9: out_o = 8'b01101111;
           
           // letters (approximate for 7-seg)
           CHAR_A: out_o = 8'b01110111;
           CHAR_B: out_o = 8'b01111100;
           CHAR_C: out_o = 8'b00111001;
           CHAR_D: out_o = 8'b01011110;
           CHAR_E: out_o = 8'b01111001;
           CHAR_F: out_o = 8'b01110001;
           
           CHAR_G: out_o = 8'b00111101;
           CHAR_H: out_o = 8'b01110110;
           CHAR_I: out_o = 8'b00000110;
           CHAR_J: out_o = 8'b00011110;
           CHAR_K: out_o = 8'b01110110; // same as H (approx)
           CHAR_L: out_o = 8'b00111000;
           
           CHAR_M: out_o = 8'b00010101; // very approximate
           CHAR_N: out_o = 8'b00110111;
           CHAR_O: out_o = 8'b00111111;
           CHAR_P: out_o = 8'b01110011;
           CHAR_Q: out_o = 8'b01100111;
           CHAR_R: out_o = 8'b00110001;
           
           CHAR_S: out_o = 8'b01101101;
           CHAR_T: out_o = 8'b01111000;
           CHAR_U: out_o = 8'b00111110;
           CHAR_V: out_o = 8'b00111110;
           CHAR_W: out_o = 8'b00101010; // approximate
           CHAR_X: out_o = 8'b01110110; // reuse H
           CHAR_Y: out_o = 8'b01101110;
           CHAR_Z: out_o = 8'b01011011;
           
           CHAR_BLANK: out_o = 8'b00000000;
           
           default: out_o = 8'b00000000;
           
         endcase
      end
   end
   
endmodule : seven_segment
