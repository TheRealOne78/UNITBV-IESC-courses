//------------------------------------------------------------------------------
// Universitatea Transilvania din Brasov
// Departamentul de Electronica si Calculatoare
// Proiect     : Laborator HDL
// Modul       : fsm_test
// Autor       : Dan NICULA (DN)
// Data        : Oct. 1, 2019
//------------------------------------------------------------------------------
// Descriere   : Test pentru FSM modelat în mai multe moduri
//------------------------------------------------------------------------------
// Modificari  :
// Oct. 1, 2019 (DN): Initial 
//------------------------------------------------------------------------------

module fsm_test;
wire      clk       ;
wire      rst_n     ;
reg       in     ;

wire      out ;

ck_rst_tb #(
.CK_SEMIPERIOD ('d10)
) i_ck_rst_tb (
.clk    (clk   ),
.rst_n  (rst_n )
);

initial begin
  in <= 1'bx;
  in  <= 1'bx;
  @(negedge rst_n);
  in <= 1'b0;
  in  <= 1'b0;
  // stare: idle
  @(posedge rst_n);
  repeat (5) @(posedge clk);
  
  // stare: idle -> idle
  in <= 1'b0;
  in  <= 1'b1;
  @(posedge clk);
  in  <= 1'b0;
  @(posedge clk);
  in  <= 1'bx;
  @(posedge clk);

  // stare: idle -> initial
  in <= 1'b1;
  in  <= 1'bx;
  @(posedge clk);

  // stare: initial -> iterate
  in <= 1'bx;
  in  <= 1'b0;
  @(posedge clk);
  
  // stare: iterate -> iterate
  repeat(5) @(posedge clk);
  
  // stare: iterate -> final
  in  <= 1'b1;
  @(posedge clk);
  
  // stare: final -> idle
  in  <= 1'bx;
  @(posedge clk);

  // stare: idle -> idle
  in <= 1'b0;
  repeat(10) @(posedge clk);
  
  $display ("%M %0t INFO: Final simulare.", $time);
  $stop;
end

//fsm_1 i_fsm_1 (
//.clk       (clk       ),
//.rst_n     (rst_n     ),
//.in     (start     ),
//.in      (zero      ),
//.do_iter   (do_iter_1 ),
//.ready     (ready_1   )
//);
//
//
//fsm_1 i_fsm_2 (
//.clk       (clk       ),
//.rst_n     (rst_n     ),
//.in     (start     ),
//.in      (zero      ),
//.do_iter   (do_iter_2 ),
//.ready     (ready_2   )
//);
//
//fsm_3 i_fsm_3 (
//.clk       (clk       ),
//.rst_n     (rst_n     ),
//.in     (start     ),
//.in      (zero      ),
//.do_iter   (do_iter_3 ),
//.ready     (ready_3   )
//);

graph i_graph (.clk       (clk       ),
               .rst_n     (rst_n     ),
               .in      (in      ),
               .out (out)
               );

endmodule // fsm_test
