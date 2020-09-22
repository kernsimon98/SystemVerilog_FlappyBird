module seg9H1 (bcd, leds);
	input logic [9:0] bcd;
	output logic [6:0] leds;

	always_comb begin
		case(bcd) 
		 10'b0000000000: leds = 7'b1000000; // 0
		 10'b0000000001: leds = 7'b1111001; // 1
		 10'b0000000010: leds = 7'b0100100; // 2 
		 10'b0000000011: leds = 7'b0110000; // 3
		 10'b0000000100: leds = 7'b0011001; // 4
		 10'b0000000101: leds = 7'b0010010; // 5 
		 10'b0000000110: leds = 7'b0000010; // 6 
		 10'b0000000111: leds = 7'b1111000; // 7
		 10'b0000001000: leds = 7'b0000000; // 8
		 10'b0000001001: leds = 7'b0010000; // 9
		 default: leds = 7'bX;
		endcase
	end
endmodule 