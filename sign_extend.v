module sign_extend(input [31:0] In,
                    input [1:0] ImmSrc,
                    output [31:0] ImmExt);

    assign ImmExt = (ImmSrc == 2'b00) ? ({{20{In[31]}}, In[31:20]}) :                         // This is for I-type (Load Instr.)
                    (ImmSrc == 2'b01) ? ({{20{In[31]}}, In[31:25], In[11:7]}) :               // This is for S-type
                    (ImmSrc == 2'b10) ? ({{20{In[31]}}, In[7], In[30:25], In[11:8], 1'b0}) :  // This is for B-type
                                        ({{20{In[31]}}, In[31:20]});
  
endmodule   
