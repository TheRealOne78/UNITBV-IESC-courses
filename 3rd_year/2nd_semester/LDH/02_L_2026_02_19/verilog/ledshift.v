module ledshift #(
   parameter WIDTH = 8
)   (
   input              clk_i,
   input              rst_ni,
   output reg [WIDTH-1:0] led_o
);

   wire enable;
   
counter #( 
.WIDTH(6), .CAP(50) )
 asd (
      .clk_i (clk_i),
      .rst_ni(rst_ni),
      .nr_o  (),
      .enb   (enable)
   );
   
   reg nr;   // 0 <<-- | 1 -->>
   
   always @(posedge clk_i or negedge rst_ni) begin
      if(~rst_ni) begin
	     led_o   <= 8'h01;
         nr <= 1'b0;
      end 
	  else if(!enable) begin
	     if (nr == 1'b0)
             led_o <= led_o << 1;
         else
             led_o <= led_o >> 1;
	    
		if (led_o == 8'h40 && nr == 0)
             nr <= 1; 
        else if (led_o == 8'h02 && nr == 1)
             nr <= 0;
	    end
    end
endmodule
