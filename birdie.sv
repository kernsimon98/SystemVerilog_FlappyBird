module birdie(up, clk, reset, RedPixels, Over, birdState);
	input logic up, clk, reset, Over;
	output logic [15:0][15:0] RedPixels;
	output logic [15:0] birdState;

	
		birdbitTop re15 (.in(up), .up(1'b0), .dn(RedPixels[12][14]), .clk, .reset, .Over, .lightOn(RedPixels[12][15]));
		birdbit re14 (.in(up), .up(RedPixels[12][15]), .dn(RedPixels[12][13]), .clk, .reset, .Over, .lightOn(RedPixels[12][14]));
		birdbit re13 (.in(up), .up(RedPixels[12][14]), .dn(RedPixels[12][12]), .clk, .reset, .Over, .lightOn(RedPixels[12][13]));
		birdbit re12 (.in(up), .up(RedPixels[12][13]), .dn(RedPixels[12][11]), .clk, .reset, .Over, .lightOn(RedPixels[12][12]));
		birdbit re11 (.in(up), .up(RedPixels[12][12]), .dn(RedPixels[12][10]), .clk, .reset, .Over, .lightOn(RedPixels[12][11]));
		birdbit re10 (.in(up), .up(RedPixels[12][11]), .dn(RedPixels[12][9]), .clk, .reset, .Over, .lightOn(RedPixels[12][10]));
		birdbit re9 (.in(up), .up(RedPixels[12][10]), .dn(RedPixels[12][8]), .clk, .reset, .Over, .lightOn(RedPixels[12][9]));
		birdbitOn re8 (.in(up), .up(RedPixels[12][9]), .dn(RedPixels[12][7]), .clk, .reset, .Over,  .lightOn(RedPixels[12][8]));
		birdbit re7 (.in(up), .up(RedPixels[12][8]), .dn(RedPixels[12][6]), .clk, .reset, .Over,  .lightOn(RedPixels[12][7]));
		birdbit re6 (.in(up), .up(RedPixels[12][7]), .dn(RedPixels[12][5]), .clk, .reset, .Over,  .lightOn(RedPixels[12][6]));
		birdbit re5 (.in(up), .up(RedPixels[12][6]), .dn(RedPixels[12][4]), .clk, .reset, .Over,  .lightOn(RedPixels[12][5]));
		birdbit re4 (.in(up), .up(RedPixels[12][5]), .dn(RedPixels[12][3]), .clk, .reset, .Over,  .lightOn(RedPixels[12][4]));
		birdbit re3 (.in(up), .up(RedPixels[12][4]), .dn(RedPixels[12][2]), .clk, .reset, .Over,  .lightOn(RedPixels[12][3]));
		birdbit re2 (.in(up), .up(RedPixels[12][3]), .dn(RedPixels[12][1]), .clk, .reset, .Over, .lightOn(RedPixels[12][2]));
		birdbit re1 (.in(up), .up(RedPixels[12][2]), .dn(RedPixels[12][0]), .clk, .reset, .Over, .lightOn(RedPixels[12][1]));
		birdbitBot re0 (.in(up), .up(RedPixels[12][1]), .dn(1'b0), .clk, .reset, .Over, .lightOn(RedPixels[12][0]));
		assign birdState = RedPixels[12];

endmodule

module birdie_testbench();
	logic up, clk, reset, Over;
	logic [15:0][15:0] RedPixels;
	logic [15:0] birdState;
	integer i;
	
	birdie dut (.up, .clk, .reset, .RedPixels, .Over, .birdState);
	
	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin	
									@(posedge clk); reset <=1; Over <= 0; up <= 0;
									@(posedge clk); reset <=0; 
		for(i = 0; i <32; i++) begin
									@(posedge clk); 
						  		   @(posedge clk); up <= 1;
									@(posedge clk); up <= 0;
									@(posedge clk);
						  		   @(posedge clk);
									@(posedge clk); 
									@(posedge clk); 
									@(posedge clk); Over <= 1;
						  		   @(posedge clk);
									@(posedge clk);
						  		   @(posedge clk);
									@(posedge clk); reset <=1; Over <= 0; up <= 0;
									@(posedge clk); reset <=0; 
									@(posedge clk);
						  		   @(posedge clk);
									@(posedge clk);
						  		   @(posedge clk);
									@(posedge clk);
						  		   @(posedge clk);
									@(posedge clk);
						  		   @(posedge clk); up<= 1;
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
						  		   @(posedge clk); up<= 0;
									@(posedge clk);
						  		   @(posedge clk);
									@(posedge clk);
						  		   @(posedge clk);
									@(posedge clk); 
						  		   @(posedge clk);
									@(posedge clk);
						  		   @(posedge clk);
					end
		$stop; // End the simulation.
	end
endmodule 
	
	