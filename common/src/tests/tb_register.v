`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/15/2026 12:30:45 AM
// Design Name: 
// Module Name: tb_register
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_register();

  // --- 1. Signal Declarations ---
  parameter W = 8;
  reg         clk;
  reg         rst;
  reg         load;
  reg  [W-1:0] d;
  wire [W-1:0] q;

  // --- 2. DUT Instantiation ---
  register #(.n(W)) dut (
    .Clock (clk),
    .Clear (rst),
    .Load(load),
    .D   (d),
    .Q   (q)
  );

  // --- 3. Clock Generation Logic ---
  // We want a 100MHz clock (standard for Nexys 4)
  // Period = 10ns. Half-period = 5ns.
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // Toggle clock every 5ns
  end

  // --- 4. Stimulus Process ---
  initial begin
    // Initialize all inputs
    rst  = 1;
    load = 0;
    d    = 8'h00;

    $display("Starting Register Test...");

    // Step 1: Release reset after 20ns
    #20 rst = 0;
    $display("Time: %0t | Reset De-asserted", $time);

    // Step 2: Try to change 'd' while 'load' is 0
    // Data should NOT appear on 'q'
    d = 8'hAA;
    #10;
    if (q !== 8'h00) $display("Error: Register updated while load=0!");

    // Step 3: Enable 'load'
    // Data should appear on 'q' at the NEXT rising edge of clk
    @(posedge clk); // Wait for the start of a clock cycle
    load = 1;
    #10;            // Wait one full cycle
    load = 0;
    $display("Time: %0t | Data 0xAA loaded. Q = %h", $time, q);
    
    // Step 4: Set another data
    d = 8'hBB;
    #20
    $display("Time: %0t | New data 0xBB on input. Q = %h", $time, q);
    
    // Step 5: Enable 'load' with new data
    @(posedge clk); // Wait for the start of a clock cycle
    load = 1;
    #10;            // Wait one full cycle
    load = 0;
    $display("Time: %0t | Data 0xBB loaded. Q = %h", $time, q);    
    

    // Step 6: Check synchronous reset
    #10;
    d = 8'hFF;      // New data on input
    $display("Time: %0t | New data 0xFF on input. Q = %h", $time, q);
    
    #20;
    rst = 1;        // Activate reset
    @(posedge clk); // Wait for clock edge
    #1;             // Small delay to let signals settle in simulation
    $display("Time: %0t | Reset Active. Q = %h (should be 00)", $time, q);

    #20;
    $display("Register Test Finished.");
    $finish;
  end

endmodule
