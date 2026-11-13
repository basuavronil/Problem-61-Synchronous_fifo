module tb_synch_fifo;
  reg clk, rst, wr_en, rd_en;
  reg [7:0] d_in;
  wire [7:0] d_out;
  wire empty, full;

  // Instantiate DUT
  synch_fifo dut (
    .clk(clk), 
    .rst(rst), 
    .wr_en(wr_en), 
    .rd_en(rd_en), 
    .d_in(d_in), 
    .d_out(d_out), 
    .empty(empty), 
    .full(full)
  );

  // Clock Generation (10ns period)
  initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
  end

  // Stimulus using #10 delays
  initial begin
    // Initialize signals
    rst   = 1'b0;
    wr_en = 1'b0;
    rd_en = 1'b0;
    d_in  = 8'h00;

    // Apply Reset
    #12;
    rst = 1'b1;
    #10;
    
    $display("=== Starting FIFO Write (Filling FIFO) ===");
    // Fill the FIFO using a repeat loop with #10 delays
    repeat (16) begin
      wr_en = 1'b1;
      d_in  = $random;
      #10;
      $display("Writing: d_in = %0h | Full = %b | Empty = %b", d_in, full, empty);
    end

    // Attempt one extra write while full
    d_in = 8'hFF;
    #10;
    $display("Attempting write when FULL -> Full: %b", full);

    // Disable write
    wr_en = 1'b0;
    #10;

    $display("\n=== Starting FIFO Read (Emptying FIFO) ===");
    // Empty the FIFO using a repeat loop with #10 delays
    repeat (16) begin
      rd_en = 1'b1;
      #10;
      $display("Reading: d_out = %0h | Full = %b | Empty = %b", d_out, full, empty);
    end

    // Attempt one extra read while empty
    #10;
    $display("Attempting read when EMPTY -> Empty: %b", empty);

    // Disable read
    rd_en = 1'b0;

    #20;
    $finish;
  end

  // Monitor waveform generation
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_synch_fifo);
  end

endmodule
