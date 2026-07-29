module alu(
    input  [3:0] a,
    input  [3:0] b,
    input  [2:0] op,
    output [3:0] result,
    output       carry,
    output       zero
);
    wire sub = (op == 3'b001);
    wire [3:0] b_mod = b ^ {4{sub}};
    wire [3:0] add_sub_result;
    wire       add_sub_carry;

    adder4 my_adder(.a(a), .b(b_mod), .cin(sub), .sum(add_sub_result), .cout(add_sub_carry));

    reg [3:0] result;

    always @(*) begin
        case (op)
            3'b000: result = add_sub_result;
            3'b001: result = add_sub_result;
            3'b010: result = a & b;
            3'b011: result = a | b;
            3'b100: result = a ^ b;
            default: result = 4'b0000;
        endcase
    end

    assign carry = add_sub_carry;
    assign zero  = (result == 4'b0000);
endmodule