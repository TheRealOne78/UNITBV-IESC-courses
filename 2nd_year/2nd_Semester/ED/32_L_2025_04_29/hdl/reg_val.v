module reg_val #(
                 parameter WIDTH = 8 // latime, in numar de biti
                 )(
                   input                   clk ,     // ceas, activ pe front crescator
                   input                   rst_n ,   // reset activ in zero

                   input                   load ,    // semnal de incarcare
                   input [WIDTH -1:0]      data_in , // date de intrare
                   output reg [WIDTH -1:0] data_out  // date de iesire
                   );

   always @(posedge clk or negedge rst_n) begin
      if (~rst_n)
         data_out <= {WIDTH{1'b0}};
      else if (load)
         data_out <= data_in;
   end

endmodule // reg_val
