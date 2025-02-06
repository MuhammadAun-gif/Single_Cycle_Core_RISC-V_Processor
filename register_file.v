module register_file(input [4:0] A1, A2, A3,
                        input clk, rst, WE3,
                        input [31:0] WD3,
                        output [31:0] RD1, RD2);
    

    // Creation of Memory
    reg [31:0] Register [31:0];

    // Write data on clk edge
    always@(posedge clk)
    begin
        if (WE3)
            Register[A3] <= WD3;
    end

    // Read Functionality
    assign RD1 = (~rst) ? 32'd0 : Register[A1];
    assign RD2 = (~rst) ? 32'd0 : Register[A2];

    initial begin
        Register[5] = 32'h00000005;
        Register[6] = 32'h00000004;
    end

endmodule
