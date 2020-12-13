`include "mux.v"
`include "alu_control.v"
`include "alu.v"

module execute(

    input alu_src,
    input [1:0] alu_op,
    input reg_dst,

    input [31:0] pc_next,
    input [31:0] branch_imm,

    input [31:0] rs_data,
    input [31:0] rt_data,
    input [4:0] rt,         // even though rt_data is present, rt is required in this stage separately
    input [4:0] rd,         // as above, rd is provided so that reg_dst (the input) can select between the two

    output [31:0] pc_branch,
    output alu_zero,
    output [31:0] alu_res,
    output [4:0] write_reg

);

    // Write your code below.
    wire [31:0] alu_in1;
    wire [3:0] operation;
    mux2to1 #(32) m1(rt_data,branch_imm,alu_src,alu_in1);
    alu_control ac(alu_op[1:0],branch_imm[5:0],operation);
    alu alUnit(rs_data,alu_in1,operation,alu_res,alu_zero);
    mux2to1 #(5) m2(rt,rd,reg_dst,write_reg);
    assign pc_branch = (branch_imm<<2) + pc_next;



endmodule
