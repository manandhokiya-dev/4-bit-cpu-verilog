`timescale 1ns/1ps
module adder4_tb;
    reg  [3:0] a, b;
    reg        cin;
    wire [3:0] sum;
    wire       cout;

    adder4 uut(.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

    initial begin
        $dumpfile("adder4.vcd");
        $dumpvars(0, adder4_tb);

        cin = 0;

        a = 4'd5;  b = 4'd3;  #10;
        $display("%d + %d + cin=%b = %d  (cout=%b)", a, b, cin, sum, cout);

        a = 4'd9;  b = 4'd4;  #10;
        $display("%d + %d + cin=%b = %d  (cout=%b)", a, b, cin, sum, cout);

        a = 4'd15; b = 4'd1;  #10;
        $display("%d + %d + cin=%b = %d  (cout=%b)", a, b, cin, sum, cout);

        a = 4'd7;  b = 4'd7;  cin = 1; #10;
        $display("%d + %d + cin=%b = %d  (cout=%b)", a, b, cin, sum, cout);

        $finish;
    end
endmodule