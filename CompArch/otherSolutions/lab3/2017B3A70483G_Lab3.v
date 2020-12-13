//DFF
module D_ff( input clk, input reset, input regWrite, input decOut1b , input d, output reg q);
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

module D_ff_IM(input clk, input reset, input d, output reg q);
	always@(reset or posedge clk)
	if(reset)
		q=d;
endmodule

module register_IM(input clk, input reset, input [7:0] d_in, output [7:0] q_out);
    // register_IM is an 8-bit register
	D_ff_IM dflipIm0 (clk, reset, d_in[0], q_out[0]);
	D_ff_IM dflipIm1 (clk, reset, d_in[1], q_out[1]);
	D_ff_IM dflipIm2 (clk, reset, d_in[2], q_out[2]);
	D_ff_IM dflipIm3 (clk, reset, d_in[3], q_out[3]);
	D_ff_IM dflipIm4 (clk, reset, d_in[4], q_out[4]);
	D_ff_IM dflipIm5 (clk, reset, d_in[5], q_out[5]);
	D_ff_IM dflipIm6 (clk, reset, d_in[6], q_out[6]);
	D_ff_IM dflipIm7 (clk, reset, d_in[7], q_out[7]);
endmodule


module mux128to1_IM(input [7:0] in0,   input [7:0] in1,   input [7:0] in2,   input [7:0] in3,
                    input [7:0] in4,   input [7:0] in5,   input [7:0] in6,   input [7:0] in7,
                    input [7:0] in8,   input [7:0] in9,   input [7:0] in10,  input [7:0] in11,
                    input [7:0] in12,  input [7:0] in13,  input [7:0] in14,  input [7:0] in15,
                    input [7:0] in16,  input [7:0] in17,  input [7:0] in18,  input [7:0] in19,
                    input [7:0] in20,  input [7:0] in21,  input [7:0] in22,  input [7:0] in23,
                    input [7:0] in24,  input [7:0] in25,  input [7:0] in26,  input [7:0] in27,
                    input [7:0] in28,  input [7:0] in29,  input [7:0] in30,  input [7:0] in31,
                    input [7:0] in32,  input [7:0] in33,  input [7:0] in34,  input [7:0] in35,
                    input [7:0] in36,  input [7:0] in37,  input [7:0] in38,  input [7:0] in39,
                    input [7:0] in40,  input [7:0] in41,  input [7:0] in42,  input [7:0] in43,
                    input [7:0] in44,  input [7:0] in45,  input [7:0] in46,  input [7:0] in47,
                    input [7:0] in48,  input [7:0] in49,  input [7:0] in50,  input [7:0] in51,
                    input [7:0] in52,  input [7:0] in53,  input [7:0] in54,  input [7:0] in55,
                    input [7:0] in56,  input [7:0] in57,  input [7:0] in58,  input [7:0] in59,
                    input [7:0] in60,  input [7:0] in61,  input [7:0] in62,  input [7:0] in63,
                    input [7:0] in64,  input [7:0] in65,  input [7:0] in66,  input [7:0] in67,
                    input [7:0] in68,  input [7:0] in69,  input [7:0] in70,  input [7:0] in71,
                    input [7:0] in72,  input [7:0] in73,  input [7:0] in74,  input [7:0] in75,
                    input [7:0] in76,  input [7:0] in77,  input [7:0] in78,  input [7:0] in79,
                    input [7:0] in80,  input [7:0] in81,  input [7:0] in82,  input [7:0] in83,
                    input [7:0] in84,  input [7:0] in85,  input [7:0] in86,  input [7:0] in87,
                    input [7:0] in88,  input [7:0] in89,  input [7:0] in90,  input [7:0] in91,
                    input [7:0] in92,  input [7:0] in93,  input [7:0] in94,  input [7:0] in95,
                    input [7:0] in96,  input [7:0] in97,  input [7:0] in98,  input [7:0] in99,
                    input [7:0] in100, input [7:0] in101, input [7:0] in102, input [7:0] in103,
                    input [7:0] in104, input [7:0] in105, input [7:0] in106, input [7:0] in107,
                    input [7:0] in108, input [7:0] in109, input [7:0] in110, input [7:0] in111,
                    input [7:0] in112, input [7:0] in113, input [7:0] in114, input [7:0] in115,
                    input [7:0] in116, input [7:0] in117, input [7:0] in118, input [7:0] in119,
                    input [7:0] in120, input [7:0] in121, input [7:0] in122, input [7:0] in123,
                    input [7:0] in124, input [7:0] in125, input [7:0] in126, input [7:0] in127,
                    input [4:0] select, output reg [31:0] muxOut);
    always@(in0,   in1,   in2,   in3,   in4,   in5,   in6,   in7, 
            in8,   in9,   in10,  in11,  in12,  in13,  in14,  in15,   
            in16,  in17,  in18,  in19,  in20,  in21,  in22,  in23, 
            in24,  in25,  in26,  in27,  in28,  in29,  in30,  in31, 
            in32,  in33,  in34,  in35,  in36,  in37,  in38,  in39, 
            in40,  in41,  in42,  in43,  in44,  in45,  in46,  in47, 
            in48,  in49,  in50,  in51,  in52,  in53,  in54,  in55, 
            in56,  in57,  in58,  in59,  in60,  in61,  in62,  in63, 
            in64,  in65,  in66,  in67,  in68,  in69,  in70,  in71, 
            in72,  in73,  in74,  in75,  in76,  in77,  in78,  in79, 
            in80,  in81,  in82,  in83,  in84,  in85,  in86,  in87, 
            in88,  in89,  in90,  in91,  in92,  in93,  in94,  in95, 
            in96,  in97,  in98,  in99,  in100, in101, in102, in103,
            in104, in105, in106, in107, in108, in109, in110, in111,
            in112, in113, in114, in115, in116, in117, in118, in119,
            in120, in121, in122, in123, in124, in125, in126, in127,
            select)
	begin
        case(select)
			5'd0: muxOut = {in0,in1,in2,in3};
			5'd1: muxOut = {in4,in5,in6,in7};
			5'd2: muxOut = {in8,in9,in10,in11};
			5'd3: muxOut = {in12,in13,in14,in15};
			5'd4: muxOut = {in16,in17,in18,in19};
			5'd5: muxOut = {in20,in21,in22,in23};
			5'd6: muxOut = {in24,in25,in26,in27};
			5'd7: muxOut = {in28,in29,in30,in31};
			5'd8: muxOut = {in32,in33,in34,in35};
			5'd9: muxOut = {in36,in37,in38,in39};
			5'd10: muxOut = {in40,in41,in42,in43};
			5'd11: muxOut = {in44,in45,in46,in47};
			5'd12: muxOut = {in48,in49,in50,in51};
			5'd13: muxOut = {in52,in53,in54,in55};
			5'd14: muxOut = {in56,in57,in58,in59};
			5'd15: muxOut = {in60,in61,in62,in63};
			5'd16: muxOut = {in64,in65,in66,in67};
			5'd17: muxOut = {in68,in69,in70,in71};
			5'd18: muxOut = {in72,in73,in74,in75};
			5'd19: muxOut = {in76,in77,in78,in79};
			5'd20: muxOut = {in80,in81,in82,in83};
			5'd21: muxOut = {in84,in85,in86,in87};
			5'd22: muxOut = {in88,in89,in90,in91};
			5'd23: muxOut = {in92,in93,in94,in95};
			5'd24: muxOut = {in96,in97,in98,in99};
			5'd25: muxOut = {in100,in101,in102,in103};
			5'd26: muxOut = {in104,in105,in106,in107};
			5'd27: muxOut = {in108,in109,in110,in111};
			5'd28: muxOut = {in112,in113,in114,in115};
			5'd29: muxOut = {in116,in117,in118,in119};
			5'd30: muxOut = {in120,in121,in122,in123};
			5'd31: muxOut = {in124,in125,in126,in127};
        endcase
    end
endmodule

module IM(input clk, input reset, input [4:0] pc_5bits, output [31:0] IR);
    wire [7:0] outR0,   outR1,   outR2,   outR3,   outR4,   outR5,   outR6,   outR7,   
               outR8,   outR9,   outR10,  outR11,  outR12,  outR13,  outR14,  outR15,   
               outR16,  outR17,  outR18,  outR19,  outR20,  outR21,  outR22,  outR23, 
               outR24,  outR25,  outR26,  outR27,  outR28,  outR29,  outR30,  outR31, 
               outR32,  outR33,  outR34,  outR35,  outR36,  outR37,  outR38,  outR39, 
               outR40,  outR41,  outR42,  outR43,  outR44,  outR45,  outR46,  outR47, 
               outR48,  outR49,  outR50,  outR51,  outR52,  outR53,  outR54,  outR55, 
               outR56,  outR57,  outR58,  outR59,  outR60,  outR61,  outR62,  outR63, 
               outR64,  outR65,  outR66,  outR67,  outR68,  outR69,  outR70,  outR71, 
               outR72,  outR73,  outR74,  outR75,  outR76,  outR77,  outR78,  outR79, 
               outR80,  outR81,  outR82,  outR83,  outR84,  outR85,  outR86,  outR87, 
               outR88,  outR89,  outR90,  outR91,  outR92,  outR93,  outR94,  outR95, 
               outR96,  outR97,  outR98,  outR99,  outR100, outR101, outR102, outR103,
               outR104, outR105, outR106, outR107, outR108, outR109, outR110, outR111,
               outR112, outR113, outR114, outR115, outR116, outR117, outR118, outR119,
               outR120, outR121, outR122, outR123, outR124, outR125, outR126, outR127;

// ONLY modify the first 16 register_IM instances to have the instructions listed in the PDF, in that order
// The d_in of the register_IM instances should contain the instruction as per the instruction format provided
// Hint: MIPS uses Big-Endian addressing so please note the order of registers specified in mux128to1_IM
    register_IM regIm0   (clk, reset, 8'b00000010, outR0);  // sub $s2, $s1, $s0
    register_IM regIm1   (clk, reset, 8'b00110000, outR1);   
    register_IM regIm2   (clk, reset, 8'b10010000, outR2);   
    register_IM regIm3   (clk, reset, 8'b00100010, outR3);   
    register_IM regIm4   (clk, reset, 8'b00000001, outR4);  // add $t3, $t2, $t0
    register_IM regIm5   (clk, reset, 8'b01001000, outR5);  
    register_IM regIm6   (clk, reset, 8'b01011000, outR6);  
    register_IM regIm7   (clk, reset, 8'b00100000, outR7);   
    register_IM regIm8   (clk, reset, 8'b00000001, outR8);  // or  $s1, $t1, $t4
    register_IM regIm9   (clk, reset, 8'b00101100, outR9);   
    register_IM regIm10  (clk, reset, 8'b10001000, outR10);   
    register_IM regIm11  (clk, reset, 8'b00100101, outR11);   
    register_IM regIm12  (clk, reset, 8'b00100010, outR12); // addi $t4, $s0, 0x000D
    register_IM regIm13  (clk, reset, 8'b00001100, outR13);  
    register_IM regIm14  (clk, reset, 8'b00000000, outR14);  
    register_IM regIm15  (clk, reset, 8'b00001101, outR15); 
    register_IM regIm16  (clk, reset, 8'h00, outR16); 
    register_IM regIm17  (clk, reset, 8'h00, outR17);  
    register_IM regIm18  (clk, reset, 8'h00, outR18);  
    register_IM regIm19  (clk, reset, 8'h00, outR19); 
    register_IM regIm20  (clk, reset, 8'h00, outR20);  
    register_IM regIm21  (clk, reset, 8'h00, outR21);  
    register_IM regIm22  (clk, reset, 8'h00, outR22);  
    register_IM regIm23  (clk, reset, 8'h00, outR23); 
    register_IM regIm24  (clk, reset, 8'h00, outR24); 
    register_IM regIm25  (clk, reset, 8'h00, outR25);  
    register_IM regIm26  (clk, reset, 8'h00, outR26);  
    register_IM regIm27  (clk, reset, 8'h00, outR27); 
    register_IM regIm28  (clk, reset, 8'h00, outR28);
    register_IM regIm29  (clk, reset, 8'h00, outR29);   
    register_IM regIm30  (clk, reset, 8'h00, outR30);   
    register_IM regIm31  (clk, reset, 8'h00, outR31);  
    register_IM regIm32  (clk, reset, 8'h00, outR32);   
    register_IM regIm33  (clk, reset, 8'h00, outR33);   
    register_IM regIm34  (clk, reset, 8'h00, outR34);   
    register_IM regIm35  (clk, reset, 8'h00, outR35);  
    register_IM regIm36  (clk, reset, 8'h00, outR36);   
    register_IM regIm37  (clk, reset, 8'h00, outR37);   
    register_IM regIm38  (clk, reset, 8'h00, outR38);   
    register_IM regIm39  (clk, reset, 8'h00, outR39);  
    register_IM regIm40  (clk, reset, 8'h00, outR40);   
    register_IM regIm41  (clk, reset, 8'h00, outR41);  
    register_IM regIm42  (clk, reset, 8'h00, outR42);  
    register_IM regIm43  (clk, reset, 8'h00, outR43); 
    register_IM regIm44  (clk, reset, 8'h00, outR44);                        
    register_IM regIm45  (clk, reset, 8'h00, outR45);             
    register_IM regIm46  (clk, reset, 8'h00, outR46);             
    register_IM regIm47  (clk, reset, 8'h00, outR47); 
    register_IM regIm48  (clk, reset, 8'h00, outR48);   
    register_IM regIm49  (clk, reset, 8'h00, outR49);  
    register_IM regIm50  (clk, reset, 8'h00, outR50);  
    register_IM regIm51  (clk, reset, 8'h00, outR51); 
    register_IM regIm52  (clk, reset, 8'h00, outR52);  
    register_IM regIm53  (clk, reset, 8'h00, outR53);  
    register_IM regIm54  (clk, reset, 8'h00, outR54);  
    register_IM regIm55  (clk, reset, 8'h00, outR55);  
    register_IM regIm56  (clk, reset, 8'h00, outR56);                     
    register_IM regIm57  (clk, reset, 8'h00, outR57);             
    register_IM regIm58  (clk, reset, 8'h00, outR58);             
    register_IM regIm59  (clk, reset, 8'h00, outR59);  
    register_IM regIm60  (clk, reset, 8'h00, outR60); 
    register_IM regIm61  (clk, reset, 8'h00, outR61); 
    register_IM regIm62  (clk, reset, 8'h00, outR62); 
    register_IM regIm63  (clk, reset, 8'h00, outR63); 
    register_IM regIm64  (clk, reset, 8'h00, outR64);
    register_IM regIm65  (clk, reset, 8'h00, outR65);
    register_IM regIm66  (clk, reset, 8'h00, outR66);
    register_IM regIm67  (clk, reset, 8'h00, outR67);
    register_IM regIm68  (clk, reset, 8'h00, outR68);
    register_IM regIm69  (clk, reset, 8'h00, outR69);
    register_IM regIm70  (clk, reset, 8'h00, outR70);
    register_IM regIm71  (clk, reset, 8'h00, outR71);
    register_IM regIm72  (clk, reset, 8'h00, outR72);
    register_IM regIm73  (clk, reset, 8'h00, outR73);
    register_IM regIm74  (clk, reset, 8'h00, outR74);
    register_IM regIm75  (clk, reset, 8'h00, outR75);
    register_IM regIm76  (clk, reset, 8'h00, outR76);
    register_IM regIm77  (clk, reset, 8'h00, outR77);
    register_IM regIm78  (clk, reset, 8'h00, outR78);
    register_IM regIm79  (clk, reset, 8'h00, outR79);
    register_IM regIm80  (clk, reset, 8'h00, outR80);
    register_IM regIm81  (clk, reset, 8'h00, outR81);
    register_IM regIm82  (clk, reset, 8'h00, outR82);
    register_IM regIm83  (clk, reset, 8'h00, outR83);
    register_IM regIm84  (clk, reset, 8'h00, outR84);
    register_IM regIm85  (clk, reset, 8'h00, outR85);
    register_IM regIm86  (clk, reset, 8'h00, outR86);
    register_IM regIm87  (clk, reset, 8'h00, outR87);
    register_IM regIm88  (clk, reset, 8'h00, outR88);
    register_IM regIm89  (clk, reset, 8'h00, outR89);
    register_IM regIm90  (clk, reset, 8'h00, outR90);
    register_IM regIm91  (clk, reset, 8'h00, outR91);
    register_IM regIm92  (clk, reset, 8'h00, outR92);
    register_IM regIm93  (clk, reset, 8'h00, outR93);
    register_IM regIm94  (clk, reset, 8'h00, outR94);
    register_IM regIm95  (clk, reset, 8'h00, outR95);
    register_IM regIm96  (clk, reset, 8'h00, outR96);
    register_IM regIm97  (clk, reset, 8'h00, outR97);
    register_IM regIm98  (clk, reset, 8'h00, outR98);
    register_IM regIm99  (clk, reset, 8'h00, outR99);
    register_IM regIm100 (clk, reset, 8'h00, outR100);
    register_IM regIm101 (clk, reset, 8'h00, outR101);
    register_IM regIm102 (clk, reset, 8'h00, outR102);
    register_IM regIm103 (clk, reset, 8'h00, outR103);
    register_IM regIm104 (clk, reset, 8'h00, outR104);
    register_IM regIm105 (clk, reset, 8'h00, outR105);
    register_IM regIm106 (clk, reset, 8'h00, outR106);
    register_IM regIm107 (clk, reset, 8'h00, outR107);
    register_IM regIm108 (clk, reset, 8'h00, outR108);
    register_IM regIm109 (clk, reset, 8'h00, outR109);
    register_IM regIm110 (clk, reset, 8'h00, outR110);
    register_IM regIm111 (clk, reset, 8'h00, outR111);
    register_IM regIm112 (clk, reset, 8'h00, outR112);
    register_IM regIm113 (clk, reset, 8'h00, outR113);
    register_IM regIm114 (clk, reset, 8'h00, outR114);
    register_IM regIm115 (clk, reset, 8'h00, outR115);
    register_IM regIm116 (clk, reset, 8'h00, outR116);
    register_IM regIm117 (clk, reset, 8'h00, outR117);
    register_IM regIm118 (clk, reset, 8'h00, outR118);
    register_IM regIm119 (clk, reset, 8'h00, outR119);
    register_IM regIm120 (clk, reset, 8'h00, outR120);
    register_IM regIm121 (clk, reset, 8'h00, outR121);
    register_IM regIm122 (clk, reset, 8'h00, outR122);
    register_IM regIm123 (clk, reset, 8'h00, outR123);
    register_IM regIm124 (clk, reset, 8'h00, outR124);
    register_IM regIm125 (clk, reset, 8'h00, outR125);
    register_IM regIm126 (clk, reset, 8'h00, outR126);
    register_IM regIm127 (clk, reset, 8'h00, outR127);


    mux128to1_IM muxIM (outR0,   outR1,   outR2,   outR3,   outR4,   outR5,   outR6,   outR7,   
                        outR8,   outR9,   outR10,  outR11,  outR12,  outR13,  outR14,  outR15,   
                        outR16,  outR17,  outR18,  outR19,  outR20,  outR21,  outR22,  outR23, 
                        outR24,  outR25,  outR26,  outR27,  outR28,  outR29,  outR30,  outR31, 
                        outR32,  outR33,  outR34,  outR35,  outR36,  outR37,  outR38,  outR39, 
                        outR40,  outR41,  outR42,  outR43,  outR44,  outR45,  outR46,  outR47, 
                        outR48,  outR49,  outR50,  outR51,  outR52,  outR53,  outR54,  outR55, 
                        outR56,  outR57,  outR58,  outR59,  outR60,  outR61,  outR62,  outR63, 
                        outR64,  outR65,  outR66,  outR67,  outR68,  outR69,  outR70,  outR71, 
                        outR72,  outR73,  outR74,  outR75,  outR76,  outR77,  outR78,  outR79, 
                        outR80,  outR81,  outR82,  outR83,  outR84,  outR85,  outR86,  outR87, 
                        outR88,  outR89,  outR90,  outR91,  outR92,  outR93,  outR94,  outR95, 
                        outR96,  outR97,  outR98,  outR99,  outR100, outR101, outR102, outR103,
                        outR104, outR105, outR106, outR107, outR108, outR109, outR110, outR111,
                        outR112, outR113, outR114, outR115, outR116, outR117, outR118, outR119,
                        outR120, outR121, outR122, outR123, outR124, outR125, outR126, outR127,
                        pc_5bits, IR);
endmodule


module register32bit(input clk, input reset, input regWrite, input decoderOut1bit, input[31:0] writeData, output[31:0] regOut);
// Define register as you did in the previous lab. Use D_ff, not D_ff_IM
// Your code here
    D_ff d0(clk,reset,regWrite, decoderOut1bit,writeData[0],regOut[0]);
    D_ff d1(clk,reset,regWrite, decoderOut1bit,writeData[1],regOut[1]);
    D_ff d2(clk,reset,regWrite, decoderOut1bit,writeData[2],regOut[2]);
    D_ff d3(clk,reset,regWrite, decoderOut1bit,writeData[3],regOut[3]);
    D_ff d4(clk,reset,regWrite, decoderOut1bit,writeData[4],regOut[4]);
    D_ff d5(clk,reset,regWrite, decoderOut1bit,writeData[5],regOut[5]);
    D_ff d6(clk,reset,regWrite, decoderOut1bit,writeData[6],regOut[6]);
    D_ff d7(clk,reset,regWrite, decoderOut1bit,writeData[7],regOut[7]);
    D_ff d8(clk,reset,regWrite, decoderOut1bit,writeData[8],regOut[8]);
    D_ff d9(clk,reset,regWrite, decoderOut1bit,writeData[9],regOut[9]);
    D_ff d10(clk,reset,regWrite, decoderOut1bit,writeData[10],regOut[10]);
    D_ff d11(clk,reset,regWrite, decoderOut1bit,writeData[11],regOut[11]);
    D_ff d12(clk,reset,regWrite, decoderOut1bit,writeData[12],regOut[12]);
    D_ff d13(clk,reset,regWrite, decoderOut1bit,writeData[13],regOut[13]);
    D_ff d14(clk,reset,regWrite, decoderOut1bit,writeData[14],regOut[14]);
    D_ff d15(clk,reset,regWrite, decoderOut1bit,writeData[15],regOut[15]);
    D_ff d16(clk,reset,regWrite, decoderOut1bit,writeData[16],regOut[16]);
    D_ff d17(clk,reset,regWrite, decoderOut1bit,writeData[17],regOut[17]);
    D_ff d18(clk,reset,regWrite, decoderOut1bit,writeData[18],regOut[18]);
    D_ff d19(clk,reset,regWrite, decoderOut1bit,writeData[19],regOut[19]);
    D_ff d20(clk,reset,regWrite, decoderOut1bit,writeData[20],regOut[20]);
    D_ff d21(clk,reset,regWrite, decoderOut1bit,writeData[21],regOut[21]);
    D_ff d22(clk,reset,regWrite, decoderOut1bit,writeData[22],regOut[22]);
    D_ff d23(clk,reset,regWrite, decoderOut1bit,writeData[23],regOut[23]);
    D_ff d24(clk,reset,regWrite, decoderOut1bit,writeData[24],regOut[24]);
    D_ff d25(clk,reset,regWrite, decoderOut1bit,writeData[25],regOut[25]);
    D_ff d26(clk,reset,regWrite, decoderOut1bit,writeData[26],regOut[26]);
    D_ff d27(clk,reset,regWrite, decoderOut1bit,writeData[27],regOut[27]);
    D_ff d28(clk,reset,regWrite, decoderOut1bit,writeData[28],regOut[28]);
    D_ff d29(clk,reset,regWrite, decoderOut1bit,writeData[29],regOut[29]);
    D_ff d30(clk,reset,regWrite, decoderOut1bit,writeData[30],regOut[30]);
    D_ff d31(clk,reset,regWrite, decoderOut1bit,writeData[31],regOut[31]);

endmodule

module adder(input [31:0] in1, input [31:0] in2, output reg [31:0] adderOut);
    always@(in1 or in2)
    begin
        adderOut = in1+in2;
    end

endmodule


module Reading_IM(input clk, input reset, output [5:0] opcode, output [5:0] funct);
// PC is merely an instance of register32bit. regWrite and decoderOutput1bit input signals should be set
// Your code here
    wire [31:0] inpc;
    wire [31:0] outpc;
    wire [31:0] ir;
    adder a(outpc, 32'd4,inpc);
    register32bit r(clk,reset,1'b1,1'b1,inpc,outpc);
    IM i(clk,reset,outpc[6:2],ir);
    assign opcode = ir[31:26];
    assign funct = ir[5:0];
endmodule	

module Reading_IMTestBench;
	reg clk;
	reg reset;
	wire [5:0] opcode, funct;
	Reading_IM uut (.clk(clk), .reset(reset), .opcode(opcode), .funct(funct));

	always
	#5 clk=~clk;
	
	initial
	begin
    $dumpfile("2017B3A70483G_Lab3.vcd");
		$dumpvars(0, Reading_IMTestBench);
		clk=0; reset=1;
		#5  reset=0;	
		#50 $finish; 
	end
endmodule


