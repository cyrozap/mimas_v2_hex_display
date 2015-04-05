/*
 * Copyright 2015 Forest Crossman
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

module display_hex_byte(
	input clk,
	input [7:0] hex_byte,
	output wire [7:0] segments,
	output wire [2:0] segments_enable
	);

	parameter refresh_rate = 1000;
	parameter sys_clk_freq = 100000000;

	localparam clk_divider = sys_clk_freq / (refresh_rate * 3);

	reg [32:0] divider;

	reg [7:0] segments_out;
	reg [2:0] segments_enable_out;
	assign segments = segments_out;
	assign segments_enable = segments_enable_out;

	wire [7:0] high_segments;
	wire [7:0] low_segments;

	nibble_to_segments high_nib(hex_byte[7:4], high_segments);
	nibble_to_segments low_nib(hex_byte[3:0], low_segments);

	always @(posedge clk) begin
		if (divider < clk_divider)
			divider <= divider + 1;
		else begin
			divider <= 0;
			case (segments_enable_out)
				3'b001: begin
					segments_out <= 8'b00101110;
					segments_enable_out <= 3'b100;
				end
				3'b100: begin
					segments_out <= high_segments;
					segments_enable_out <= 3'b010;
				end
				3'b010: begin
					segments_out <= low_segments;
					segments_enable_out <= 3'b001;
				end
				default: begin
					segments_out <= 8'h00;
					segments_enable_out <= 3'b001;
				end
			endcase
		end
	end
endmodule

module nibble_to_segments(
	input [3:0] nibble,
	output wire [7:0] segments
	);

	reg [7:0] segments_out;
	assign segments = segments_out;

	always begin
		case (nibble)
			4'h0: segments_out = 8'b11111100;
			4'h1: segments_out = 8'b01100000;
			4'h2: segments_out = 8'b11011010;
			4'h3: segments_out = 8'b11110010;
			4'h4: segments_out = 8'b01100110;
			4'h5: segments_out = 8'b10110110;
			4'h6: segments_out = 8'b10111110;
			4'h7: segments_out = 8'b11100000;
			4'h8: segments_out = 8'b11111110;
			4'h9: segments_out = 8'b11110110;
			4'ha: segments_out = 8'b11101110;
			4'hb: segments_out = 8'b00111110;
			4'hc: segments_out = 8'b10011100;
			4'hd: segments_out = 8'b01111010;
			4'he: segments_out = 8'b10011110;
			4'hf: segments_out = 8'b10001110;
		endcase
	end
endmodule
