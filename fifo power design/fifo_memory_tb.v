`timescale 1ns/1ps

module low_power_fifo_tb;

    parameter DATA_WIDTH = 8;
    parameter DEPTH      = 8;
    parameter PTR_WIDTH  = 3;

    reg clk;
    reg reset;

    reg wr_en;
    reg rd_en;
    reg [DATA_WIDTH-1:0] data_in;

    wire [DATA_WIDTH-1:0] data_out;
    wire full;
    wire empty;

    // DUT
    low_power_fifo #(
        .DATA_WIDTH(DATA_WIDTH),
        .DEPTH(DEPTH),
        .PTR_WIDTH(PTR_WIDTH)
    ) uut (
        .clk(clk),
        .reset(reset),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .data_in(data_in),
        .data_out(data_out),
        .full(full),
        .empty(empty)
    );

    // 10 ns clock
    always #5 clk = ~clk;

    // Write task
    task write_data(input [DATA_WIDTH-1:0] data);
    begin
        @(negedge clk);

        wr_en   = 1;
        rd_en   = 0;
        data_in = data;

        @(posedge clk);
        #1;

        $display(
            "Time=%0t | WRITE | Data=%h | Full=%b | Empty=%b",
            $time, data_in, full, empty
        );

        @(negedge clk);
        wr_en = 0;
    end
    endtask

    // Read task
    task read_data;
    begin
        @(negedge clk);

        wr_en = 0;
        rd_en = 1;

        @(posedge clk);
        #1;

        $display(
            "Time=%0t | READ  | Data=%h | Full=%b | Empty=%b",
            $time, data_out, full, empty
        );

        @(negedge clk);
        rd_en = 0;
    end
    endtask

    initial begin

        $monitor(
            "Time=%0t | WR=%b | RD=%b | Data_In=%h | Data_Out=%h | Full=%b | Empty=%b",
            $time,
            wr_en,
            rd_en,
            data_in,
            data_out,
            full,
            empty
        );

        // Initial conditions
        clk     = 0;
        reset   = 1;
        wr_en   = 0;
        rd_en   = 0;
        data_in = 0;

        // Reset
        #10;
        reset = 0;

        // Write four values
        write_data(8'h10);
        write_data(8'h20);
        write_data(8'h30);
        write_data(8'h40);

        // Idle period
        $display("---- FIFO IDLE: No read/write activity ----");

        repeat (2)
            @(posedge clk);

        // Read four values
        read_data();
        read_data();
        read_data();
        read_data();

        // Idle period
        $display("---- FIFO EMPTY ----");

        repeat (2)
            @(posedge clk);

        $finish;

    end

endmodule