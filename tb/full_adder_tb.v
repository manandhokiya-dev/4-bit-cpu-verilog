`timescale 1ns/1ps
module full_adder_tb;
    reg a, b, cin;
    wire sum, cout;

    full_adder uut(.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

    integer i;
    initial begin
        $dumpfile("full_adder.vcd");
        $dumpvars(0, full_adder_tb);
        for (i = 0; i < 8; i = i + 1) begin
            {a, b, cin} = i;
            #10;
            $display("a=%b b=%b cin=%b -> sum=%b cout=%b", a, b, cin, sum, cout);
        end
        $finish;
    end
endmodule