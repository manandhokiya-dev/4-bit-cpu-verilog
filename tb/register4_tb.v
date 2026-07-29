`timescale 1ns/1ps
module register4_tb;
    reg clk = 0;
    reg rst;
    reg [3:0] d;
    wire [3:0] q;

    register4 uut(.clk(clk), .rst(rst), .d(d), .q(q));

    always #5 clk = ~clk;

    initial begin
        $dumpfile("register4.vcd");
        $dumpvars(0, register4_tb);

        rst = 1; d = 0;
        #10 $display("after reset pulse: q=%b (expect 0000)", q);

        rst = 0;
        d = 4'b1010;
        #10 $display("loaded d=1010: q=%b", q);

        d = 4'b0011;
        #10 $display("loaded d=0011: q=%b", q);

        rst = 1;
        #10 $display("reset again mid-run: q=%b (expect 0000)", q);

        $finish;
    end
endmodule