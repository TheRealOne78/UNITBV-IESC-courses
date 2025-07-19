//---------------------------------------------------------------
// Proiect    : Electronica Digitala
//              Carte de invatatura
// Autor      : Dan NICULA 
// An         : 2025
//---------------------------------------------------------------
// Descriere  : Model de memorie 1RW parametrizabil
//---------------------------------------------------------------

///// 10 ////////////////////////////////////////////////////////
module mem_1rw  #(
parameter  ADDR_WIDTH = 8   ,
parameter  MEM_DEPTH  = 256 ,  // MEM_DEPTH <= 2^ADDR_WIDTH
parameter  WORD_BYTES =  8     // latimea datelor (biti) = 
                               //   8 * WORD_BYTES
)(
input                             clk       , // ceas
input                             ce        , // chip enable 
input                             we        , // write enable 
input       [ADDR_WIDTH   -1 : 0] addr      , // adresa
input       [8*WORD_BYTES -1 : 0] wr_data   , // date scrise
input       [WORD_BYTES   -1 : 0] be        , // byte enable
output reg  [8*WORD_BYTES -1 : 0] rd_data     // date citite
);
reg         [8*WORD_BYTES -1 : 0] mem[MEM_DEPTH -1 : 0];

// scriere memorie
always @(posedge clk)
if (ce & we)
  mem[addr] <=  (mem[addr] & (~{8{be}})) | // pastreaza datele
                (wr_data   &   {8{be}} );  // modifica datele 

// citire memorie
always @(posedge clk)
if (ce & (~we)) rd_data <= mem[addr]; else  // date citite
                rd_data <= 'bx;             // date necunoscute

// verificare parametrii ////////////////////////////////////////
integer    idx ;                // index
initial begin
  // adancime memorie mai mare decat spatiul de adresare maxim
  if (MEM_DEPTH > (1 << ADDR_WIDTH)) begin
    $display("%M EROARE: MEM_DEPTH=%0d, maximum=%0d", 
      MEM_DEPTH, (1 << ADDR_WIDTH));
    $stop;
  end
  // date de latime 0
  if (WORD_BYTES == 'd0) begin
    $display("%M EROARE: WORD_BYTES>0");
    $stop;
  end

/*  
  // initializare din fisier extern cu date in hexa
  $readmemh("mem.hex", mem);    // initializare memorie
  
  // initializare totala cu o valoare constanta
  for (idx=0; idx < MEM_DEPTH; idx=idx+1)
    mem[idx] = 'hAB;            // valoare constanta
*/

end

// asertii //////////////////////////////////////////////////////
always @(posedge clk) begin
  // adresare in afara spatiului de adresare
  if (ce & (addr >= MEM_DEPTH)) begin
    $display("%M %0t EROARE: Memorie accesata (%s) in afara spatiului \
      (MEM_DEPTH =%0d, addr=%0d).",
      $time, we ? "WRITE" : "READ", MEM_DEPTH, addr);
    $stop;
  end
//  // adresa necunoscuta
//  if (ce & $isunknown(addr)) begin
//    $display("%M %0t EROARE: Adresa necunoscuta (addr=%b).", $time, addr);
//    $stop;
//  end
//  // date necunoscute scrise
//  if (ce & we & $isunknown(wr_data & {8{be}})) begin
//    $display("%M %0t EROARE: Date necunoscute scrise \
//      (addr=%0d, wr_data=%b, be=%b).", $time, addr, wr_data, be);
//    $stop;  
//  end
//  // date necunoscute citite
//  if (ce & (~we) & $isunknown(mem[addr])) begin
//    $display("%M %0t EROARE: Date necunoscute citite \
//      (addr=%0d, rd_data=%b). ", $time, addr, mem[addr]);
//    $stop;   
//  end
end       
      
endmodule   // mem_1rw
