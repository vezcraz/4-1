//RegisterFile.v

//D flip-flop implementation
module D_ff( input clk, input reset, input regWrite, input decOut1b , 
    input d, output reg q);
    always @ (negedge clk)
    begin
    if(reset==1)
        q=0;
    else
        if(regWrite == 1 && decOut1b==1)
        begin
            q=d;
        end
    end
endmodule

//32 bit register
module register32bit(input clk, input reset, input regWrite, 
    input decoderOut1bit, input[31:0] writeData, output[31:0] regOut);
//A N-bit register consists of N D flip-flops, each storing a bit of data.
//In this case, there will be 32 instances of D_ff, each taking writeData[0]...[31] as the d input and regOut[0]...[31] as the q output
//WRITE CODE HERE
D_ff ff0(clk, reset, regWrite, decoderOut1bit, writeData[0],regOut[0]);
D_ff ff1(clk, reset, regWrite, decoderOut1bit, writeData[1],regOut[1]);
D_ff ff2(clk, reset, regWrite, decoderOut1bit, writeData[2],regOut[2]);
D_ff ff3(clk, reset, regWrite, decoderOut1bit, writeData[3],regOut[3]);
D_ff ff4(clk, reset, regWrite, decoderOut1bit, writeData[4],regOut[4]);
D_ff ff5(clk, reset, regWrite, decoderOut1bit, writeData[5],regOut[5]);
D_ff ff6(clk, reset, regWrite, decoderOut1bit, writeData[6],regOut[6]);
D_ff ff7(clk, reset, regWrite, decoderOut1bit, writeData[7],regOut[7]);
D_ff ff8(clk, reset, regWrite, decoderOut1bit, writeData[8],regOut[8]);
D_ff ff9(clk, reset, regWrite, decoderOut1bit, writeData[9],regOut[9]);
D_ff ff10(clk, reset, regWrite, decoderOut1bit, writeData[10],regOut[10]);
D_ff ff11(clk, reset, regWrite, decoderOut1bit, writeData[11],regOut[11]);
D_ff ff12(clk, reset, regWrite, decoderOut1bit, writeData[12],regOut[12]);
D_ff ff13(clk, reset, regWrite, decoderOut1bit, writeData[13],regOut[13]);
D_ff ff14(clk, reset, regWrite, decoderOut1bit, writeData[14],regOut[14]);
D_ff ff15(clk, reset, regWrite, decoderOut1bit, writeData[15],regOut[15]);
D_ff ff16(clk, reset, regWrite, decoderOut1bit, writeData[16],regOut[16]);
D_ff ff17(clk, reset, regWrite, decoderOut1bit, writeData[17],regOut[17]);
D_ff ff18(clk, reset, regWrite, decoderOut1bit, writeData[18],regOut[18]);
D_ff ff19(clk, reset, regWrite, decoderOut1bit, writeData[19],regOut[19]);
D_ff ff20(clk, reset, regWrite, decoderOut1bit, writeData[20],regOut[20]);
D_ff ff21(clk, reset, regWrite, decoderOut1bit, writeData[21],regOut[21]);
D_ff ff22(clk, reset, regWrite, decoderOut1bit, writeData[22],regOut[22]);
D_ff ff23(clk, reset, regWrite, decoderOut1bit, writeData[23],regOut[23]);
D_ff ff24(clk, reset, regWrite, decoderOut1bit, writeData[24],regOut[24]);
D_ff ff25(clk, reset, regWrite, decoderOut1bit, writeData[25],regOut[25]);
D_ff ff26(clk, reset, regWrite, decoderOut1bit, writeData[26],regOut[26]);
D_ff ff27(clk, reset, regWrite, decoderOut1bit, writeData[27],regOut[27]);
D_ff ff28(clk, reset, regWrite, decoderOut1bit, writeData[28],regOut[28]);
D_ff ff29(clk, reset, regWrite, decoderOut1bit, writeData[29],regOut[29]);
D_ff ff30(clk, reset, regWrite, decoderOut1bit, writeData[30],regOut[30]);
D_ff ff31(clk, reset, regWrite, decoderOut1bit, writeData[31],regOut[31]);

endmodule

//Active high decoder
module decoder_5to32(input[4:0] in, output reg[31:0] decOut);
//WRITE CODE HERE
    always@(in)
    begin
        decOut = 32'b00000000000000000000000000000000;
        decOut[in]=1;
    end


endmodule

// select 0 = in0 1 = in1
module mux2to1_5bit(input [4:0] in0, input [4:0] in1, input select, 
    output reg [4:0] muxOut);
  //WRITE CODE HERE
	always@(in0 or in1 or select)
    begin
        muxOut = select?in1:in0;
    end


endmodule

module mux32to1_32bit(input[31:0] in0, input[31:0] in1, input[31:0] in2, input[31:0] in3, input[31:0] in4, input[31:0] in5, input[31:0] in6, input[31:0] in7,
    input[31:0] in8, input[31:0] in9, input[31:0] in10, input[31:0] in11, input[31:0] in12, input[31:0] in13, input[31:0] in14, input[31:0] in15,
    input[31:0] in16, input[31:0] in17, input[31:0] in18, input[31:0] in19, input[31:0] in20, input[31:0] in21, input[31:0] in22, input[31:0] in23,
    input[31:0] in24, input[31:0] in25, input[31:0] in26, input[31:0] in27, input[31:0] in28, input[31:0] in29, input[31:0] in30, input[31:0] in31,input[4:0] select,output reg[31:0] muxOut);
   //WRITE CODE HERE
	always@(*)
    begin
    if(select==0) muxOut = in0;
    else if(select==1) muxOut = in1;
    else if(select==2) muxOut = in2;
    else if(select==3) muxOut = in3;
    else if(select==4) muxOut = in4;
    else if(select==5) muxOut = in5;
    else if(select==6) muxOut = in6;
    else if(select==7) muxOut = in7;
    else if(select==8) muxOut = in8;
    else if(select==9) muxOut = in9;
    else if(select==10) muxOut = in10;
    else if(select==11) muxOut = in11;
    else if(select==12) muxOut = in12;
    else if(select==13) muxOut = in13;
    else if(select==14) muxOut = in14;
    else if(select==15) muxOut = in15;
    else if(select==16) muxOut = in16;
    else if(select==17) muxOut = in17;
    else if(select==18) muxOut = in18;
    else if(select==19) muxOut = in19;
    else if(select==20) muxOut = in20;
    else if(select==21) muxOut = in21;
    else if(select==22) muxOut = in22;
    else if(select==23) muxOut = in23;
    else if(select==24) muxOut = in24;
    else if(select==25) muxOut = in25;
    else if(select==26) muxOut = in26;
    else if(select==27) muxOut = in27;
    else if(select==28) muxOut = in28;
    else if(select==29) muxOut = in29;
    else if(select==30) muxOut = in30;
    else if(select==31) muxOut = in31;
    end



endmodule

//register set with 32 registers
module registerSet(input clk, input reset, input regWrite, input[31:0] decoderOut, input[31:0] writeData, 
    output [31:0] outR0, output[31:0] outR1, output[31:0] outR2, output[31:0] outR3, output[31:0] outR4, output[31:0] outR5, output[31:0] outR6, output[31:0] outR7,
    output [31:0] outR8, output[31:0] outR9, output[31:0] outR10, output[31:0] outR11, output[31:0] outR12, output[31:0] outR13, output[31:0] outR14, output[31:0] outR15,
    output [31:0] outR16, output[31:0] outR17, output[31:0] outR18, output[31:0] outR19, output[31:0] outR20, output[31:0] outR21, output[31:0] outR22, output[31:0] outR23,
    output [31:0] outR24, output[31:0] outR25, output[31:0] outR26, output[31:0] outR27, output[31:0] outR28, output[31:0] outR29, output[31:0] outR30, output[31:0] outR31);
    //WRITE CODE HERE
    register32bit r0(clk, reset, regWrite, decoderOut[0],writeData,outR0 );
register32bit r1(clk, reset, regWrite, decoderOut[1],writeData,outR1 );
register32bit r2(clk, reset, regWrite, decoderOut[2],writeData,outR2 );
register32bit r3(clk, reset, regWrite, decoderOut[3],writeData,outR3 );
register32bit r4(clk, reset, regWrite, decoderOut[4],writeData,outR4 );
register32bit r5(clk, reset, regWrite, decoderOut[5],writeData,outR5 );
register32bit r6(clk, reset, regWrite, decoderOut[6],writeData,outR6 );
register32bit r7(clk, reset, regWrite, decoderOut[7],writeData,outR7 );
register32bit r8(clk, reset, regWrite, decoderOut[8],writeData,outR8 );
register32bit r9(clk, reset, regWrite, decoderOut[9],writeData,outR9 );
register32bit r10(clk, reset, regWrite, decoderOut[10],writeData,outR10 );
register32bit r11(clk, reset, regWrite, decoderOut[11],writeData,outR11 );
register32bit r12(clk, reset, regWrite, decoderOut[12],writeData,outR12 );
register32bit r13(clk, reset, regWrite, decoderOut[13],writeData,outR13 );
register32bit r14(clk, reset, regWrite, decoderOut[14],writeData,outR14 );
register32bit r15(clk, reset, regWrite, decoderOut[15],writeData,outR15 );
register32bit r16(clk, reset, regWrite, decoderOut[16],writeData,outR16 );
register32bit r17(clk, reset, regWrite, decoderOut[17],writeData,outR17 );
register32bit r18(clk, reset, regWrite, decoderOut[18],writeData,outR18 );
register32bit r19(clk, reset, regWrite, decoderOut[19],writeData,outR19 );
register32bit r20(clk, reset, regWrite, decoderOut[20],writeData,outR20 );
register32bit r21(clk, reset, regWrite, decoderOut[21],writeData,outR21 );
register32bit r22(clk, reset, regWrite, decoderOut[22],writeData,outR22 );
register32bit r23(clk, reset, regWrite, decoderOut[23],writeData,outR23 );
register32bit r24(clk, reset, regWrite, decoderOut[24],writeData,outR24 );
register32bit r25(clk, reset, regWrite, decoderOut[25],writeData,outR25 );
register32bit r26(clk, reset, regWrite, decoderOut[26],writeData,outR26 );
register32bit r27(clk, reset, regWrite, decoderOut[27],writeData,outR27 );
register32bit r28(clk, reset, regWrite, decoderOut[28],writeData,outR28 );
register32bit r29(clk, reset, regWrite, decoderOut[29],writeData,outR29 );
register32bit r30(clk, reset, regWrite, decoderOut[30],writeData,outR30 );
register32bit r31(clk, reset, regWrite, decoderOut[31],writeData,outR31 );
    



endmodule

module registerFile(input clk, input reset, input regWrite, input[4:0] rs, input[4:0] rt, input[4:0] rd0, input[4:0] rd1, input[31:0] writeData, input select, output[31:0] regRs, output[31:0] regRt);
    //WRITE CODE HERE
wire [4:0] muxToDec;
wire [31:0] decOut;
wire [31:0] out0, out1, out2, out3, out4, out5, out6, out7, out8, out9, out10, out11, out12, out13, out14, out15, out16, out17, out18, out19, out20, out21, out22, out23, out24, out25, out26, out27, out28, out29, out30, out31;
mux2to1_5bit mToD(rd0,rd1, select,muxToDec);
decoder_5to32 dec(muxToDec, decOut);
registerSet regSet(clk, reset, regWrite,decOut, writeData,out0, out1, out2, out3, out4, out5, out6, out7, out8, out9, out10, out11, out12, out13, out14, out15, out16, out17, out18, out19, out20, out21, out22, out23, out24, out25, out26, out27, out28, out29, out30, out31);
mux32to1_32bit m1(out0, out1, out2, out3, out4, out5, out6, out7, out8, out9, out10, out11, out12, out13, out14, out15, out16, out17, out18, out19, out20, out21, out22, out23, out24, out25, out26, out27, out28, out29, out30, out31, rs,regRs);
mux32to1_32bit m2(out0, out1, out2, out3, out4, out5, out6, out7, out8, out9, out10, out11, out12, out13, out14, out15, out16, out17, out18, out19, out20, out21, out22, out23, out24, out25, out26, out27, out28, out29, out30, out31, rt,regRt);


endmodule


module testbench();
//inputs
    reg clk,reset,regWrite,select;
    reg [4:0] rs,rt,rd1,rd0;
    reg [31:0] writeData;
//outputs
    wire [31:0] outR0;
    wire [31:0] outR1;
//instantiate module
    registerFile uut(clk,reset,regWrite,rs,rt,rd0,rd1,writeData,select,outR0,outR1);

always begin #5 clk=~clk; end
    initial
    begin 
        $dumpfile("yourID_Lab2.vcd"); //replace yourID with your BITS ID here
        $dumpvars(0,testbench);
        clk=0; reset=1; rs=5'd0; rt=5'd1; rd1=5'd0; rd0=5'd2; //reset is active high, so outR0 and outR1 will be 0
        #5 reset=0; select=1; regWrite=1; rd1=5'd1; writeData=32'd1; //1 is written to register 1, since regWrite is active and rd1 is selected
        #10 rd1=5'd3; writeData=32'd3; //3 is written to register 3
        #10 rd1=5'd10; writeData=32'd10; rs=5'd1; rt=5'd3; //10 is written to register 10, outR0 is 1 and outR1 is 3 (values of reg1 and reg3)
        #10 rd1=5'd27; writeData=32'd27; rs=5'd0; rt=5'd10; //27 is written to register 27, outR0 is 0 and outR1 is 10
        #10 select=0; writeData=32'd21; //21 is written to register 2 since select now selects rd0
        #10 rd0=5'd4; writeData=32'd4; //4 is written to register 4
        #10 rd0=5'd16; writeData=32'd16; //16 is written to register 16
        #10 regWrite=0; rs=5'd0; rt=5'd1; //regWrite is 0, no more values will be written. outR0 is 0 and outR1 is 1
        #10 rs=5'd3;rt=5'd2; //outR0 is 3 and outR1 is 21
        #10 rs=5'd10;rt=5'd4; //outR0 is 10 and outR1 is 4
        #10 rs=5'd27;rt=5'd16; //outR0 is 27 and outR1 is 16
        #10 $finish;
    end
endmodule 