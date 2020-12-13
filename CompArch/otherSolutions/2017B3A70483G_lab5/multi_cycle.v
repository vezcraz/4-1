`include "alu.v"
`include "control.v"
`include "dff.v"
`include "memory.v"
`include "mux.v"
`include "register_file.v"
`include "registers.v"
`include "sign_ext.v"

// Write your code here
// make sure that the im module is instantiated as "instruction memory" 


module multi_cycle (input clk, input reset, output [31:0] result);
    wire [31:0] ouputPC;
    wire Branching;
    wire x1;
    wire [31:0] im_output;
    wire pc_writer;
    wire InputOutpuRD;
    wire [4:0] muxerOutput2;
    wire [4:0] muxerOutput1;
    wire [31:0] inputPC;
    wire REG_Writer;
    wire srcA_alu;
    wire ir_writer;
    wire [31:0] ir_output;
    wire [31:0] mdrExpOutput;
    wire register_destination;
    wire [31:0] register_file1, register_file2;
    wire [1:0] memory2Register;
    wire [31:0] signexoutput;
    wire [31:0] Ouput_A, Ouput_B;
    wire [1:0] srcB_alu;
    wire memoryReader;
    wire registerWr;
    wire [31:0] muxerOutput3, muxerOutput4, muxerOutput5;
    wire [31:0] alu_Output0, alu_Output1;
    wire [31:0] output_ls;
    wire zero;
    wire [1:0] output_alu;
    wire [1:0] src_pc;
    wire [31:0] output_high, output_low;
    wire [27:0] output_ls2;
    wire [31:0] add_jum;
    wire write_big, write_small;
    wire [31:0] muxerOutput6;
    wire [31:0]  output1_out;


    and(x1, zero, Branching);
    mux2to1 #(5) m_1(ouputPC[6:2], result[6:2], InputOutpuRD, muxerOutput1);
    intermediate_reg pc(clk, reset, registerWr, inputPC, ouputPC);
    or(registerWr, pc_writer, x1);
    im #(32, 5) instruction_memory(clk, reset, muxerOutput1, memoryReader, im_output);
    intermediate_reg mdr(clk, reset, 1'b1 , im_output, mdrExpOutput);
    intermediate_reg IR(clk, reset, ir_writer , im_output, ir_output);
    register_file regfile(clk, reset, REG_Writer, ir_output[25:21], ir_output[20:16], muxerOutput2, muxerOutput3, register_file1, register_file2);
    mux4to1 #(32) m_5(Ouput_B, 32'd4, signexoutput, output_ls, srcB_alu, muxerOutput5);
    sign_ext SE(ir_output[15:0], signexoutput);
    mux2to1 #(5) m_2(ir_output[20:16], ir_output[15:11], register_destination, muxerOutput2);
    mux4to1 #(32) m_3(mdrExpOutput, output_high, result, 32'd0, memory2Register, muxerOutput3);
    alu ArithLogic(muxerOutput4, muxerOutput5, output_alu, alu_Output0, alu_Output1, zero);
    intermediate_reg ax(clk, reset, 1'b1 , register_file1, Ouput_A);
    intermediate_reg bx(clk, reset, 1'b1 , register_file2, Ouput_B);
    mux2to1 #(32) m_4(ouputPC, Ouput_A, srcA_alu, muxerOutput4);
    assign output_ls = {signexoutput[29:0] , 2'b00};
    intermediate_reg High(clk, reset, write_big, output1_out, output_high);
    intermediate_reg Low(clk, reset, write_small, result, output_low);
    intermediate_reg Output0(clk, reset, 1'b1 , alu_Output0, result);
    intermediate_reg Output1(clk, reset, 1'b1 , alu_Output1, output1_out);
    control_circuit ConCirc(clk, reset, ir_output[31:26], ir_output[5:0], InputOutpuRD, memoryReader, ir_writer, register_destination, REG_Writer, srcA_alu, srcB_alu, output_alu, write_big, write_small, memory2Register, src_pc, pc_writer, Branching);
    mux4to1 #(32) m_6(result, add_jum, alu_Output0, 32'b0, src_pc, inputPC);
    assign add_jum = {ouputPC[31:28],output_ls2};   
    assign output_ls2 = {ir_output[25:0] , 2'b00};
          
endmodule