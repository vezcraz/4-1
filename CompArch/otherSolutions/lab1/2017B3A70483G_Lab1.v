//ShifterAndALU.v

// select 0 = in0 1 = in1
module mux2to1_3bit(input [2:0] in0, input [2:0] in1, input select, output reg [2:0] muxOut);
  //WRITE CODE HERE

  always@(select or in1 or in0)
begin
   muxOut = (select)? in1 : in0;
end

endmodule

// select 0 = in0 1 = in1
module mux2to1_8bit(input [7:0] in0, input [7:0] in1, input select, output reg [7:0] muxOut);
   //WRITE CODE HERE

  always@(select or in1 or in0)
begin
   muxOut = (select)? in1 : in0;
end

endmodule


module mux8to1_1bit(input in0, input in1, input in2, input in3, input in4, input in5, input in6, input in7, input[2:0] select,output reg muxOut);
   //WRITE CODE HERE

   always @(in0 or in1 or in2 or in3 or in4 or in5 or in6 or in7 or select) begin
   	
   	case(select)
   		0: muxOut = in0;
   		1: muxOut = in1;
   		2: muxOut = in2;
   		3: muxOut = in3;
   		4: muxOut = in4;
   		5: muxOut = in5;
   		6: muxOut = in6;
   		7: muxOut = in7;
   	endcase
   end
   	
endmodule

module barrelshifter(input[2:0] shiftAmt, input[7:0] b, input[2:0] oper, output[7:0] shftOutp);

	wire [2:0] select0;
	wire [2:0] select1;
	wire [2:0] select2;
	wire s0 ,s1 ,s2 ,s3 ,s4 ,s5 ,s6 ,s7 ,r0 ,r1 ,r2 ,r3 ,r4 ,r5 ,r6 ,r7;
	mux2to1_3bit mxer1(3'b000,  oper, shiftAmt[0], select0);
	mux8to1_1bit muxer1(b[0], b[1], b[1], b[1], 1'b0, b[7], 1'bx, 1'bx, select0, s0);
	mux8to1_1bit muxer2(b[1], b[2], b[2], b[2], b[0], b[0], 1'bx, 1'bx, select0, s1);
	mux8to1_1bit muxer3(b[2], b[3], b[3], b[3], b[1], b[1], 1'bx, 1'bx, select0, s2);
	mux8to1_1bit muxer4(b[3], b[4], b[4], b[4], b[2], b[2], 1'bx, 1'bx, select0, s3);
	mux8to1_1bit muxer5(b[4], b[5], b[5], b[5], b[3], b[3], 1'bx, 1'bx, select0, s4);
	mux8to1_1bit muxer6(b[5], b[6], b[6], b[6], b[4], b[4], 1'bx, 1'bx, select0, s5);
	mux8to1_1bit muxer7(b[6], b[7], b[7], b[7], b[5], b[5], 1'bx, 1'bx, select0, s6);
	mux8to1_1bit muxer8(b[7], b[7], 1'b0, b[0], b[6], b[6], 1'bx, 1'bx, select0, s7);
	mux2to1_3bit mxer2(3'b000,  oper, shiftAmt[1], select1);
	mux8to1_1bit muxer9(s0, s2, s2, s2, 1'b0, s6, 1'bx, 1'bx, select1, r0);
	mux8to1_1bit muxer10(s1, s3, s3, s3, 1'b0, s7, 1'bx, 1'bx, select1, r1);
	mux8to1_1bit muxer11(s2, s4, s4, s4, s0, s0, 1'bx, 1'bx, select1, r2);
	mux8to1_1bit muxer12(s3, s5, s5, s5, s1, s1, 1'bx, 1'bx, select1, r3);
	mux8to1_1bit muxer13(s4, s6, s6, s6, s2, s2, 1'bx, 1'bx, select1, r4);
	mux8to1_1bit mu14(s5, s7, s7, s7, s3, s3, 1'bx, 1'bx, select1, r5);
	mux8to1_1bit mu15(s6, s7, 1'b0, s0, s4, s4, 1'bx, 1'bx, select1, r6);
	mux8to1_1bit mu16(s7, s7, 1'b0, s1, s5, s5, 1'bx, 1'bx, select1, r7);	
	mux2to1_3bit mxer3(3'b000,  oper, shiftAmt[2], select2);
	mux8to1_1bit muxer17(r0, r4, r4, r4, 1'b0, r4, 1'bx, 1'bx, select2, shftOutp[0]);
	mux8to1_1bit muxer18(r1, r5, r5, r5, 1'b0, r5, 1'bx, 1'bx, select2, shftOutp[1]);
	mux8to1_1bit muxer19(r2, r6, r6, r6, 1'b0, r6, 1'bx, 1'bx, select2, shftOutp[2]);
	mux8to1_1bit muxer20(r3, r7, r7, r7, 1'b0, r7, 1'bx, 1'bx, select2, shftOutp[3]);
	mux8to1_1bit muxer21(r4, r7, 1'b0, r0, r0, r0, 1'bx, 1'bx, select2, shftOutp[4]);
	mux8to1_1bit muxer22(r5, r7, 1'b0, r1, r1, r1, 1'bx, 1'bx, select2, shftOutp[5]);
	mux8to1_1bit muxer23(r6, r7, 1'b0, r2, r2, r2, 1'bx, 1'bx, select2, shftOutp[6]);
	mux8to1_1bit muxer24(r7, r7, 1'b0, r3, r3, r3, 1'bx, 1'bx, select2, shftOutp[7]);

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


module shifterAndALU(input [7:0]inp1, input [7:0] inp2, input [2:0]shiftlmm, input selShiftAmt, input [2:0]oper, input selOut, output [7:0] out);
	   //WRITE CODE HERE

	wire [2:0] shftamt;
	wire [7:0] shftOutp;
	wire [7:0] output_alu;
	mux2to1_3bit select1(inp2[2:0], shiftlmm, selShiftAmt, shftamt);
	barrelshifter shiftoutput(shftamt, inp1, oper, shftOutp);
	alu aluoutput(inp1, inp2, oper, output_alu);
	mux2to1_8bit finaloutput(output_alu, shftOutp, selOut, out);

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
