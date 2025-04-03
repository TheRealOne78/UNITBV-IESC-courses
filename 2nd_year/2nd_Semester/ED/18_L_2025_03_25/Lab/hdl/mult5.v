module mult5 (
              input [2:0] a,
              output [5:0] mult
              );
   assign mult = a << 2 + a;
endmodule
