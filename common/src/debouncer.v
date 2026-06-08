`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/09/2026 02:50:02 AM
// Design Name: 
// Module Name: debouncer
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


module debouncer 
#(parameter THRESHOLD = 1000000) // 10ms at 100MHz
(
  input clk,
  input reset,
  input btn_in,
  output reg btn_out
);

  reg [19:0] counter; // Enough bits to hold 1,000,000
  reg sync_0, sync_1; // Flip-flops for synchronization

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      counter <= 0;
      btn_out <= 0;
      sync_0  <= 0;
      sync_1  <= 0;
    end else begin
      // Double-flop synchronization to avoid metastability
      sync_0 <= btn_in;
      sync_1 <= sync_0;

      if (sync_1 != btn_out) begin
        // If input differs from current stable output, start counting
        if (counter == THRESHOLD) begin
          counter <= 0;
          btn_out <= sync_1; // Update stable output
        end else begin
          counter <= counter + 1;
        end
      end else begin
        // Input matches output, reset counter
        counter <= 0;
      end
    end
  end
endmodule
