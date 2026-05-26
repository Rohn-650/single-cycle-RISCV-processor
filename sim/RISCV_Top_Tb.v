`timescale 1ns/1ps

module RISCV_Top_Tb();

reg clk;
reg rst;

// Instance of the Design Under Test (DUT)
RISCV_Top DUT(
    .clk(clk),
    .rst(rst)
);

// Clock Generation (Period = 100ns)
always #50 clk = ~clk;

// =========================================================
// Non-Intrusive Runtime Console Monitor
// =========================================================
initial begin
    // Clear screen console formatting
    $display("\n=================== STARTING RISC-V PIPELINE MONITOR ===================");
    
    // Wait until the system reset is released to print valid states
    @(posedge rst);
    @(negedge clk);
    
    // Automatically prints out a state trace to the Tcl console whenever PC or Instruction changes
    $monitor("Time: %5t ns | PC: 0x%h | Machine Code: 0x%h | ALU_Out: 0x%h | Zero: %b\n              | Control: RegWrite=%b, ALUSrc=%b, MemWrite=%b, ResultSrc=%b\n--------------------------------------------------------------------------------", 
             $time, 
             DUT.PC_Top,       // Mapped to your internal wire names
             DUT.RD_Instr,     // Fixed from Instr -> RD_Instr
             DUT.ALUResult, 
             DUT.Zero,
             DUT.RegWrite,
             DUT.ALUSrc,
             DUT.MemWrite,
             DUT.ResultSrc);
end

// Simulation Controller
initial begin
    clk = 0;
    
    // 1. Assert active-low reset (Your PC.v uses: if(!rst) PC <= 0)
    rst = 0; 
    #100;
    
    // 2. De-assert reset to kick off execution pipeline
    rst = 1;
    
    // Run simulation for enough cycles to step through your program
    #3000;
    
    $display("\n==================== SIMULATION EXECUTION FINISHED ====================\n");
    $finish;
end

endmodule