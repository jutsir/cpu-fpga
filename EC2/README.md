# EC2 Microprocessor

This folder contains the Verilog implementation and Vivado project configuration for the standard **EC2** microprocessor.

## 📖 Instruction Set Architecture (ISA)

For the standard **EC2** processor, instructions are decoded using the **top 3 bits** of the Instruction Register (`IR[7:5]`), leaving the lower 5 bits (`IR[4:0]`) as the RAM target address.

| Instruction | Opcode (`IR[7:5]`) | Action | Description |
| :--- | :--- | :--- | :--- |
| **LOAD** | `3'b000` | $A \leftarrow \text{RAM}[\text{Addr}]$ | Load value from RAM address into accumulator $A$ |
| **STORE** | `3'b001` | $\text{RAM}[\text{Addr}] \leftarrow A$ | Store value from accumulator $A$ into RAM address |
| **ADD** | `3'b010` | $A \leftarrow A + \text{RAM}[\text{Addr}]$ | Add RAM value to accumulator $A$ |
| **SUB** | `3'b011` | $A \leftarrow A - \text{RAM}[\text{Addr}]$ | Subtract RAM value from accumulator $A$ |
| **INPUT** | `3'b100` | $A \leftarrow \text{Input}$ | Wait for the `Enter` pulse, then read 8-bit switch input into $A$ |
| **JZ** | `3'b101` | $\text{if } A == 0: PC \leftarrow \text{Addr}$ | Jump to Address if accumulator $A$ is zero |
| **JPOS** | `3'b110` | $\text{if } A[7] == 0: PC \leftarrow \text{Addr}$ | Jump to Address if accumulator $A \ge 0$ (MSB is 0) |
| **HALT** | `3'b111` | $\text{Halt} \leftarrow 1$ | Halts the CPU execution |

## 📁 File Structure

*   `build_project.tcl` - Tcl script to import/recreate the Vivado project.
*   `constraints/Nexys-4-DDR-Master.xdc` - Pin mapping constraints file for Nexys-4 DDR board.
*   `src/ec2_mp.v` - Core EC2 Microprocessor (FSM, registers, state logic).
*   `src/ec2_ram.v` - Instruction/data memory initialized with an EC2 program.
*   `src/ec2_top_soc.v` - SoC wrapper integrating clock dividers, debouncers, and displays.
*   `src/ec2_nexys4_top.v` - Board top-level entry point mapping ports to physical FPGA pins.
*   `src/tests/` - Verilog simulation testbenches for verification.

## 🛠️ Building & Running
You can use the helper script `../tools/vivado-cli` from this directory to recreate, build, and load the design. See [tools/README.md](../tools/README.md) for usage instructions.
