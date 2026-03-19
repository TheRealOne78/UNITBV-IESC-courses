module counter #(
   parameter WIDTH = 6
   parameter CAP =50
)   (
   input             clk_i,
   input             rst_ni,
   output reg [WIDTH-1:0]nr_o,
   output reg enb
);

always @(posedge clk_i or negedge rst_ni) begin
   if( ~rst_ni) begin
      nr_o <= 0;
	  enb <= 1;
	  end
   else if (nr_o == CAP-1)begin
      enb <= 1'b1;
      nr_o <= 0;
	  end
	  else begin
	     nr_o <= nr_o +1'b1;
		 enb <= 0;
	  end
end
   
endmodule