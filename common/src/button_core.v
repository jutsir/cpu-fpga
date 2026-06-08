`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/09/2026 04:04:06 AM
// Design Name: 
// Module Name: button_core
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


// -------------------------------------------------------------------------
// Module Name: button_core
// Description: Combines debouncing and edge detection for a physical button.
//              Provides a single-clock pulse upon button press or release.
// -------------------------------------------------------------------------
module button_core 
#(
  parameter CLK_DIVIDER = 1000000, // Debounce time (e.g., 10ms at 100MHz)
  parameter EDGE_TYPE = 0        // 0: Rising Edge (Press), 1: Falling Edge (Release)
)(
  input  clk,       // System clock (100MHz for Nexys 4 DDR)
  input  reset,     // System reset (Active HIGH)
  input  btn_in,    // Raw input from the physical button
  output pulse_out  // One-clock cycle pulse output
);

  // Intermediate signal: cleaned button level after debouncing logic
  wire btn_stable;

  // ---------------------------------------------------------------------
  // Sub-module: Debouncer
  // Removes mechanical contact bounce (noise) from the input signal.
  // ---------------------------------------------------------------------
  debouncer #(
    .THRESHOLD(CLK_DIVIDER)
  ) deb_inst (
    .clk(clk),
    .reset(reset),
    .btn_in(btn_in),
    .btn_out(btn_stable)
  );

  // ---------------------------------------------------------------------
  // Sub-module: Oneshot Universal (Edge Detector)
  // Generates a single-pulse based on the specified EDGE_TYPE.
  // ---------------------------------------------------------------------
  oneshot #(
    .EDGE_TYPE(EDGE_TYPE)
  ) oneshot_inst (
    .clk(clk),
    .reset(reset),
    .signal_in(btn_stable),
    .oneshot(pulse_out)
  );

endmodule
