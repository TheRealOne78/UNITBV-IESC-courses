//---------------------------------------------------------------
// Proiect    : Electronica Digitala
//              Carte de invatatura
// Autor      : Dan NICULA
// An         : 2025
//---------------------------------------------------------------
// Descriere  : Model TFF
//---------------------------------------------------------------

module jkff (
            input      clk ,   // semnal de ceas, activ pe frontul crescator
            input      rst_n , // semnal de reset asincron activ in 0
            input      j ,     // intrare J
            input      k ,     // intrare K
            output reg q       // iesire Q
            );

   always @(posedge clk or negedge rst_n) begin
     if (~rst_n)
       q <= 1'b0;
     else if (~j & k)
       q <= 1'b0;
     else if(j & ~k)
       q <= 1'b1;
     else if(j & k)
       q <= ~q;
   end

endmodule; // jkff
