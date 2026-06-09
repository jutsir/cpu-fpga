`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Juri Tsirihhov
// 
// Create Date: 05/09/2026 03:12:25 AM
// Design Name: 
// Module Name: nexys4_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Top-level wrapper mapping physical Nexys 4 DDR FPGA board
//              pins (clock, reset, button, switches, LEDs, and 7-segment
//              display digits) to the logical EC2 SoC ports.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ec2_nexys4_top (
  input         CLK100MHZ,    // From XDC (Pin E3)
  input         CPU_RESETN,   // From XDC (Pin C12)
  input         BTNC,         // From XDC (Pin N17)
  input  [15:0] SW,           // From XDC (All 16 SW Pins J15-V10)
  output [7:0]  SEG,          // From XDC (CA...DP)
  output [7:0]  AN,           // From XDC (AN0...AN7)
  output [0:0]  LED           // From XDC (H17)
);
  
  // Connecting physical pins to your logical system
  ec2_top_soc #(
    .CPU_FREQ_HZ(200),
    .DISPLAY_FREQ_HZ(2000)
  ) core_logic (
    .clk_100m       (CLK100MHZ),
    .reset_n_async  (CPU_RESETN),
    .btn_enter      (BTNC),
    .sw_input       (SW[7:0]),
    .sw_sign_mode   (SW[15]),
    .display_seg    (SEG),
    .display_an     (AN),
    .halt_status    (LED[0])
  );

endmodule
