`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Juri Tsirihhov
// 
// Create Date: 05/15/2026 10:10:03 PM
// Design Name: 
// Module Name: tb_mp
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Testbench for verifying execution of instructions on the EC2
//              microprocessor (ec2_mp) design.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_ec2_mp();

  // --- 1. Signal Declarations ---
  reg        cpu_clk;
  reg        sys_rst;    // CPU_RESETN is active-low
  reg        enter_pulse;
  reg [7:0]  sw_input;
  
  wire [7:0] mp_data;
  wire       halt_status;
  wire [3:0] mp_state;

  // --- 2. DUT Instantiation ---
  ec2_mp dut (
    .Clock(cpu_clk),
    .Reset(sys_rst),
    .Enter(enter_pulse),
    .Input(sw_input),
    .Output(mp_data),
    .Halt(halt_status),
    .debug(mp_state) 
  );
  
  // --- 3. Clock Generation (100 MHz) ---
  initial begin
    cpu_clk = 0;
    forever #5 cpu_clk = ~cpu_clk; // 5ns high, 5ns low = 10ns period
  end
  
  // --- 4. Stimulus Process ---
  initial begin
    // Initial state
    sys_rst     = 1'b0; // System in reset (Active-Low)
    enter_pulse = 1'b0;
    sw_input    = 8'h2A; // Binary 42
    #50;
    $display("Time: %0t | Input configured: Data=0x2A", $time);
    
    #50;    
    $display("Time: %0t |--- Starting EC-2 System Simulation ---", $time);
    
    // Step 1: Power-on Reset
    sys_rst = 1'b1; // Press reset
    #20;
    sys_rst = 1'b0; // Release reset
    $display("Time: %0t | System Reset Released", $time);

    // Step 2: Simulate 'Enter' button press
    // Often used to trigger an instruction or load data
//    #200;
//    enter_pulse = 1'b1;
//    #100;
//    enter_pulse = 1'b0;
//    $display("Time: %0t | BTNC (Enter) pressed", $time);

    // Step 3: Wait for processor execution
    #20_000;
    
    if (halt_status)
        $display("Time: %0t | Processor reached HALT state", $time);

    $display("--- Simulation Finished ---");
    $finish;
  end

endmodule
