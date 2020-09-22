// D flip-flop w/synchronous reset
module D_FF (clk,q, d, reset); 
	output logic q;
	input logic d, reset, clk;
	
	always_ff @(posedge clk) begin // Hold val until clock edge
		if (reset)
			q <= 0; // On reset, set to 0
		else
			q <= d; // Otherwise out = d
	end
	
endmodule 

module D_FF_testbench();
	logic clk, reset, d;
	logic q;

	D_FF dut (clk, q, d, reset);

	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
									@(posedge clk);
		reset <= 1;   d <= 0;@(posedge clk);
		reset <= 0;   			@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
						d <= 1;  @(posedge clk);
						d <= 0;  @(posedge clk);
						d <= 1;  @(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
		reset <= 1;          @(posedge clk);
		reset <= 0; d <= 1; 	@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
						d <= 1;  @(posedge clk);
						d <= 0;  @(posedge clk);
						d <= 1;  @(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
						d <= 0;  @(posedge clk);
									@(posedge clk);
		$stop; // End the simulation.
	end
endmodule 