# Single Cycle RISC-V Processor

A 32-bit Single Cycle RISC-V Processor designed using Verilog HDL.
The processor executes instructions in a single clock cycle and was simulated using Xilinx Vivado.

---

# Architecture

<img width="668" height="257" alt="architecture" src="https://github.com/user-attachments/assets/06e31ef9-3f0c-4006-9d56-7fc83f721401" />


# Features

* 32-bit Single Cycle RISC-V CPU
* Modular Verilog implementation
* Arithmetic and memory operations
* Immediate generation support
* Instruction execution monitoring
* Vivado waveform simulation

---

# Supported Instructions

| Instruction | Type   | Function           |
| ----------- | ------ | ------------------ |
| add         | R-Type | Addition           |
| sub         | R-Type | Subtraction        |
| mul         | R-Type | Multiplication     |
| div         | R-Type | Division           |
| addi        | I-Type | Immediate Addition |
| lw          | I-Type | Load Word          |
| sw          | S-Type | Store Word         |
| beq         | B-Type | Branch Equal       |

---

# Project Structure

```text id="vcnqte"
single-cycle-RISCV-processor/
│
├── src/
├── sim/
└── README.md
```

---

# Main Modules

| Module              | Description            |
| ------------------- | ---------------------- |
| PC_Module           | Program Counter        |
| Instruction_Memory  | Stores instructions    |
| Register_File       | CPU registers          |
| Immediate_Generator | Generates immediates   |
| Main_Decoder        | Main control signals   |
| ALU_Decoder         | ALU operation decoder  |
| ALU                 | Arithmetic Logic Unit  |
| Data_Memory         | Data storage           |
| Mux                 | Data selection         |
| RISCV_Top           | Top integration module |

---

# Verification

The processor was verified using a custom Verilog testbench.

Simulation checks:

* Instruction execution
* ALU outputs
* Control signals
* Memory operations
* Register writeback

---


# Tools Used

* Verilog HDL
* Xilinx Vivado
* RISC-V ISA

---

# Future Improvements

* Pipeline architecture
* Hazard detection
* Branch prediction
* Forwarding unit
* FPGA implementation

---

# Author

**Rohn Eldho**
B.Tech Electronics and Communication Engineering
Muthoot Institute of Technology and Science (MITS)
