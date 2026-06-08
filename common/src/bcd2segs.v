`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/09/2026 01:07:56 AM
// Design Name: 
// Module Name: bcd2segs
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


module bcd2segs(
  input [3:0] I,
  output [7:0] Segs // Switched to [7:0] for standard MSB-to-LSB
);

  reg [7:0] segments;

  // Segment mapping: [7]=a, [6]=b, [5]=c, [4]=d, [3]=e, [2]=f, [1]=g, [0]=dp
  always @(I) begin
    case (I)
      4'h0: segments = 8'b11111100; 
      4'h1: segments = 8'b01100000;
      4'h2: segments = 8'b11011010;
      4'h3: segments = 8'b11110010;
      4'h4: segments = 8'b01100110;
      4'h5: segments = 8'b10110110;
      4'h6: segments = 8'b10111110;
      4'h7: segments = 8'b11100000;
      4'h8: segments = 8'b11111110;
      4'h9: segments = 8'b11110110;
      4'hA: segments = 8'b00000010;     // Minus sign (only G segment)
      default: segments = 8'b00000000;  // All segments OFF
    endcase
  end
  
  assign Segs = ~segments;            // Invert here for Common Anode

endmodule