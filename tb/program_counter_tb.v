`timescale 1ns/1ps
module program_counter_tb;
    reg clk = 0;
    reg rst;
    wire [3:0] pc;

    program_counter uut(.clk(clk), .rst(rst), .pc(pc));

    always #5 clk = ~clk;

    initial begin
        rst = 1; #10;
        rst = 0;
        $display("pc = %d (right after reset)", pc);
        repeat (6) begin
            #10 $display("pc = %d", pc);
        end
        $finish;
    end
endmodule