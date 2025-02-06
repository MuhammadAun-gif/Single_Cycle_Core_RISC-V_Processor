`include "program_counter.v"
`include "instruction_memory.v"
`include "register_file.v"
`include "sign_extend.v"
`include "alu.v"
`include "control_unit_top.v"
`include "data_memory.v"
`include "adder.v"
`include "mux.v"

module single_cycle_top(input clk, rst);
    
    wire [31:0] PC_top, RD_instr, RD1_op, ImmExt_op, ALUResult, ReadData, PCplus4, RD2_op, SrcB, Result, PC_mux_out, PCTarget_op;
    wire [2:0] ALUControl_top;
    wire RegWrite, MemWrite, ALUSrc_op, ResultSrc, PCSrc; 
    wire [1:0] ImmSrc;

    program_counter PC(
        .clk(clk),
        .rst(rst),
        .PC_Next(PC_mux_out),
        .PC(PC_top)   
    );

    instruction_memory instmem(
        .rst(rst),
        .A(PC_top),
        .RD(RD_instr)
    );

    register_file Reg_file(
        .clk(clk),
        .rst(rst),
        .WE3(RegWrite),
        .A1(RD_instr[19:15]),
        .A2(RD_instr[24:20]),
        .A3(RD_instr[11:7]),
        .WD3(Result),
        .RD1(RD1_op),
        .RD2(RD2_op)
    );

    sign_extend sign_extend(
        .In(RD_instr),
        .ImmSrc(ImmSrc),
        .ImmExt(ImmExt_op)
    );

    mux Mux_Register_to_ALU(
        .a(RD2_op),
        .b(ImmExt_op),
        .s(ALUSrc_op),
        .c(SrcB)
    );

    alu ALU(
        .A(RD1_op),
        .B(ImmExt_op),
        .ALUControl(ALUControl_top),
        .Result(ALUResult),
        .Z(),
        .N(),
        .V(),
        .C()
    );

    control_unit_top control_Top(
        .Op(RD_instr[6:0]),
        .RegWrite(RegWrite),
        .ImmSrc(ImmSrc),
        .ALUSrc(ALUSrc_op),
        .MemWrite(MemWrite),
        .ResultSrc(ResultSrc),
        .PCSrc(PCSrc),
        .Branch(),
        .funct3(RD_instr[14:12]),
        .funct7(RD_instr[6:0]),
        .ALUControl(ALUControl_top)
    );

    data_memory data_memory(
        .clk(clk),
        .rst(rst),
        .A(ALUResult), 
        .WE(MemWrite), 
        .RD(ReadData),
        .WD(RD2_op)
    );

    adder PCPlus4_adder(
        .a(PC_top),
        .b(32'd4),
        .c(PCplus4)
    );

    mux Mux_DataMemory_to_Register(
                            .a(ALUResult),
                            .b(ReadData),
                            .s(ResultSrc),
                            .c(Result)
    );

    adder PCTarget(
        .a(PC_top),
        .b(ImmExt_op),
        .c(PCTarget_op)
    );

    mux MUX_ADDER_to_PC(
        .a(PCplus4),
        .b(PCTarget_op),
        .s(PCSrc),
        .c(PC_mux_out)
    );


endmodule
