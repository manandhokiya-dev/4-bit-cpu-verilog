`timescale 1ns/1ps
module instruction_memory_tb;
    reg  [3:0]  addr;
    wire [11:0] instr;

    instruction_memory uut(.addr(addr), .instr(instr));

    integer i;
    initial begin
        for (i = 0; i < 5; i = i + 1) begin
            addr = i;
            #1;
            $display("addr=%d -> instr=%b", addr, instr);
        end
        $finish;
    end
endmodule