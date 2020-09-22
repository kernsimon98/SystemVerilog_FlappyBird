module countersFB (Score, Rleds, RRleds, leds, RST, clk);
	input logic Score, RST, clk;
	input logic [6:0] Rleds, RRleds;
	output logic [6:0] leds;
	logic [6:0] ps;

	assign leds = ps;
	
	
	always_ff @(posedge clk) begin
		if(RST)
			ps <= 7'b1000000;
		else 
			if(Score & (Rleds == 7'b0010000) & (RRleds == 7'b0010000)) begin 
			if(ps == 7'b1000000)
				ps = 7'b1111001; // 1
			else if(ps == 7'b1111001)
				ps = 7'b0100100; // 2 
			else if(ps == 7'b0100100)
				ps = 7'b0110000; // 3
			else if(ps == 7'b0110000)
				ps = 7'b0011001; // 4
			else if(ps == 7'b0011001)
				ps = 7'b0010010; // 5 
			else if(ps == 7'b0010010)
				ps = 7'b0000010; // 6 
			else if(ps == 7'b0000010)
				ps = 7'b1111000; // 7
			else if(ps == 7'b1111000)
				ps = 7'b0000000; // 8
			else if(ps == 7'b0000000)
				ps = 7'b0010000; // 9
			else if(ps == 7'b0010000)
				ps = 7'b1000000; // 0
			end
	end
endmodule
	
module countersFB_testbench();
	logic Score, RST, clk;
	logic [6:0] Rleds, RRleds;
	logic [6:0] leds;
	integer i;
	
	countersFB dut (.Score, .Rleds, .RRleds, .leds, .RST, .clk);
	
	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin	
									@(posedge clk); Score <= 0; Rleds <= 7'b1000000; RRleds <= 7'b1000000; RST <= 1;
									@(posedge clk); RST <= 0;
		for(i=0; i < 9; i++) begin
									@(posedge clk);
									@(posedge clk); Score <= 1;
									@(posedge clk);
									@(posedge clk); Rleds <= 7'b0010000; RRleds <= 7'b0000000;
									@(posedge clk); Rleds <= 7'b0010000; RRleds <= 7'b0000000;
									@(posedge clk); Rleds <= 7'b0010000; RRleds <= 7'b0010000;
									@(posedge clk); Rleds <= 7'b0010000; RRleds <= 7'b1000000;
									@(posedge clk); Rleds <= 7'b0010000; RRleds <= 7'b0010000;
									@(posedge clk); Rleds <= 7'b0010000; RRleds <= 7'b0010000;
									@(posedge clk); Rleds <= 7'b0010000; RRleds <= 7'b0010000;
									@(posedge clk); Rleds <= 7'b0010000; RRleds <= 7'b0010000;
									@(posedge clk); Rleds <= 7'b0010000; RRleds <= 7'b0010000;
									@(posedge clk); Rleds <= 7'b0010000; RRleds <= 7'b0010000;
									@(posedge clk); Rleds <= 7'b0010000; RRleds <= 7'b0010000;
									@(posedge clk); Rleds <= 7'b0010000; RRleds <= 7'b0010000;
									@(posedge clk); Rleds <= 7'b0010000; RRleds <= 7'b0010000;
									@(posedge clk); Score <= 0;RST <= 1;
									@(posedge clk); RST <= 0;
									
		end
		$stop; // End the simulation.
	end
endmodule 