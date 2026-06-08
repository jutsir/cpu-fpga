`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/09/2026 02:53:22 AM
// Design Name: 
// Module Name: top_soc
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


module ec2_top_soc
#(parameter CPU_FREQ_HZ = 200, // Hz cpu clock 
  parameter DISPLAY_FREQ_HZ = 2000, // Hz display refresh frequency
  parameter BUTTON_CLK_DIVIDER = 0) 
(
  input         clk_100m,
  input         reset_n_async, // Raw Active LOW reset from button
  input         btn_enter,
  input  [7:0]  sw_input,
  input         sw_sign_mode,
  output [7:0]  display_seg,
  output [7:0]  display_an,
  output        halt_status
);

  // --- Constants and Time Calculations ---
  localparam DEBOUNCE_NS = 10;
   
  localparam CLK_FREQ_HZ = 100_000_000; // 100 MHz system clock
  localparam DISPLAY_CLK_DIVIDER = CLK_FREQ_HZ / DISPLAY_FREQ_HZ;
  localparam CPU_THRESHOLD = CLK_FREQ_HZ / CPU_FREQ_HZ;
  localparam FINAL_CPU_THRESHOLD = (CPU_THRESHOLD > 0) ? CPU_THRESHOLD : 1;
      
  localparam DEBOUNCE_THRESHOLD = (CPU_FREQ_HZ * DEBOUNCE_NS) / 1_000_000;
  localparam FINAL_DEBOUNCE = (BUTTON_CLK_DIVIDER > 0) ? BUTTON_CLK_DIVIDER : 
                              (DEBOUNCE_THRESHOLD > 0) ? DEBOUNCE_THRESHOLD : 1;

  wire sys_rst;
  wire btn_stable;
  wire enter_pulse;
  wire [7:0] mp_data;
  wire cpu_clk;
  
  // 1. Internal synchronized reset signal
  reset_synchronizer rst_gen (
    .clk(clk_100m),
    .async_rst_n(reset_n_async),
    .sync_rst(sys_rst)
  );
  
  // Clock divider for processor
  clk_divider #(
    .DIVIDE_BY(FINAL_CPU_THRESHOLD)
  ) mp_clk_gen (
    .clk_in(clk_100m),
    .reset(sys_rst),
    .clk_out(cpu_clk)
  );

  // 2. Enter button processing (using the safe sys_rst)
  button_core #(
    .CLK_DIVIDER(FINAL_DEBOUNCE), // Debounce time (e.g., 10ms)
    .EDGE_TYPE(0)
  ) enter_button (
    .clk(cpu_clk),
    .reset(sys_rst),
    .btn_in(btn_enter),
    .pulse_out(enter_pulse)
  );

  // 3. EC2 Processor (MP)
  ec2_mp processor (
    .Clock(cpu_clk),
    .Reset(sys_rst),
    .Enter(enter_pulse),
    .Input(sw_input),
    .Output(mp_data),
    .Halt(halt_status),
    .debug() 
  );

  // 4. Integrated Display Subsystem
  top_display #(
      .CLK_DIVIDER(DISPLAY_CLK_DIVIDER)
    ) visual_subsystem (
    .clk_100m(clk_100m),
    .reset(sys_rst),
    .binary_in(mp_data),
    .sign_mode(sw_sign_mode),
    .segs(display_seg),
    .anodes(display_an)
  );

endmodule
