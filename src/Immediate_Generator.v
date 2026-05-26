module Immediate_Generator(

    input [31:0] In,
    input ImmSrc,

    output [31:0] Imm_Ext

);

assign Imm_Ext = (ImmSrc) ?

                 // S-Type Immediate
                 {{20{In[31]}}, In[31:25], In[11:7]} :

                 // I-Type Immediate
                 {{20{In[31]}}, In[31:20]};

endmodule