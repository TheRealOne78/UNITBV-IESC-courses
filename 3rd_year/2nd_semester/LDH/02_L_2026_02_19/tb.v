`timescale 1ns/1ps

module tb;

    localparam BITS       = 3;
    localparam CLK_PER_NS = 10;   // integer ns period

    reg clk = 0, rst_n;
    reg [BITS-1:0] cnt;

    // Instantiate counter
    counter #(
        .WIDTH(BITS)
    ) cnt_inst (
        .clk_i(clk),
        .rst_ni(rst_n),
        .cnt_o(cnt)
    );

    // Clock generation: integer delay
    always #(CLK_PER_NS/2) clk = ~clk;

    initial begin
        /* verilator lint_off SYNCASYNCNET */
        $monitor("Time=%t, Cnt=%d", $time, cnt);
        /* verilator lint_on SYNCASYNCNET */

        rst_n = 1;
        repeat (10) @(posedge clk);

        rst_n = 0;
        repeat (3) @(posedge clk);

        rst_n = 1;
        repeat (10) @(posedge clk);
        $stop;
    end

endmodule
