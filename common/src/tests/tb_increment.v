`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/14/2026 10:25:59 PM
// Design Name: 
// Module Name: tb_increment
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Testbench for the parametric incrementer module.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_increment();

  // --- 1. Parameters and Signals ---
  parameter N_BITS = 4;        // Local parameter for test bit-width
  
  reg  [N_BITS-1:0] r_data_in; // Input stimulus (reg type to hold values)
  wire [N_BITS-1:0] w_data_out; // Output observation (wire type)

  // --- 2. Device Under Test (DUT) Instantiation ---
  increment #(.n(N_BITS)) dut (
    .A(r_data_in),  // Connect local reg to module input A
    .F(w_data_out)  // Connect module output F to local wire
  );

  // --- 3. Stimulus Generation ---
  initial begin
    // Display header in the Tcl Console
    $display("Starting Simulation...");
    $monitor("Time: %0t | Input A: %d (0x%h) | Output F: %d (0x%h)", 
             $time, r_data_in, r_data_in, w_data_out, w_data_out);

    // Test Case 1: Initial state
    r_data_in = 4'b0000; 
    #10; // Wait 10ns
    
    // Test Case 2: Standard increment
    r_data_in = 4'd5;    
    #10;
    
    // Test Case 3: Another value
    r_data_in = 4'd10;   
    #10;
    
    // Test Case 4: Overflow check (15 + 1 should result in 0)
    r_data_in = 4'b1111; 
    #10;
    
    // End of test
    $display("Simulation Finished.");
    $finish; 
  end

endmodule
