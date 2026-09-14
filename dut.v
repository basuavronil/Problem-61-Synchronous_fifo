`timescale 1ns / 1ps

module sync_fifo (
    input  wire       clk,
    input  wire       rst,      // Active-low reset (0 = reset)
    input  wire       wr_en,
    input  wire       rd_en, 
    input  wire [7:0] data_in,
    output reg  [7:0] data_out,
    output wire       empty,
    output wire       full
);

    reg [7:0]  mem [0:1023];
    reg [10:0] wr_ptr;
    reg [10:0] rd_ptr;

    // Status Flags (Bit 10 is MSB wrap bit, Bits [9:0] address memory)
    assign empty = (rd_ptr == wr_ptr);
    assign full  = (rd_ptr[10] != wr_ptr[10]) && (rd_ptr[9:0] == wr_ptr[9:0]);

    // Synchronous Write Logic
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            wr_ptr <= 11'd0;
        end else begin
            if (wr_en && !full) begin
                mem[wr_ptr[9:0]] <= data_in;
                wr_ptr           <= wr_ptr + 1'b1;
            end
        end
    end

    // Synchronous Read Logic
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            rd_ptr   <= 11'd0;
            data_out <= 8'd0;
        end else begin
            if (rd_en && !empty) begin
                data_out <= mem[rd_ptr[9:0]];
                rd_ptr   <= rd_ptr + 1'b1;
            end
        end
    end

endmodule
