`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Juri Tsirihhov
// 
// Create Date: 05/16/2026 01:01:40 AM
// Design Name: 
// Module Name: tb_button_core
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Testbench for verifying the debouncer and edge-detector
//              (button_core) module.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_button_core();
  localparam CPU_FREQ_HZ = 20_000_000;
  localparam CLK_FREQ_HZ = 100_000_000; // 100 MHz system clock
  localparam CPU_THRESHOLD = CLK_FREQ_HZ / CPU_FREQ_HZ;
  localparam FINAL_CPU_THRESHOLD = (CPU_THRESHOLD > 0) ? CPU_THRESHOLD : 1;

  // --- 1. Signal Declarations ---
  reg        clk_100m;
  reg        sys_rst;    // CPU_RESETN is active-low
  reg        btn_enter;
  
  wire       enter_pulse;  

  // --- 2. DUT Instantiation ---
  
  // Clock divider for processor
  clk_divider #(
    .DIVIDE_BY(FINAL_CPU_THRESHOLD)
  ) mp_clk_gen (
    .clk_in(clk_100m),
    .reset(sys_rst),
    .clk_out(cpu_clk)
  ); 
  
  button_core #(
    .CLK_DIVIDER(1), // Debounce time (e.g., 10ms)
    .EDGE_TYPE(0)
  ) dut (
    .clk(clk_100m),
    .reset(sys_rst),
    .btn_in(btn_enter),
    .pulse_out(enter_pulse)
  );
  
  // --- 3. Clock Generation (100 MHz) ---
  initial begin
    clk_100m = 0;
    forever #5 clk_100m = ~clk_100m; // 5ns high, 5ns low = 10ns period
  end
  
  // --- 4. Stimulus Process ---
  initial begin
    // Initial state
    sys_rst     = 1'b0; // System in reset (Active-Low)
    btn_enter   = 1'b0;
    #50;
    $display("Time: %0t | Input configured", $time);
    
    // Step 1: Power-on Reset
    sys_rst = 1'b1; // Press reset
    #20;
    sys_rst = 1'b0; // Release reset
    $display("Time: %0t | System Reset Released", $time);
    
    // Step 2: Simulate 'Enter' button press
    // Often used to trigger an instruction or load data
    #200;
    btn_enter = 1'b1;
    #100;
    btn_enter = 1'b0;
    $display("Time: %0t | BTNC (Enter) pressed", $time);
    
    #200;
    $display("--- Simulation Finished ---");
    $finish;
  end

endmodule
