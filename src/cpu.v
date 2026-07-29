module cpu(
    input        clk,
    input        rst,
    output       out_valid,
    output [3:0] out_value,
    output       halted
);
    wire [3:0]  pc;
    wire [11:0] instr;
    wire [3:0]  opcode = instr[11:8];
    wire [1:0]  dest   = instr[7:6];
    wire [1:0]  src    = instr[5:4];
    wire [3:0]  imm    = instr[3:0];

    wire reg_write, write_src, halt, out_en;
    wire [2:0] alu_op;

    wire [3:0] rd_val, rs_val;
    wire [3:0] alu_result;
    wire       alu_carry, alu_zero;
    wire [3:0] write_data;

    program_counter pc_unit(.clk(clk), .rst(rst), .hold(halt), .pc(pc));

    instruction_memory imem(.addr(pc), .instr(instr));

    control_unit ctrl(
        .opcode(opcode),
        .reg_write(reg_write), .write_src(write_src),
        .alu_op(alu_op), .halt(halt), .out_en(out_en)
    );

    register_file regs(
        .clk(clk), .rst(rst),
        .write_addr(dest), .write_data(write_data), .write_enable(reg_write),
        .read_addr_a(dest), .read_addr_b(src),
        .read_data_a(rd_val), .read_data_b(rs_val)
    );

    alu alu_unit(
        .a(rd_val), .b(rs_val), .op(alu_op),
        .result(alu_result), .carry(alu_carry), .zero(alu_zero)
    );

    assign write_data = write_src ? imm : alu_result;

    assign out_value = rd_val;
    assign out_valid = out_en;
    assign halted     = halt;
endmodule