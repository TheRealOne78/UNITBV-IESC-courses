`timescale 1ns/1ps

module counter #( WIDTH = 3 ) (
    input clk_i,
    input rst_ni,
    output reg [WIDTH-1:0] cnt_o
);

    always @(posedge clk_i or negedge rst_ni) begin
        if (~rst_ni)
            cnt_o <= 0;
        else
            cnt_o <= cnt_o + 1;
    end

endmodule
