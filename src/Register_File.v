module Register_File(

    input clk,
    input WE3,

    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,

    input [31:0] WD3,

    output [31:0] RD1,
    output [31:0] RD2

);

reg [31:0] Register [31:0];

integer i;


// =========================
// Register Initialization
// =========================
initial begin

    // Initialize all registers to 0
    for(i = 0; i < 32; i = i + 1)
        Register[i] = 32'b0;

    // Sample values
    Register[5] = 32'd20;
    Register[6] = 32'd5;

end


// =========================
// Write Operation
// =========================
always @(posedge clk) begin

    // x0 should always remain 0
    if(WE3 && (A3 != 0))
        Register[A3] <= WD3;

end


// =========================
// Read Operation
// =========================
assign RD1 = (A1 == 0) ? 32'b0 : Register[A1];

assign RD2 = (A2 == 0) ? 32'b0 : Register[A2];

endmodule