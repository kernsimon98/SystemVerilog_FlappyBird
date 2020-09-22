// Top-level module that defines the I/Os for the DE-1 SoC board
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, SW, LEDR, GPIO_1, CLOCK_50);
    output logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	 output logic [9:0]  LEDR;
    input  logic [3:0]  KEY;
    input  logic [9:0]  SW;
    output logic [35:0] GPIO_1;
    input logic CLOCK_50;

	 // Turn off HEX displays
    assign HEX5 = '1;
    assign HEX4 = '1;
	 assign HEX3 = '1;
	 
	 
	 /* Set up system base clock to 1526 Hz (50 MHz / 2**(14+1))
	    ===========================================================*/
	 logic [31:0] clk;
	 logic SYSTEM_CLOCK;
	 
	 
	 clock_divider divider (.clock(CLOCK_50), .divided_clocks(clk));
	 
	 assign SYSTEM_CLOCK = clk[14]; // 1526 Hz clock signal	 
	 
	 /* If you notice flickering, set SYSTEM_CLOCK faster.
	    However, this may reduce the brightness of the LED board. */
	
	 
	 /* Set up LED board driver
	    ================================================================== */
	 logic [15:0][15:0]RedPixels; // 16 x 16 array representing red LEDs
    logic [15:0][15:0]GrnPixels; // 16 x 16 array representing green LEDs
	 logic RST, reset, Score, Over;                   // reset - toggle this on startup
	 logic inp;
	 logic [15:0] pipeState, birdState;
	 
	 assign RST = SW[0];
	 /* Standard LED Driver instantiation - set once and 'forget it'. 
	    See LEDDriver.sv for more info. Do not modify unless you know what you are doing! */
	 LEDDriver Driver (.CLK(SYSTEM_CLOCK), .RST(RST), .EnableCount(1'b1), .RedPixels(RedPixels), .GrnPixels(GrnPixels), .GPIO_1(GPIO_1));
	 
	 // LAB 8: Flappy Bird
	 UserIn in (.clk(SYSTEM_CLOCK), .reset(RST), .in(~KEY[0]), .out(inp));
	
	
	 
	 birdie ply (.up(inp), .clk(clk[21]), .reset(RST), .RedPixels(RedPixels), .Over, .birdState);
	 GrnPipe re (.RST(RST), .GrnPixels(GrnPixels), .pipeState, .Over, .clk(clk[23]));
		
	 ScoreDie tr (.birdState, .pipeState, .Score, .Over, .clk(SYSTEM_CLOCK), .RST);
	 countersFB h0 (.Score, .Rleds(7'b0010000), .RRleds(7'b0010000), .leds(HEX0), .RST, .clk(SYSTEM_CLOCK));
	 countersFB h1 (.Score, .Rleds(HEX0), .RRleds(7'b0010000), .leds(HEX1), .RST, .clk(SYSTEM_CLOCK));
	 countersFB h2 (.Score, .Rleds(HEX1), .RRleds(HEX0), .leds(HEX2), .RST, .clk(SYSTEM_CLOCK));
		
endmodule

module DE1_SoC_testbench();
    logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	 logic [9:0]  LEDR;
    logic [3:0]  KEY;
    logic [9:0]  SW;
    logic [35:0] GPIO_1;
	 logic Clk;	
	 
	 DE1_SoC dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .SW, .LEDR, .GPIO_1, .CLOCK_50(Clk));
	 		// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		Clk <= 0;
		forever #(CLOCK_PERIOD/2) Clk <= ~Clk;
	end

	// Set up the inputs to the design. Each line is a clock cycle.
	integer i;
	initial begin
					SW[0] <= 1;  KEY[0]<=1;					@(posedge Clk);
					SW[0] <= 0;  			   		   	@(posedge Clk);
					for(i=0; i<10000000;i++) begin
																@(posedge Clk); KEY[0] <= 1'b0;
																@(posedge Clk);
																@(posedge Clk);
																@(posedge Clk); 
																@(posedge Clk);
																@(posedge Clk);
																@(posedge Clk);
																@(posedge Clk); 
																@(posedge Clk); 
																@(posedge Clk);
																@(posedge Clk); 
																@(posedge Clk); 
																@(posedge Clk); 
																@(posedge Clk);
																@(posedge Clk); KEY[0] <= 1'b1;
																@(posedge Clk); 
																@(posedge Clk);		
																@(posedge Clk); 
																@(posedge Clk);
																@(posedge Clk);
																@(posedge Clk);
																@(posedge Clk); 
																@(posedge Clk);
															   @(posedge Clk); KEY[0] <= 1'b0;
																@(posedge Clk);
																@(posedge Clk);
																@(posedge Clk); 
																@(posedge Clk);
																@(posedge Clk);
																@(posedge Clk);
																@(posedge Clk); 
																@(posedge Clk); 
																@(posedge Clk);
															   @(posedge Clk);
																@(posedge Clk);
																@(posedge Clk); 
																@(posedge Clk);
																@(posedge Clk);
																@(posedge Clk);
																@(posedge Clk); 
																@(posedge Clk); 
																@(posedge Clk);
																@(posedge Clk); 
																@(posedge Clk);
																@(posedge Clk); KEY[0] <= 1'b1;
																@(posedge Clk); 
																@(posedge Clk);		
																@(posedge Clk); 
																@(posedge Clk);
																@(posedge Clk);
																@(posedge Clk);
																@(posedge Clk); 
																@(posedge Clk);
								KEY[0] <= 1'b0;			@(posedge Clk);
																@(posedge Clk);
																@(posedge Clk);
																@(posedge Clk); 
																@(posedge Clk); 
																@(posedge Clk);
																@(posedge Clk); 
																@(posedge Clk); 
																@(posedge Clk);
																@(posedge Clk);
																@(posedge Clk);
																@(posedge Clk); 
																@(posedge Clk); 
																@(posedge Clk);
																@(posedge Clk); 
																@(posedge Clk);
																@(posedge Clk); KEY[0] <= 1'b1;
																@(posedge Clk); 
																@(posedge Clk);		
																@(posedge Clk); 
																@(posedge Clk);
																@(posedge Clk);
																@(posedge Clk);
																@(posedge Clk); 
																@(posedge Clk); 
																@(posedge Clk); 
																@(posedge Clk);		
																@(posedge Clk); 
																@(posedge Clk);
																@(posedge Clk);
																@(posedge Clk);
																@(posedge Clk); 
																@(posedge Clk); 
																@(posedge Clk); 
																@(posedge Clk);		
																@(posedge Clk); 
																@(posedge Clk);
																@(posedge Clk);
																@(posedge Clk);
																@(posedge Clk); 
																@(posedge Clk); 
								KEY[0] <= 1'b0;			@(posedge Clk);
																@(posedge Clk);
																@(posedge Clk);
																@(posedge Clk); 
																@(posedge Clk); 
																@(posedge Clk);
																@(posedge Clk); 
																@(posedge Clk); 
																@(posedge Clk);
																@(posedge Clk);
																@(posedge Clk);
																@(posedge Clk); 
																@(posedge Clk); 
																@(posedge Clk);
																@(posedge Clk); 
																@(posedge Clk); 
																@(posedge Clk); 
																@(posedge Clk); 
																@(posedge Clk);
																@(posedge Clk); 
																@(posedge Clk);
																@(posedge Clk); 
																@(posedge Clk); 
																@(posedge Clk);
																@(posedge Clk); 
																@(posedge Clk);
							KEY[0] <= 1'b1;				@(posedge Clk); 
																@(posedge Clk); 
																@(posedge Clk);
																@(posedge Clk); 
																@(posedge Clk); 
																
					end
					
		$stop; // End the simulation.
	end
endmodule