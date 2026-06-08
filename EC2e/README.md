# EC2e Microprocessor

This folder contains the Verilog implementation and Vivado project configuration for the **EC2e** (Extended EC2) microprocessor.

## 📖 Instruction Set Architecture (ISA)

The **EC2e** processor increases the instruction count by decoding up to **5 bits** (`IR[7:3]`). Instructions that require memory access (such as `AND`) use the last 5 bits of the instruction as the address (with `IR[4:3]` acting as don't-cares for opcode decode), while non-memory instructions (like `INPUT` and `OUTPUT`) leverage the full 5-bit opcode space.

| Instruction | Opcode (`IR[7:3]`) | Action | Description |
| :--- | :--- | :--- | :--- |
| **LOAD** | `5'b000_??` | $A \leftarrow \text{RAM}[\text{Addr}]$ | Load value from RAM address |
| **STORE** | `5'b001_??` | $\text{RAM}[\text{Addr}] \leftarrow A$ | Store accumulator $A$ to RAM address |
| **ADD** | `5'b010_??` | $A \leftarrow A + \text{RAM}[\text{Addr}]$ | Add RAM value to accumulator $A$ |
| **SUB** | `5'b011_??` | $A \leftarrow A - \text{RAM}[\text{Addr}]$ | Subtract RAM value from accumulator $A$ |
| **AND** | `5'b100_??` | $A \leftarrow A &#xff06; \text{ RAM}[\text{Addr}]$ | **[New]** Bitwise AND accumulator $A$ with RAM value |
| **JZ** | `5'b101_??` | $\text{if } A == 0: PC \leftarrow \text{Addr}$ | Jump to Address if accumulator $A$ is zero |
| **JPOS** | `5'b110_??` | $\text{if } A[7] == 0: PC \leftarrow \text{Addr}$ | Jump to Address if accumulator $A \ge 0$ |
| **INPUT** | `5'b111_00` | $A \leftarrow \text{Input}$ | Wait for the `Enter` pulse, then read 8-bit switch input into $A$ |
| **OUTPUT** | `5'b111_01` | $\text{Output} \leftarrow A$ | **[New]** Send value of accumulator $A$ to output register |
| **HALT** | `5'b111_1?` | $\text{Halt} \leftarrow 1$ | Halts the CPU execution |

## 📁 File Structure

*   `build_project.tcl` - Tcl script to import/recreate the Vivado project.
*   `constraints/Nexys-4-DDR-Master.xdc` - Pin mapping constraints file.
*   `src/ec2e_mp.v` - Core EC2e Microprocessor implementing the extended ISA.
*   `src/ec2e_ram.v` - Instruction/data memory initialized with an EC2e program.
*   `src/ec2e_top_soc.v` - SoC wrapper for the extended design.
*   `src/ec2e_nexys4_top.v` - Board top-level entry point for EC2e.
*   `src/tests/` - Testbenches for verification.

## 🛠️ Building & Running
You can use the helper script `../tools/vivado-cli` from this directory to recreate, build, and load the design. See [tools/README.md](../tools/README.md) for usage instructions.
