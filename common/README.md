# Common Utility Modules

This directory contains shared Verilog components used by both the EC2 and EC2e designs.

## 📁 Shared Modules

All source code is located in the **src/** folder:

*   `src/clk_divider.v` - Custom clock divider for stepping down system clock (100MHz).
*   `src/debouncer.v` / `oneshot.v` / `src/button_core.v` - Switch debouncers and pulse edge-generators.
*   `src/top_display.v` / `src/display7seg4x.v` - Multi-digit time-multiplexed 7-segment display driver.
*   `src/bin2bcd.v` / `src/bcd2segs.v` - Binary Coded Decimal conversion and character decoder.
*   `src/reset_synchronizer.v` - Reset synchronization to prevent metastability.
*   `src/ram.v` / `src/register.v` - Basic RAM and register blocks.
