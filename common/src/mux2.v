`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2026 11:48:48 PM
// Design Name: 
// Module Name: mux2
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


module mux2
#(parameter n = 4)    // allow n to be changed
(
  input S,            // 1 select lines
  input [n-1:0] D0,     // 2 data inputs, each is n bits wide
  input [n-1:0] D1,
  output reg [n-1:0] Y  // n-bit wide output
);
  always @ (S or D0 or D1) begin
    case (S)
      0: Y = D0;
      1: Y = D1;
    endcase
  end
endmodule
