module instruction_memory(input rst,
                          input [31:0] A,
                          output [31:0] RD);

  reg [31:0] Mem [1023:0];
  
  assign RD = (~rst) ? {32{1'b0}} : Mem[A[31:2]];

  initial begin
    $readmemh("mem_file.hex",Mem);
  end
  
endmodule
