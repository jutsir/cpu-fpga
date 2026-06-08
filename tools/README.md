# Project Automation Tools

This directory contains helper scripts for build and project automation.

## 🛠️ vivado-cli

`vivado-cli` is a custom command-line interface tool to abstract Vivado GUI operations.

### Prerequisite Dependencies

1.  **Xilinx Vivado** (v2024.2 recommended) - Ensure `vivado` command is added to your environment `PATH` (the default script points to `/opt/Xilinx/Vivado/2024.2/bin/vivado`).
2.  **openFPGALoader** - Used to flash generated bitstreams onto the FPGA.
    *   Installation details: [openFPGALoader GitHub Repository](https://github.com/trabucayre/openFPGALoader)

### Usage & Commands

Run these commands from either the `EC2` or `EC2e` root folders:

1.  **Recreate Vivado Project from Tcl script:**
    ```bash
    ../tools/vivado-cli --import
    ```
    This reconstructs the project file hierarchy and Vivado project configuration dynamically.

2.  **Compile & Generate Bitstream:**
    ```bash
    ../tools/vivado-cli --build
    ```
    Runs logic synthesis and implementation, generating the `.bit` bitstream file under the `vivado_prj` directory.

3.  **Program FPGA (Volatile RAM):**
    ```bash
    ../tools/vivado-cli --load
    ```
    Directly flashes the compiled bitstream into the volatile memory of the connected Nexys-4 board.

4.  **Program FPGA (Non-Volatile Flash):**
    ```bash
    ../tools/vivado-cli --load-flash
    ```
    Flashes the bitstream to the board's non-volatile SPI flash memory.

5.  **Export current Vivado changes to Tcl script (Git-friendly):**
    ```bash
    ../tools/vivado-cli --export
    ```
    Overwrites the `build_project.tcl` file with the updated GUI configuration.
