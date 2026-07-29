`timescale 1ns/1ps
module register_file_tb;
    reg        clk = 0;
    reg        rst;
    reg  [1:0] write_addr;
    reg  [3:0] write_data;
    reg        write_enable;
    reg  [1:0] read_addr_a, read_addr_b;
    wire [3:0] read_data_a, read_data_b;

    register_file uut(
        .clk(clk), .rst(rst),
        .write_addr(write_addr), .write_data(write_data), .write_enable(write_enable),
        .read_addr_a(read_addr_a), .read_addr_b(read_addr_b),
        .read_data_a(read_data_a), .read_data_b(read_data_b)
    );

    always #5 clk = ~clk;

    initial begin
        rst = 1; write_enable = 0; write_addr = 0; write_data = 0;
        read_addr_a = 0; read_addr_b = 0;
        #10;

        rst = 0;
        write_enable = 1; write_addr = 2'd0; write_data = 4'd5; #10; // R0 = 5
        write_addr = 2'd1; write_data = 4'd3; #10;                  // R1 = 3
        write_enable = 0;

        read_addr_a = 2'd0; read_addr_b = 2'd1; #1;
        $display("A=R0=%d, B=R1=%d (expect 5, 3, read simultaneously)", read_data_a, read_data_b);

        $finish;
    end
endmodule