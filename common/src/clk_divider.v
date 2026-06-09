`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Juri Tsirihhov
// 
// Create Date: 05/09/2026 02:01:08 AM
// Design Name: 
// Module Name: clk_divider
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Divides the input clock by a parameterizable division factor
//              to produce a lower-frequency clock.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clk_divider
#(parameter DIVIDE_BY = 50000) // Default value
(
  input clk_in,
  input reset,
  output reg clk_out
);

  // Calculate bit width needed for the counter
  reg [31:0] counter;

  always @(posedge clk_in or posedge reset) begin
    if (reset) begin
      counter <= 0;
      clk_out <= 0;
    end else begin
      if (counter >= (DIVIDE_BY - 1)) begin
        counter <= 0;
        clk_out <= ~clk_out; // Toggle output clock
      end else begin
        counter <= counter + 1;
      end
    end
  end
endmodule
