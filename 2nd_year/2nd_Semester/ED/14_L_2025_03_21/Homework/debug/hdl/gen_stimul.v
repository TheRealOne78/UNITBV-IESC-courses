module gen_stimul (
                   output reg [7:0] data_a,
                   output reg [7:0] data_b
                   );

   reg [7:0] i, j;  // Counters for both data_a and data_b

   initial begin
      data_a = 8'b00000000;
      data_b = 8'b00000000;

      repeat (256) begin
         i = 0;
         repeat (256) begin
            j = 0;
            repeat (256) begin
               data_a = i;
               data_b = j;
               j = j + 1;
               #20;
            end
            i = i + 1;
         end
      end

      $display("End simulation");
      $stop;
   end

endmodule
