//---------------------------------------------------------------
// Proiect    : Electronica Digitala
//              Carte de invatatura
// Autor      : Dan NICULA 
// An         : 2025
//---------------------------------------------------------------
// Descriere  : Modul de monitorizare pentru 
//              interfata cu protocol request-acknowledgement
//---------------------------------------------------------------

module checker_rq_ack #(
parameter REQ_DW = 'd4, // Numar de biti ai datelor 
                        // transferate simultan cu cererea, 
                        // initiator la receptor,
                        // cand req=1 (maximum 32)
parameter ACK_DW = 'd4  // Numar de biti ai datelor 
                        // transferate simultan cu confirmarea, 
                        // receptor la initiator
                        // cand ack=1 (maximum 32)
)(
input               clk     , // semnal de ceas, 
                              // activ pe frontul crescator
input               rst_n   , // semnal de reset asincron activ 0
input               req     , // cerere activa in 1
input               ack     , // confirmare, puls activ 1
input [REQ_DW -1:0] req_data, // date transferate de la 
                              // initiator spre receptor
input [ACK_DW -1:0] ack_data  // date transferate de la 
                              // receptor spre initiator
);
 
reg                 req_d        ;
reg [REQ_DW - 1: 0] req_data_d   ;
reg                 ack_d        ;
reg                 after_reset  ;

initial begin
  after_reset <= 1'b0;
  @(negedge rst_n);
  @(posedge rst_n);
  after_reset <= 1'b1;
  @(posedge clk);
end

always @(posedge clk) begin
  req_d       <= req      ;
  req_data_d  <= req_data ;
  ack_d       <= ack      ;
end

always @(posedge clk) 
if (after_reset)
  if (req) begin     // req = 1
    if ($isunknown(req_data)) begin // datele nu trebuie sa fie x
      $display("%M %0t ERR: Date necunoscute (req_data=%b).", 
        $time, req_data);
    end
    if (req_d & (~ack_d))   // cerere neconfirmata: 
                            //   datele trebuie sa fie stabile
      if (req_data !== req_data_d) begin
        $display("%M %0t ERR: Date instabile (%h != %h).", $time, 
          req_data_d, req_data);
      end
    if (ack) begin      // confirmare
      if (~req_d) begin // confirmare simultana cu cererea
        $display("%M %0t ERR: confirmare simultana cu cererea.", 
          $time, ack_data);
      end
      if ($isunknown(ack_data)) begin 
                              // datele nu trebuie sa fie x
        $display("%M %0t ERR: date necunoscute (ack_data=%b).", 
          $time, ack_data);
      end
    end  
    // if (req_d & ack_d) begin // back-to-back
    //   $display("%0t INFO: back-to-back.", $time);
    // end
  end
  else begin   // req = 0
    if ((req_d & (~ack_d))) begin  
                              // cerere retrasa fara confirmare
      $display("%M %0t ERR: cerere retrasa fara confirmare.", 
        $time);
    end
    if (ack) begin  // confirmare fara cerere
      $display("%M %0t ERR: confirmare fara cerere.", $time);
    end
  end

endmodule // checker_rq_ack