`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Juri Tsirihhov
// 
// Create Date: 05/09/2026 02:01:08 AM
// Design Name: 
// Module Name: top_display
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Top-level module wrapping the 7-segment display subsystem,
//              incorporating a clock divider and the multiplexed display
//              driver.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module top_display
  // CLK_DIVIDER: Division factor to step down the 100MHz input clock.
  // E.g., 50,000 divides 100MHz to 2kHz, which is the refresh/multiplexing clock 
  // frequency for the 7-segment display digits to avoid flickering.
#(parameter CLK_DIVIDER = 50000)
(
  input clk_100m,
  input reset,
  input [7:0] binary_in,
  input sign_mode,
  output [7:0] segs,
  output [7:0] anodes
);
  wire slow_clk;

  // Internal divider
  clk_divider #(.DIVIDE_BY(CLK_DIVIDER)) display_clk_gen (
      .clk_in(clk_100m),
      .reset(reset),
      .clk_out(slow_clk)
  );

  // Internal 7-segment controller
  display7seg4x display_inst (
      .Clock(slow_clk),
      .binary(binary_in),
      .signednumber(sign_mode),
      .Segs(segs),
      .Anodes(anodes)
  );
endmodule