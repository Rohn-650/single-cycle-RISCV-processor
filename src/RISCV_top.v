// Single Cycle RISC-V Processor Top Module


module RISCV_Top(

    input clk,
    input rst

);

    // =========================
    // Internal Wires
    // =========================

    wire [31:0] PC_Top;
    wire [31:0] PCPlus4;
    wire [31:0] PC_Next;

    wire [31:0] RD_Instr;

    wire [31:0] RD1_Top;
    wire [31:0] RD2_Top;

    wire [31:0] Imm_Ext_Top;

    wire [31:0] SrcB;

    wire [31:0] ALUResult;

    wire [31:0] ReadData;

    wire [31:0] Result;

    wire RegWrite;
    wire MemWrite;
    wire ALUSrc;
    wire ResultSrc;
    wire Branch;

    wire [1:0] ImmSrc;

    wire [2:0] ALUControl_Top;

    wire Zero;

    // =========================
    // Program Counter
    // =========================

    PC_Module PC(

        .clk(clk),
        .rst(rst),

        .PC(PC_Top),
        .PC_Next(PC_Next)

    );


    // =========================
    // PC + 4 Adder
    // =========================

    PC_Adder PC_Plus4(

        .a(PC_Top),
        .b(32'd4),

        .c(PCPlus4)

    );


    // =========================
    // Next PC Logic
    // =========================

    assign PC_Next = PCPlus4;


    // =========================
    // Instruction Memory
    // =========================

    Instruction_Memory IMEM(

        .rst(rst),
        .A(PC_Top),

        .RD(RD_Instr)

    );


    // =========================
    // Register File
    // =========================

   Register_File RF(
    
        .clk(clk),
    
        .WE3(RegWrite),
    
        .WD3(Result),
    
        .A1(RD_Instr[19:15]),
        .A2(RD_Instr[24:20]),
        .A3(RD_Instr[11:7]),
    
        .RD1(RD1_Top),
        .RD2(RD2_Top)
    
    );

    // =========================
    // Immediate Generator
    // =========================

    Immediate_Generator IMM_GEN(

        .In(RD_Instr),
        .ImmSrc(ImmSrc[0]),

        .Imm_Ext(Imm_Ext_Top)

    );


    // =========================
    // ALU Source MUX
    // =========================

    Mux ALU_SRC_MUX(

        .a(RD2_Top),
        .b(Imm_Ext_Top),

        .s(ALUSrc),

        .c(SrcB)

    );

    // =========================
    // ALU
    // =========================

    ALU ALU(

        .A(RD1_Top),
        .B(SrcB),

        .ALUControl(ALUControl_Top),

        .Result(ALUResult),

        .Zero(Zero)

    );


    // =========================
    // Control Unit
    // =========================

    Control_Unit CU(

        .Op(RD_Instr[6:0]),

        .RegWrite(RegWrite),
        .ImmSrc(ImmSrc),

        .ALUSrc(ALUSrc),

        .MemWrite(MemWrite),

        .ResultSrc(ResultSrc),

        .Branch(Branch),

        .funct3(RD_Instr[14:12]),

        .funct7(RD_Instr[31:25]),

        .ALUControl(ALUControl_Top)

    );


    // =========================
    // Data Memory
    // =========================

    Data_Memory DMEM(

        .clk(clk),
        .rst(rst),

        .WE(MemWrite),

        .WD(RD2_Top),

        .A(ALUResult),

        .RD(ReadData)

    );

    // =========================
    // Write Back MUX
    // =========================

    Mux WB_MUX(

        .a(ALUResult),
        .b(ReadData),

        .s(ResultSrc),

        .c(Result)

    );

endmodule
