module tb();
  reg clk, rst, wr_en, rd_en;
  reg [7:0] d_in;
  wire [7:0] d_out;
  wire full, empty;   
  sync dut (.clk(clk), .rst(rst), .wr_en(wr_en), .rd_en(rd_en), .d_in(d_in), .d_out(d_out), .empty(empty), .full(full));
  initial begin    
    clk = 1'd0;
    forever #5 clk = ~clk;   
  end
  initial begin
    rst = 1'd0;
    wr_en = 1'd0;
    rd_en = 1'd0;
    d_in = 8'd0;
    $monitor (" d_in = %0d d_out = %0d empty = %0d full = %0d", d_in, d_out, empty, full);
    #10;
    rst = 1'd1;
    #10;
    repeat (16)
      begin
        wr_en = 1'd1;
        d_in = $random;
        #10;
        wr_en = 1'd0;
        #10;
      end
    #100;
    
    repeat(16) begin
      rd_en = 1'd1;
      #10;
    end
    #100;
    $finish;
  end
endmodule
           
