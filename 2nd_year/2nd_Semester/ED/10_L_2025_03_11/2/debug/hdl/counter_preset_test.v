//------------------------------------------------------------------------------
// Universitatea Transilvania din Brasov
// Departamentul de Electronica si Calculatoare
// Proiect     : Laborator HDL
// Modul       : counter_preset_test
// Autor       : Dan NICULA (DN)
// Data        : Feb. 1, 2025
//------------------------------------------------------------------------------
// Descriere   : Test pentru numarator sincron presetabil, counter_preset
//------------------------------------------------------------------------------

module counter_preset_test ;
localparam WIDTH    = 'd4         ; // numar de biti ai numaratorului

wire                clk           ; // semnal de ceas
wire                rst_n         ; // semnal de reset asincron, activ low
wire                count_up      ; // comanda de numarare, activa high
wire                load          ; // comanda presetare, activa high, 
                                    // prioritara fata de numarare
wire [WIDTH  -1:0]  data_preset   ; // data presetare
wire [WIDTH  -1:0]  counter_out   ; // iesire numarator
wire                carry_out     ; // transport de iesire

counter_preset #(
.WIDTH       (WIDTH       )
) DUT_counter_preset (  
.clk         (clk         ),
.rst_n       (rst_n       ),
.count_up    (count_up    ),
.load        (load        ),
.data_preset (data_preset ),
.counter_out (counter_out ),
.carry_out   (carry_out   )
);  
  
ck_rst_tb i_ck_rst_tb ( 
.clk         (clk         ),
.rst_n       (rst_n       )
);  
  
counter_preset_tb  #( 
.WIDTH       (WIDTH       )
) i_counter_preset_tb ( 
.clk         (clk         ),
.rst_n       (rst_n       ),
.count_up    (count_up    ),
.load        (load        ),
.data_preset (data_preset )
);

endmodule // counter_preset_test
