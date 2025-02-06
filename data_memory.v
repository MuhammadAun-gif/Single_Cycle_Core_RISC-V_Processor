module data_memory(input clk, rst, WE,
                   input [31:0] WD,A,
                   output [31:0] RD);

    

    reg [31:0] data_mem [1023:0];

    always @ (posedge clk)
    begin
        if(WE)
            data_mem[A] <= WD;
    end

  assign RD = (~rst) ? 32'd0 : data_mem[A];

    initial begin
        data_mem[28] = 32'h00000020;
        //mem[40] = 32'h00000002;
    end


endmodule
