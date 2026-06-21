//---------------------------------------------------------------
// Proiect    : Electronica Digitala
//              Carte de invatatura
// Autor      : Dan NICULA
// An         : 2025
//---------------------------------------------------------------
// Descriere  : Multiplicator secvential pe baza
//              algoritmului de adunare repetata
//---------------------------------------------------------------

module seq_mul #(
                 parameter DW = 'd4 // Data width, numar de biti ai operanzilor
                 )(
                   input                  clk ,      // semnal de ceas,
                   input                  rst_n ,    // reset asincron activ 0
                   input                  req ,      // cerere
                   output reg             ack ,      // confirmare, puls activ 1
                   input [DW+DW -1:0]     req_data , // {op1, op2}
                   output reg [2*DW -1:0] ack_data   // rezultat
                   );

   reg  req_d,
        ack_d;

   wire start,
        start_op2_1,
        start_op_0,
        stop_op_n0,
        op2_eq_1,
        op2_eq_0,
        op1_eq_0;


   assign start = req & (~req_d | ack_d);

   assign stop_op2_1 = op2_eq_1 && start;
   assign stop_op_0 = start & (op2_eq_0 | op1_eq_0);
   assign stop_op_n0 = (~start) /* & compare 1 & CD */;

   always @(posedge clk) begin
      if(req)
         req_d <= 1b'1;
      else
         req_d <= req_d;
   end

   always @(posedge clk) begin
      if(ack) {
         ack_d <= 1b'1;
      }
      else {
         ack_d <= req_d;
      }
   end
endmodule // seq_mul
