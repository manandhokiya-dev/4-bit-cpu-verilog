`timescale 1ns/1ps
module cpu_tb;
    reg clk = 0;
    reg rst;
    wire out_valid;
    wire [3:0] out_value;
    wire halted;

    cpu uut(.clk(clk), .rst(rst), .out_valid(out_valid), .out_value(out_value), .halted(halted));

    always #5 clk = ~clk;

    initial begin
        $dumpfile("cpu.vcd");
        $dumpvars(0, cpu_tb);

        rst = 1; #10;
        rst = 0;

        repeat (10) begin
            #10;
            if (out_valid)
                $display("OUT: %d", out_value);
            if (halted) begin
                $display("CPU halted.");
                $finish;
            end
        end

        $finish;
    end
endmodule