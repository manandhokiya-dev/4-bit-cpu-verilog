`timescale 1ns/1ps
module alu_tb;
    reg  [3:0] a, b;
    reg  [2:0] op;
    wire [3:0] result;
    wire       carry, zero;

    alu uut(.a(a), .b(b), .op(op), .result(result), .carry(carry), .zero(zero));

    initial begin
        $dumpfile("alu.vcd");
        $dumpvars(0, alu_tb);

        a = 4'd5; b = 4'd3; op = 3'b000; #10;
        $display("ADD: %d + %d = %d (carry=%b zero=%b)", a, b, result, carry, zero);

        a = 4'd5; b = 4'd3; op = 3'b001; #10;
        $display("SUB: %d - %d = %d (carry=%b zero=%b)", a, b, result, carry, zero);

        a = 4'd3; b = 4'd5; op = 3'b001; #10;
        $display("SUB: %d - %d = %d (carry=%b zero=%b)", a, b, result, carry, zero);

        a = 4'b1100; b = 4'b1010; op = 3'b010; #10;
        $display("AND: %b & %b = %b", a, b, result);

        a = 4'b1100; b = 4'b1010; op = 3'b011; #10;
        $display("OR:  %b | %b = %b", a, b, result);

        a = 4'b1100; b = 4'b1010; op = 3'b100; #10;
        $display("XOR: %b ^ %b = %b", a, b, result);

        a = 4'd5; b = 4'd5; op = 3'b001; #10;
        $display("SUB: %d - %d = %d (zero=%b)", a, b, result, zero);

        $finish;
    end
endmodule