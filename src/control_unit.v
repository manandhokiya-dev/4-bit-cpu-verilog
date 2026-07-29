module control_unit(
    input      [3:0] opcode,
    output reg       reg_write,
    output reg       write_src,
    output reg [2:0] alu_op,
    output reg       halt,
    output reg       out_en
);
    always @(*) begin
        // safe defaults every cycle, so nothing "remembers" a stale value
        reg_write = 0;
        write_src = 0;
        alu_op    = 3'b000;
        halt      = 0;
        out_en    = 0;

        case (opcode)
            4'b0000: halt      = 1;                    // HLT
            4'b0001: begin reg_write = 1; write_src = 1; end // LOAD
            4'b0010: begin reg_write = 1; alu_op = 3'b000; end // ADD
            4'b0011: begin reg_write = 1; alu_op = 3'b001; end // SUB
            4'b0100: begin reg_write = 1; alu_op = 3'b010; end // AND
            4'b0101: begin reg_write = 1; alu_op = 3'b011; end // OR
            4'b0110: begin reg_write = 1; alu_op = 3'b100; end // XOR
            4'b0111: out_en    = 1;                    // OUT
        endcase
    end
endmodule