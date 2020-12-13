//ShifterAndALU.v

// select 0 = in0 1 = in1
module mux2to1_3bit(input [2:0] in0, input [2:0] in1, input select, output reg [2:0] muxOut);
  //WRITE CODE HERE
  always@(select or in1 or in0)
  	begin
  		muxOut = select?in1:in0;
  	end
endmodule

// select 0 = in0 1 = in1
module mux2to1_8bit(input [7:0] in0, input [7:0] in1, input select, output reg [7:0] muxOut);
   //WRITE CODE HERE
   always@(in0 or in1 or select)
   	begin
   		muxOut = select?in1:in0;
   	end

endmodule


module mux8to1_1bit(input in0, input in1, input in2, input in3, input in4, input in5, input in6, input in7, input[2:0] select,output reg muxOut);
   //WRITE CODE HERE
   always@(in0 or in1 or in2 or in3 or in4 or in5 or in6 or in7 or select)
   	begin
   		if(select == 0)
   			muxOut = in0;   	
		else if(select==1)
			muxOut =in1;  	
		else if(select==2)
			muxOut =in2;  	
		else if(select==3)
			muxOut =in3;  	
		else if(select==4)
			muxOut =in4;  	
		else if(select==5)
			muxOut =in5;  	
		else if(select==6)
			muxOut =in6;  	
		else if(select==7)
			muxOut =in7;  	
   	end
endmodule

module barrelshifter(input[2:0] shiftAmt, input[7:0] b, input[2:0] oper, output[7:0] shiftOut);
	   //WRITE CODE HERE
	   always@(shiftAmt, b, oper, shiftOut)
	   	begin
	   		
	   	end

endmodule

// Alu operations are: 00 for alu1, 01 for add, 10 for sub(alu1-alu2) , 11 for AND, 100 for OR and 101 for NOT(alu1)
module alu(input [7:0] aluIn1, input [7:0] aluIn2, input [2:0]aluOp, output reg [7:0] aluOut);
       //WRITE CODE HERE
         	always @(aluOp or aluIn1 or aluIn2)
    	begin
	        case (aluOp)
	        	0 : aluOut = aluIn1;
	            1 : aluOut = aluIn1 + aluIn2;
	        	2 : aluOut = aluIn1 - aluIn2; 
	        	3 : aluOut = aluIn1 & aluIn2;
	        	4 : aluOut = aluIn1 | aluIn2;
	        	5 : aluOut = ~aluIn1; 

        endcase 
    end

endmodule


module shifterAndALU(input [7:0]inp1, input [7:0] inp2, input [2:0]shiftlmm, 
	input selShiftAmt, input [2:0]oper, input selOut, output [7:0] out);
	   //WRITE CODE HERE


endmodule

//TestBench ALU
module testbenchALU();
	// Input
	reg [7:0] inp1, inp2;
	reg [2:0] aluOp;
	reg [2:0] shiftlmm;
	reg selShiftAmt, selOut;
	// Output
	wire [7:0] aluOut;

	shifterAndALU shifterAndALU_Test (inp1, inp2, shiftlmm, selShiftAmt, aluOp, selOut, aluOut);

	initial
		begin
			$dumpfile("testALU.vcd");
     	$dumpvars(0,testbenchALU);
			inp1 = 8'd80; //80 in binary is 1010000
			inp2 = 8'd20; //20 in binary is 10100   
			shiftlmm = 3'b010; 
			
			aluOp=3'd0; selOut = 1'b0;// normal output = 80

			#10 aluOp = 3'd0; selOut = 1'b1; selShiftAmt = 1'b1; //No shift output = 80

			#10 aluOp=3'd1; selOut = 1'b0;// normal add	output => 20 + 80 = 100

			#10 aluOp = 3'd1; selOut = 1'b1; selShiftAmt = 1'b1; // arithmetic shift right of 80 by 2 places = 20

			#10 aluOp=3'd2; selOut = 1'b0; // normal sub output => 80 - 20 = 60

			#10 aluOp = 3'd2; selOut = 1'b1; selShiftAmt = 1'b0; // logical shift right of 80 by 4 places = 0

			#10 aluOp=3'd3; selOut = 1'b0;// normal and output => 80 & 20 = 16

			#10 aluOp = 3'd3; selOut = 1'b1; selShiftAmt = 1'b0; // Circular Shift Right of 80 by 4 places = 5

			#10 aluOp=3'd4; selOut = 1'b0;// normal or output => 80 | 20 = 84

			#10 aluOp = 3'd4; selOut = 1'b1; selShiftAmt = 1'b1; // Logical Shift Left of 80 by 2 bits = 64

			#10 aluOp=3'd5; selOut = 1'b0; // normal not of 80 = 175

			#10 aluOp = 3'd5; selOut = 1'b1; selShiftAmt = 1'b0; // Circular left shift of 80 by 4 bits = 5

			#10 inp1=8'd15; inp2=8'd26; aluOp=3'd2; selOut = 1'b0;//sub overflow 
			// (15 - 26) = -11 and its a 8 bit number so, 256-11 = 245 output => 245 (since it is unsigned decimal)

			#10 inp1=8'd150; inp2=8'd150; aluOp=3'd1; selOut = 1'b0;// add overflow
			//(150+150) = 300 and its a 8 bit number so, 300-256 = 44 output=> 44.

			#10 inp1=8'b0000_0000; aluOp=3'd5; selOut = 1'b0;//not overflow
			// not(0) = all 1. Since its a 8 bit number output=>255

			#10 $finish;
		end

endmodule
