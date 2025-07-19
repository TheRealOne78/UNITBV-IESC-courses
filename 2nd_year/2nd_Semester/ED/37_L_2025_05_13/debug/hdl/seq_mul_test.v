//---------------------------------------------------------------
// Proiect    : Electronica Digitala
//              Carte de invatatura
// Autor      : Dan NICULA 
// An         : 2025
//---------------------------------------------------------------
// Descriere  : Mediu de testare pentru multiplicator secvential 
//               pe baza algoritmului de adunare repetata
//               Include verificator protocol 
//               request-acknowledgement
//---------------------------------------------------------------

module seq_mul_test #(
parameter CK_SEMIPERIOD = 10,
parameter DW    = 'd4 // Numar de biti ai operanzilor 
);
wire              clk       ;
wire              rst_n     ;
                            
reg               req       ; // cerere
wire              ack       ; // confirmare, puls activ 1
reg  [DW+DW -1:0] req_data  ; // {op1, op2}
wire [2*DW  -1:0] ack_data  ; // rezultat
 
ck_rst_tb #(
.CK_SEMIPERIOD (CK_SEMIPERIOD)
) i_ck_rst_tb (
.clk        (clk      ),
.rst_n      (rst_n    )
);  
  
checker_rq_ack #( 
.REQ_DW     (DW+DW    ),
.ACK_DW     (2*DW     )
) i_checker_rq_ack (  
.clk        (clk      ),
.rst_n      (rst_n    ),
.req        (req      ),
.ack        (ack      ),
.req_data   (req_data ),
.ack_data   (ack_data ) 
);  
  
seq_mul #(  
.DW         (DW       )
) i_seq_mul ( 
.clk        (clk      ),
.rst_n      (rst_n    ),
.req        (req      ), // cerere
.ack        (ack      ), // confirmare, puls activ 1
.req_data   (req_data ), // {op1, op2}
.ack_data   (ack_data )  // rezultat
);

task send_req;
input [DW -1:0] op1     ; // date transmise
input [DW -1:0] op2     ; // date transmise
input [32 -1:0] delay_p ; // pauza intre cereri succesive
begin
  // activeaza cererea
  req       <= 1'b1;
  req_data  <= {op1, op2};
  @(posedge clk);
  // asteapta confirmarea
  while (~ack) @(posedge clk);
  // verifica datele
  if (ack_data !== (op1*op2)) begin
    $display ("%M %0t EROARE %0d * %0d = %0d, asteptat %0d.", 
      $time, op1, op2, ack_data, (op1*op2));
    $stop;
  end
  else begin
    $display ("%M %0t CORECT %0d * %0d = %0d.", $time, 
      op1, op2, ack_data);
  end
  // asteapta pauza
  if (delay_p != 'd0) begin
    req       <= 1'b0;
    req_data  <= 'bx;
    repeat (delay_p) @(posedge clk);  
  end
end
endtask

initial begin
  // asteptare reset asincron
  req       <= 'bx;    
  req_data  <= 'bx;    
  @(negedge rst_n);
  req  <= 'b0;    
  @(posedge rst_n);
  @(posedge clk);
  
  // send_req(op1, op2, pauza);
  
  $display ("%M %0t INFO: Cereri pentru depanare.", $time);
  send_req(2, 3, 1);
  send_req(0, 0, 1);
  send_req(4, 5, 1);
  send_req(2, 0, 1);
  send_req(3, 1, 1);
  send_req(0, 4, 1);
  send_req(4, 3, 0);
  send_req(3, 4, 10);
  $stop;
  send_req(8, 1, 10);
  send_req(1, 9, 10);
  send_req(2, 3, 1);
  send_req(3, 2, 1);
  send_req(5, 0, 1);
  send_req(4, 2, 1);
  send_req(0, 6, 1);
  send_req(9, 3, 1);
  send_req(0, 0, 1);
  send_req(8, 4, 1);
  send_req(9, 1, 1);
  send_req(7, 2, 1);
  send_req(1, 4, 1);
  send_req(3, 3, 1);
  send_req(1, 1, 1);
 
  $display ("%M %0t INFO: Cereri back-to-back.", $time);
  send_req(5, 2, 0);
  send_req(7, 3, 0);
  send_req(9, 0, 0);
  send_req(9, 1, 0);
  send_req(9, 2, 0);
  send_req(9, 3, 1);
 
  $display ("%M %0t INFO: Testare aleatorie.", $time);
  repeat(1000)
  send_req($random, $random, $urandom_range(5,10)); 
  @(posedge clk);
  
  $display ("%M %0t INFO: Terminare simulare %0d ciclii.", 
    $time, $time/CK_SEMIPERIOD/2);
  
  repeat (5) @(posedge clk);
  $stop;
end

endmodule // seq_mul_test
