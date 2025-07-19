//---------------------------------------------------------------
// Proiect    : Electronica Digitala
//              Carte de invatatura
// Autor      : Dan NICULA 
// An         : 2025
//---------------------------------------------------------------
// Descriere  : Test pentru lucrul memoriilor cu fisiere
//---------------------------------------------------------------

///// 10 ////////////////////////////////////////////////////////
module mem_crop_test;
parameter CROP_ROW  = 'd26    ; // coordonate colt 
parameter CROP_COL  = 'd122   ; //  in imagine sursa

wire      clk                 ;
wire      rst_n               ;
        
integer   file_id             ; // handler fisier
    
integer   idx                 ;
integer   row                 ;
integer   col                 ;
      
integer   status              ; // stare operatie cu fisiere
  
wire             ce_src        ;
wire   [14  : 0] addr_src      ;
wire             ce_dst        ;
wire   [9   : 0] addr_dst      ;
wire  [7   : 0] data_intern   ;

ck_rst_tb #(
.CK_SEMIPERIOD ('d10)
) i_ck_rst_tb (
.clk    (clk   ),
.rst_n  (rst_n )
);

initial begin
  // initializeaza memoria sursa
  file_id   = $fopen("input_data/img_256x128.raw", "rb");
  if (file_id == 0) begin
    $display("Nu se poate deschide fisierul img_256x128.raw");
    $stop;
  end
  for (idx=0; idx<(256*128); idx=idx+1)
    status = $fread(i_mem_src.mem[idx], file_id); 
  $fclose(file_id);
 
  repeat(32*32+10) @(posedge clk);  // asteapta transferul
  
  // scrie memoria destinatie in fisier binar
  file_id   = $fopen("output_data/img_32x32.raw", "wb");
  if (file_id == 0) begin
    $display("Nu se poate deschide fisier img_32x32.raw");
    $stop;
  end
  for (idx=0; idx<(32*32); idx=idx+1)
    $fwrite(file_id, "%c", i_mem_dst.mem[idx]);
  $fclose(file_id);

  // scrie memoria destinatie in fisier text, hexa
  file_id   = $fopen("output_data/img_32x32.hex", "w");
  if (file_id == 0) begin
    $display("Nu se poate deschide fisier img_32x32.hex");
    $stop;
  end
  for (idx=0; idx<(32*32); idx=idx+1)
    $fwrite(file_id,"%h \n", i_mem_dst.mem[idx]);
  $fclose(file_id);

  // scrie memoria destinatie in fisier text, binar
  file_id   = $fopen("output_data/img_32x32.bin", "w");
  if (file_id == 0) begin
    $display("Nu se poate deschide fisier img_32x32.bin");
    $stop;
  end
  for (idx=0; idx<(32*32); idx=idx+1)
    $fwrite(file_id,"%b \n", i_mem_dst.mem[idx]);
  $fclose(file_id);
  
  $display ("%M %0t INFO: Final simulare.", $time);
  $stop;
end

// memorie sursa, accesibila doar in citire
mem_1rw  #(
.ADDR_WIDTH (15           ),
.MEM_DEPTH  (1 << 15      ),
.WORD_BYTES (1            )   // latimea datelor 8 biti
) i_mem_src(                  // 2^15 x 8 (256x128 bytes)
.clk        (clk          ),
.ce         (ce_src       ), 
.we         (1'b0         ), 
.addr       (addr_src     ), 
.wr_data    (8'bx         ), 
.be         (1'bx         ), 
.rd_data    (data_intern  )  
);

// memorie destinatie, accesibila doar in scriere
mem_1rw  #(
.ADDR_WIDTH (10           ),
.MEM_DEPTH  (1 << 10      ),
.WORD_BYTES (1            )   // latimea datelor  8 biti
) i_mem_dst(                  // 2^10 x 8 (32x32 bytes)
.clk        (clk          ),
.ce         (ce_dst       ), 
.we         (1'b1         ), 
.addr       (addr_dst     ), 
.wr_data    (data_intern  ), 
.be         (1'b1         ), 
.rd_data    (             )  
);

transfer_data #(
.CROP_ROW (CROP_ROW),
.CROP_COL (CROP_COL)
) i_transfer_data (
.clk      (clk     ),
.rst_n    (rst_n   ),
.ce_src   (ce_src  ),
.addr_src (addr_src),
.ce_dst   (ce_dst  ),
.addr_dst (addr_dst)
);

endmodule // mem_crop_test
