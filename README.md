# Mimas V2 Hex Display Driver

## Usage

This module assumes you're using the official Mimas V2 constraints file. In
other words, your UCF should contain something like this:


    NET "SevenSegment[7]"            LOC = A3      | IOSTANDARD = LVCMOS33 | DRIVE = 8 | SLEW = FAST ;   #a
    NET "SevenSegment[6]"            LOC = B4      | IOSTANDARD = LVCMOS33 | DRIVE = 8 | SLEW = FAST ;   #b
    NET "SevenSegment[5]"            LOC = A4      | IOSTANDARD = LVCMOS33 | DRIVE = 8 | SLEW = FAST ;   #c
    NET "SevenSegment[4]"            LOC = C4      | IOSTANDARD = LVCMOS33 | DRIVE = 8 | SLEW = FAST ;   #d
    NET "SevenSegment[3]"            LOC = C5      | IOSTANDARD = LVCMOS33 | DRIVE = 8 | SLEW = FAST ;   #e
    NET "SevenSegment[2]"            LOC = D6      | IOSTANDARD = LVCMOS33 | DRIVE = 8 | SLEW = FAST ;   #f
    NET "SevenSegment[1]"            LOC = C6      | IOSTANDARD = LVCMOS33 | DRIVE = 8 | SLEW = FAST ;   #g
    NET "SevenSegment[0]"            LOC = A5      | IOSTANDARD = LVCMOS33 | DRIVE = 8 | SLEW = FAST ;   #dot

    NET "SevenSegmentEnable[2]"      LOC = B3      | IOSTANDARD = LVCMOS33 | DRIVE = 8 | SLEW = FAST ;   #Enables for Seven Segment
    NET "SevenSegmentEnable[1]"      LOC = A2      | IOSTANDARD = LVCMOS33 | DRIVE = 8 | SLEW = FAST ;
    NET "SevenSegmentEnable[0]"      LOC = B2      | IOSTANDARD = LVCMOS33 | DRIVE = 8 | SLEW = FAST ;

Then, to use the module, put this somewhere in your code:

```verilog
display_hex_byte #(
	.refresh_rate(refresh_rate),      // Default is 1000 (Hz)
	.sys_clk_freq(sys_clk_freq)       // Default is 100000000 (Hz)
)
instance_name(
	.clk(clk),                        // Master clock for the module (input)
	.hex_byte(hex_byte),              // The byte to be displayed    (input)
	.segments(segments),              // The bus of display segments (output)
	.segments_enable(segments_enable) // The bus of enable pins      (output)
);
```
