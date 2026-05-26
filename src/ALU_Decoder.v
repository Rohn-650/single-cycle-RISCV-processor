module ALU_Decoder(

    input [1:0] ALUOp,
    input [2:0] funct3,
    input [6:0] funct7,

    output reg [2:0] ALUControl

);

always @(*) begin

    case(ALUOp)

        // Load / Store
        2'b00: ALUControl = 3'b000; // ADD

        // Branch
        2'b01: ALUControl = 3'b001; // SUB

        // R-Type Instructions
        2'b10: begin

            case(funct3)

                // ADD / SUB
                3'b000: begin

                    // SUB
                    if(funct7 == 7'b0100000)
                        ALUControl = 3'b001;

                    // ADD
                    else
                        ALUControl = 3'b000;

                end


                // MUL
                3'b001: begin

                    if(funct7 == 7'b0000001)
                        ALUControl = 3'b010;

                    else
                        ALUControl = 3'b000;

                end


                // DIV
                3'b100: begin
                
                    if(funct7 == 7'b0000001)
                        ALUControl = 3'b011;
                
                    else
                        ALUControl = 3'b000;
                
                end
                
                default: ALUControl = 3'b000;

            endcase

        end

        default: ALUControl = 3'b000;

    endcase

end

endmodule