`timescale 1ns / 1ps

module sync_fifo_tb;

    reg        clk;
    reg        rst;
    reg        wr_en;
    reg        rd_en;
    reg  [7:0] data_in;
    wire [7:0] data_out;
    wire       empty;
    wire       full;

    // Instantiate UUT
    sync_fifo uut (
        .clk(clk),
        .rst(rst),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .data_in(data_in),
        .data_out(data_out),
        .empty(empty),
        .full(full)
    );

    // Waveform Dump Configuration
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, sync_fifo_tb);
    end

    // Signal Monitor for Terminal Output
    initial begin
        $monitor("[%0t ns] rst=%b | wr_en=%b data_in=0x%h | rd_en=%b data_out=0x%h | empty=%b full=%b",
                 $time, rst, wr_en, data_in, rd_en, data_out, empty, full);
    end

    // Clock Generation: 100 MHz (10ns Period)
    always #5 clk = ~clk;

    integer i;

    initial begin
        // 1. Initialize Signals & Assert Active-Low Reset
        clk     = 0;
        rst     = 0; // Assert Active-Low Reset
        wr_en   = 0;
        rd_en   = 0;
        data_in = 0;

        #12;
        rst = 1; // Release Reset

        // 2. Write Test Data (Push 5 items)
        for (i = 1; i <= 5; i = i + 1) begin
            @(posedge clk);
            wr_en   = 1;
            data_in = i * 8'h11; // Push 0x11, 0x22, 0x33...
        end

        @(posedge clk);
        wr_en = 0; // Stop writing

        // 3. Read Test Data (Pop 5 items)
        for (i = 1; i <= 5; i = i + 1) begin
            @(posedge clk);
            rd_en = 1;
        end

        @(posedge clk);
        rd_en = 0; // Stop reading

        #20;
        $finish;
    end

endmodule
