module Main_Decoder(

    input [6:0] Op,

    output reg RegWrite,
    output reg ALUSrc,
    output reg MemWrite,
    output reg ResultSrc,
    output reg Branch,

    output reg [1:0] ImmSrc,
    output reg [1:0] ALUOp

);

always @(*) begin

    // Default values
    RegWrite = 0;
    ALUSrc   = 0;
    MemWrite = 0;
    ResultSrc= 0;
    Branch   = 0;
    ImmSrc   = 2'b00;
    ALUOp    = 2'b00;

    case(Op)

        // lw (Load Word)
        7'b0000011: begin
            RegWrite = 1;
            ALUSrc   = 1;
            ResultSrc= 1;
        end

        // sw (Store Word)
        7'b0100011: begin
            ALUSrc   = 1;
            MemWrite = 1;
            ImmSrc   = 2'b01;
        end

        // R-type
        7'b0110011: begin
            RegWrite = 1;
            ALUOp    = 2'b10;
        end

        // addi (I-Type Arithmetic)
        7'b0010011: begin
            RegWrite  = 1;
            ALUSrc    = 1;
            ResultSrc = 0;
            ALUOp     = 2'b00; // Uses the same ALU addition operation as loads/stores
        end

        // beq (Branch Equal)
        7'b1100011: begin
            Branch = 1;
            ImmSrc = 2'b10;
            ALUOp  = 2'b01;
        end

    endcase

end

endmodule