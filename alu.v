module alu(input [31:0] A,B,
            input [2:0] ALUControl,
            input OverFlow,Carry,Zero,Negative,
           output [31:0] Result);
    
    wire Cout;
    wire [31:0] sum;

    assign {Cout,sum} = (ALUControl[0] == 1'b0) ? A + B :
                                          (A + ((~B)+1)) ;
    assign Result = (ALUControl == 3'b000) ? sum :
                    (ALUControl == 3'b001) ? sum :
                    (ALUControl == 3'b010) ? A & B :
                    (ALUControl == 3'b011) ? A | B :
                    (ALUControl == 3'b101) ? {{31{1'b0}},(sum[31])} : {32{1'b0}};
    
    assign OverFlow = ((sum[31] ^ A[31]) & 
                      (~(ALUControl[0] ^ B[31] ^ A[31])) &
                      (~ALUControl[1]));
    assign Carry = ((~ALUControl[1]) & Cout);
    assign Zero = &(~Result);
    assign Negative = Result[31];

endmodule
