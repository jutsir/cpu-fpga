# CPU on FPGA: EC2 & EC2e Microprocessors

This repository implements two custom educational 8-bit microprocessors, **EC2** and **EC2e** (Extended EC2), written in Verilog and targeted for deployment on the **Digilent Nexys-4 DDR** (Artix-7 XC7A100T) FPGA board. It includes the CPU designs, System-on-Chip (SoC) integration wrappers, peripheral drivers, and Vivado automation scripts.

The implementations of the **EC2** and **EC2e** microprocessors are based on the Finite State Machine with Datapath (FSMD) model presented in the textbook *Digital Logic and Microprocessor Design with Interfacing* (2nd Edition) by Enoch O. Hwang (ISBN: 978-1-305-85945-6).

---

## 📖 Architecture & Design Overview

Both processors use a basic accumulator-based architecture with an **8-bit word size** and a **5-bit address space** (addressing 32 bytes of internal RAM).

For detailed instruction sets and implementation documentation, see the individual project folders.

---

## 📁 Repository Directory Structure

Below is the directory map of the codebase. Each folder contains its own detailed documentation:

*   `EC2/` - Standard EC2 CPU Vivado Project and source code.
*   `EC2e/` - Extended EC2 CPU Vivado Project and source code.
*   `common/` - Shared utility modules library (debouncers, displays, RAM, clock dividers).
*   `tools/` - Project automation tools and build CLI.

---

## 🛠️ Toolchain and Build System

A custom command-line interface tool [vivado-cli](tools/vivado-cli) is provided to abstract Vivado GUI operations. For prerequisite installation steps and build command references, please see the [tools/README.md](tools/README.md).
