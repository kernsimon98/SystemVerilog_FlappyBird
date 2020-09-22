module ScoreDie(birdState, pipeState, Score, Over, clk, RST);
	input logic clk, RST;
	input logic [15:0] birdState, pipeState;
	output logic Score, Over;
	integer i, j;
	
	initial begin
		Over = 1'b0;	
	end

			
	always @(posedge clk) begin
		if(RST) begin
			Over <= 1'b0;
			Score <= 1'b0;
			i <= 0;
		end
		else begin
			for(j = 0; j < 16; j++) begin
				if ((birdState[j] == 1'b1)&(pipeState[j] == 1'b1))
					Over = 1'b1;
			end
			if(~Over) begin
				if(i == 8191) begin
					i <= 0;
					Score <= 1'b1;
				end
				else begin
					i <= i + 1;
					Score <= 1'b0;
				end
			end
		end
	end
			
	
endmodule
	
module ScoreDie_testbench();
	logic clk, RST;
	logic [15:0] birdState, pipeState;
	logic Score, Over;

	ScoreDie dut (.birdState, .pipeState, .Score, .Over, .clk, .RST);

	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin	
									@(posedge clk); RST <=1;
									@(posedge clk); RST <=0; 
									@(posedge clk); birdState <=16'b0000000100000000; pipeState <=16'b1111000011111111;
						  		   @(posedge clk);
									@(posedge clk); birdState <=16'b0001000000000000; pipeState <=16'b1111000011111111;
									@(posedge clk);
						  		   @(posedge clk);
									@(posedge clk); RST <=1;
									@(posedge clk); RST <=0;
									@(posedge clk);
						  		   @(posedge clk);
									@(posedge clk); birdState <=16'b0000000100000000; pipeState <=16'b1111000011111111;
						  		   @(posedge clk);
									@(posedge clk);
						  		   @(posedge clk);
									@(posedge clk);
						  		   @(posedge clk);
									@(posedge clk);
						  		   @(posedge clk);
									@(posedge clk);
						  		   @(posedge clk);
									@(posedge clk);
						  		   @(posedge clk);
									@(posedge clk);
						  		   @(posedge clk);
									@(posedge clk);
						  		   @(posedge clk);
									@(posedge clk);
						  		   @(posedge clk);
									@(posedge clk);
						  		   @(posedge clk);
									@(posedge clk);
						  		   @(posedge clk);
									@(posedge clk);
						  		   @(posedge clk);
									@(posedge clk);
						  		   @(posedge clk);
									@(posedge clk);
						  		   @(posedge clk);
									@(posedge clk);
						  		   @(posedge clk);
									@(posedge clk);
						  		   @(posedge clk);
									@(posedge clk);
						  		   @(posedge clk);
									
		$stop; // End the simulation.
	end
endmodule 
