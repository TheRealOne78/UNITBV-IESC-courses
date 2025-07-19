//---------------------------------------------------------------
// Proiect    : Electronica Digitala
//              Carte de invatatura
// Autor      : Dan NICULA 
// An         : 2025
//---------------------------------------------------------------
// Descriere  : Test-bench pentru transfer de date
//---------------------------------------------------------------

///// 10 ////////////////////////////////////////////////////////
module transfer_data #(
parameter CROP_ROW  = 'd26    , // coordonate colt 
parameter CROP_COL  = 'd122     //   in imagine sursa
)(
input                 clk      ,
input                 rst_n    ,
      
output reg            ce_src   ,
output reg [15 -1: 0] addr_src ,
output reg            ce_dst   ,
output reg [10 -1: 0] addr_dst 
);

reg [6  -1:0] row_src, row_dst;  // index for
reg [6  -1:0] col_src, col_dst;

// citire memorie sursa
initial begin
  // initializeaza semnale si asteapta reset
  ce_src        <= 'bx;
  addr_src      <= 'bx;
  @(negedge rst_n);
  ce_src        <= 1'b0;
  @(posedge rst_n);
  @(posedge clk);

  ce_src  <= 1'b1;
  for (row_src=0; row_src<32; row_src=row_src+1)
    for (col_src=0; col_src<32; col_src=col_src+1) begin
      addr_src <= (row_src+CROP_ROW)*256+(col_src+CROP_COL);
      @(posedge clk);
    end
  ce_src  <= 1'b0;
  @(posedge clk);

end

// scriere memorie destinatie
initial begin
  ce_dst        <= 'bx;
  addr_dst      <= 'bx;
  @(negedge rst_n);
  ce_src        <= 1'b0;
  ce_dst        <= 1'b0;
  @(posedge rst_n);

  @(posedge clk);
  ce_dst  <= 1'b1;
  for (row_dst=0; row_dst<32; row_dst=row_dst+1)
    for (col_dst=0; col_dst<32; col_dst=col_dst+1) begin
      addr_dst <= row_dst*32+col_dst; // pozitie normala
      @(posedge clk);
    end
  ce_dst  <= 1'b0;
  @(posedge clk);

end

endmodule // transfer_data
