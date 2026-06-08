`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/11/2026 11:42:25 PM
// Design Name: 
// Module Name: reset_synchronizer
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Synchronizes an asynchronous reset signal to the clock domain.
//              Asserts reset immediately (asynchronously) but deasserts it 
//              synchronously to prevent timing violations (metastability).
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module reset_synchronizer (
  input  clk,         // System clock (e.g., 100MHz)
  input  async_rst_n, // Raw reset from button (Active LOW on Nexys 4)
  output sync_rst     // Synchronized reset output (Active HIGH)
);

  // Two-stage shift register for synchronization
  reg rst_stage1;
  reg rst_stage2;

  // Use asynchronous preset (the button press)
  // and synchronous clearing (the release)
  always @(posedge clk or negedge async_rst_n) begin
    if (!async_rst_n) begin
      // When button is pressed, force registers to HIGH immediately
      rst_stage1 <= 1'b1;
      rst_stage2 <= 1'b1;
    end else begin
      // When button is released, '0' ripples through on clock edges
      rst_stage1 <= 1'b0;
      rst_stage2 <= rst_stage1;
    end
  end

  // The output is the second stage, ensuring stability
  assign sync_rst = rst_stage2;

endmodule
