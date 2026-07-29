module instruction_memory(
    input      [3:0]  addr,
    output reg [11:0] instr
);
    reg [11:0] mem [0:15];

    initial begin
        mem[0] = 12'b0001_00_00_1100; // LOAD R0, #12
        mem[1] = 12'b0001_01_00_1010; // LOAD R1, #10
        mem[2] = 12'b0110_00_01_0000; // XOR  R0, R1
        mem[3] = 12'b0111_00_00_0000; // OUT  R0
        mem[4] = 12'b0000_00_00_0000; // HLT
    end

    always @(*) begin
        instr = mem[addr];
    end
endmodule