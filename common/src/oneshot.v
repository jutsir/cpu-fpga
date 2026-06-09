`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Juri Tsirihhov
// 
// Create Date: 05/09/2026 02:26:11 AM
// Design Name: 
// Module Name: oneshot
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Generates a single-clock cycle pulse (oneshot) on the rising
//              or falling edge of an input signal based on a parameter.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module oneshot 
#(parameter EDGE_TYPE = 0) // 0 for Rising Edge (Press), 1 for Falling Edge (Release)
(
  input clk,
  input reset,
  input signal_in,
  output oneshot
);
  reg q1, q2;

  // Sequential logic to delay the signal
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      q1 <= 1'b0;
      q2 <= 1'b0;
    end else begin
      q1 <= signal_in; 
      q2 <= q1;         
    end
  end

  // Combinational logic selection based on parameter
  // This is resolved during synthesis
  generate
    if (EDGE_TYPE == 0) begin : gen_rising_edge
      // Logic for Press (Rising Edge)
      assign oneshot = q1 & ~q2;
    end else begin : gen_falling_edge
      // Logic for Release (Falling Edge)
      assign oneshot = ~q1 & q2;
    end
  endgenerate

endmodule
