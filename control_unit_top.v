`include "alu_decoder.v"
`include "main_decoder.v"

module control_unit_top(input [6:0] Op, funct7,
                        input [2:0] funct3, 
                        output RegWrite, ALUSrc, MemWrite, ResultSrc, Branch, PCSrc,
                        output [1:0] ImmSrc,
                        output [2:0] ALUControl);
  
    wire [1:0]ALUOp;

    main_decoder Main_Decoder(
                .op(Op),
                .RegWrite(RegWrite),
                .ImmSrc(ImmSrc),
                .MemWrite(MemWrite),
                .ResultSrc(ResultSrc),
                .PCSrc(PCSrc),
                .Branch(Branch),
                .ALUSrc(ALUSrc),
                .ALUOp(ALUOp)
    );

    alu_decoder ALU_Decoder(
                            .ALUOp(ALUOp),
                            .funct3(funct3),
                            .funct7(funct7),
                            .op(Op),
                            .ALUControl(ALUControl)
    );


endmodule
