module Data_Memory(

    input clk,
    input rst,
    input WE,

    input [31:0] A,
    input [31:0] WD,

    output [31:0] RD

);

reg [31:0] mem [0:1023];


// Write
always @(posedge clk) begin

    if(WE)
        mem[A[31:2]] <= WD;

end


// Read
assign RD = (!rst) ? 32'b0 : mem[A[31:2]];


initial begin
    // Initializing index 3 to handle the address 14 byte lookup (14 >> 2 = 3)
    mem[3] = 32'hA5A5A5A5;
end

endmodule