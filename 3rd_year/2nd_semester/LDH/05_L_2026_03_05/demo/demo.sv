module demo (
	         input [1:0]  a_i,
	         input [1:0]  b_i,
	         output [2:0] s_o
             );
   
   assign s_o = a_i + b_i;
   
endmodule
