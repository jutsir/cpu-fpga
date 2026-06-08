`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2026 11:42:47 PM
// Design Name: 
// Module Name: mux4
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


module mux4
#(parameter n = 4)      // allow n to be changed
(
  input [1:0] S,        // 2 select lines
  input [n-1:0] D0,     // 4 data inputs, each is n bits wide
  input [n-1:0] D1,
  input [n-1:0] D2,
  input [n-1:0] D3,
  output reg [n-1:0] Y  // n-bit wide output
);
  always @ (S or D0 or D1 or D2 or D3) begin
    case (S)
      0: Y = D0;
      1: Y = D1;
      2: Y = D2;
      3: Y = D3;
    endcase
  end
endmodule
