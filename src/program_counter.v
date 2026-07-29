module program_counter(
    input             clk,
    input             rst,
    input             hold,
    output reg [3:0]  pc
);
    always @(posedge clk) begin
        if (rst)
            pc <= 0;
        else if (hold)
            pc <= pc;
        else
            pc <= pc + 1;
    end
endmodule