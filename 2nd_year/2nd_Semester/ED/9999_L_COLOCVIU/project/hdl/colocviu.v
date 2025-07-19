// Proiect    : Electronica Digitala - colocviu
// Autor      : BAJCSI Elias-Robert
// An         : 2025
//---------------------------------------------------------------
// Descriere  : Model Verilog RTL pentru biletul 4
//---------------------------------------------------------------

module colocviu (
                 input  clk,
                 input  rst_n,
                 input  dataIn,
                 output dataOut
                 );

   reg Q1, Q2, Q3, Q4; // Registers for all 4 flip-flops
   wire D2;            // wires for the 1st gate

   /*
    * Q1 - D-type flip-flop
    * Delays dataIn by one clock tick
    */
   always@ (posedge clk or negedge rst_n) begin
      if(~rst_n)
        Q1 <= 1'b0;
      else
        Q1 <= dataIn;
   end

   // D2 - AND logic gate, with negated output of the 1st flip-flop
   assign D2 = (~Q1) & dataIn;

   /*
    * Add three D flip-flops (Q2, Q3 and Q4) in order to extend the HIGH signal
    * from D2 by 3 ticks later at the `dataOut' OR gate
    */
   always@ (posedge clk or negedge rst_n) begin // Q2
      if(~rst_n)
        Q2 <= 1'b0;
      else
        Q2 <= D2;
   end
   always@ (posedge clk or negedge rst_n) begin // Q3
      if(~rst_n)
        Q3 <= 1'b0;
      else
        Q3 <= Q2;
   end
   always@ (posedge clk or negedge rst_n) begin // Q4
      if(~rst_n)
        Q4 <= 1'b0;
      else
        Q4 <= Q3;
   end

   // Output: dataOut
   assign dataOut = Q2 | Q3 | Q4;
endmodule
