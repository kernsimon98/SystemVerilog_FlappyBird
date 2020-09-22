module winner(clk, reset, LeftEnd, RightEnd, L, R, win);
	input logic clk, reset, LeftEnd, RightEnd, L, R;
	output logic [6:0] win;
	enum{A, B, C} ps, ns;
	
	always_comb begin
		case(ps)
			A: if (LeftEnd & L & (~R)) 
					ns = B; 
				else if (RightEnd & R & (~L)) 
					ns = C;
				else ns = A;
			B: ns = B;
			C: ns = C;
		endcase
		
		if (ps == C)
			win = 7'b1111001;
		else if (ps == B)
			win = 7'b0100100;
		else
			win = 7'b1111111;
	end
				
	always_ff @(posedge clk) begin
		if(reset)
			ps <= A;
		else 
			ps = ns;
	end
		
	
endmodule
			
module winner_testbench();
	logic clk, reset, LeftEnd, RightEnd, L, R;
	logic [6:0] win;
	
	winner dut (.clk, .reset, .LeftEnd, .RightEnd, .L, .R, .win);
	
	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
																					@(posedge clk);
		reset <= 1; L <= 0; R <= 0; LeftEnd <= 0; RightEnd <= 0; @(posedge clk);
		reset <= 0;   											 				@(posedge clk);
																					@(posedge clk);
												LeftEnd <= 1;					@(posedge clk);
																					@(posedge clk);
																					@(posedge clk);
																					@(posedge clk);
						L <= 1; R <= 0;  										@(posedge clk);
						L <= 0; 													@(posedge clk);
																					@(posedge clk);
																					@(posedge clk);
																					@(posedge clk);
						L <= 0; R <= 1;  										@(posedge clk);
						R <= 0; 													@(posedge clk);
																					@(posedge clk);
		reset <= 1; L <= 0; R <= 0; LeftEnd <= 0; RightEnd <= 0; @(posedge clk);
		reset <= 0;   											 				@(posedge clk);
																					@(posedge clk);
												RightEnd <= 1;					@(posedge clk);
																					@(posedge clk);
																					@(posedge clk);
																					@(posedge clk);
						R <= 1; L <= 0;  										@(posedge clk);
						R <= 0; 													@(posedge clk);
																					@(posedge clk);
																					@(posedge clk);
																					@(posedge clk);
						R <= 0; L <= 1;  										@(posedge clk);
						L <= 0; 													@(posedge clk);
																					@(posedge clk);
					

		$stop; // End the simulation.
	end


endmodule 