module exercitiu (
                  input      clk,
                  input      rst_n,
                  input      data_in,
                  output reg data_out
                  );

   reg Q1;
   reg Q2;
   reg Q3;
   wire D2;
   wire D4;

   // Q1
   always@ (posedge clk or negedge rst_n) begin
      if(~rst_n)
        Q1 <= 1'b0;
      else
        Q1 <= data_in;
   end

   assign D2 = Q1 & data_in;

   // Q2
   always@ (posedge clk or negedge rst_n) begin
      if(~rst_n)
        Q2 <= 1'b0;
      else
        Q2 <= D2;
   end

   // Q3
   always@ (posedge clk or negedge rst_n) begin
      if(~rst_n)
        Q3 <= 1'b0;
      else if (data_in)
        Q3 <= ~Q3;
   end

   assign D4 = Q3 | Q2;

   // Output: dataOut
   always@ (posedge clk or negedge rst_n) begin
      if(~rst_n)
        data_out <= 1'b0;
      else
        data_out <= D4;
   end

endmodule
