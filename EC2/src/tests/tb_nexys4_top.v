`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/14/2026 10:59:59 PM
// Design Name: 
// Module Name: tb_nexys4_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: System-level testbench specifically for Juri's Nexys 4 Top.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_nexys4_top();

  // --- 1. Signal Declarations ---
  reg        clk_100m;
  reg        reset_n;    // CPU_RESETN is active-low
  reg        btn_c;
  reg [15:0] switches;
  
  wire [7:0] segments;
  wire [7:0] digits;
  wire [0:0] led_halt;

  // --- 2. DUT Instantiation ---
  ec2_top_soc #(
    .CPU_FREQ_HZ(100_000_000),
    .DISPLAY_FREQ_HZ(50_000_000),
    .BUTTON_CLK_DIVIDER(1)
  ) dut (
    .clk_100m     (clk_100m),
    .reset_n_async(reset_n),
    .btn_enter    (btn_c),
    .sw_input     (switches[7:0]),
    .sw_sign_mode (switches[15]),
    .display_seg  (segments),
    .display_an   (digits),
    .halt_status  (led_halt)
  );

  // --- 3. Clock Generation (100 MHz) ---
  initial begin
    clk_100m = 0;
    forever #5 clk_100m = ~clk_100m; // 5ns high, 5ns low = 10ns period
  end

  // --- 4. Stimulus Process ---
  initial begin
    // Initial state
    reset_n  = 1'b1; // Release reset (Active-Low)
    btn_c    = 1'b0;
    switches = 16'h0000;
    #50;
    
    // Step 1: Set some data on switches (e.g., input for RAM or Operands)
    switches[7:0] = 8'h2A; // Binary 42
    switches[15]  = 1'b0;  // Disable sign mode
    $display("Time: %0t | Switches configured: Data=0x2A, Mode=NoSign", $time);
    #50;    
    
    $display("Time: %0t |--- Starting EC-2 System Simulation ---", $time);
    
    // Step 2: Power-on Reset
    #20;
    reset_n = 1'b0; // Press reset
    #100;
    reset_n = 1'b1; // Release reset
    $display("Time: %0t | System Reset Released", $time);

    // Step 3: Simulate 'Enter' button press
    // Often used to trigger an instruction or load data
    #200;
    btn_c = 1'b1;
    #100;
    btn_c = 1'b0;
    $display("Time: %0t | BTNC (Enter) pressed", $time);

    // Step 4: Wait for processor execution
    // You can observe SEG and AN signals here
    #20_000;
    
    if (led_halt[0])
        $display("Time: %0t | Processor reached HALT state", $time);

    $display("--- Simulation Finished ---");
    $finish;
  end

endmodule
