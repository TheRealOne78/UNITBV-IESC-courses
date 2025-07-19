module front (
              input  clk ,   // semnal de ceas, activ pe frontul crescator
              input  rst_n , // semnal de reset asincron activ in 0
              input  in ,    // intrare
              output pos_edge,
              output neg_edge,
              output any_edge
              );

   reg delay;

   always @(posedge clk or negedge rst_n) begin
      if (~rst_n)
        delay <= 1'b0;
      else
        delay <= in;
   end

   assign pos_edge = (in & (!delay));
   assign neg_edge = ((!in) & delay);
   assign any_edge = (in ^ delay);

endmodule; // front
