`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2026 10:23:18 PM
// Design Name: 
// Module Name: register
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


module register
#(parameter n = 4)        // allow n to be changed
(
  input Clock, Clear, Load,
  input [n-1:0] D,
  output reg [n-1:0] Q
);
  always @ (posedge Clock or posedge Clear) begin
    if (Clear == 1) begin
      Q <= {n {1'b0 } };  // n bits of 0
    end else if (Load) begin
      Q <= D;
    end
  end
endmodule
