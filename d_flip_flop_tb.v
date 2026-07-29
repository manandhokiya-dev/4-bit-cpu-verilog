`timescale 1ns/1ps
module d_flip_flop_tb;
    reg clk = 0;
    reg d;
    wire q;

    d_flip_flop uut(.clk(clk), .d(d), .q(q));

    // generate a clock: flip every 5ns, forever
    always #5 clk = ~clk;

    initial begin
        $dumpfile("dff.vcd");
        $dumpvars(0, d_flip_flop_tb);

        d = 0;
        #12 d = 1;   // change d mid-cycle, not exactly on an edge
        #20 d = 0;
        #20 d = 1;
        #20 $finish;
    end
endmodule