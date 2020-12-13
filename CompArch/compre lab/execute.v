Input Ports
1. alu_src
2. alu_op [1:0]
3. reg_dst
4. pc_next [31:0]
5. branch_imm [31:0]
6. rs_data [31:0]
7. rt_data [31:0]
8. rt [4:0]
9. rd [4:0]
Output Ports
1. pc_branch [31:0]
2. alu_zero
3. alu_res [31:0]
4. write_reg [4:0]
Modules Required
1. A 32 bit 2:1 mux (mux.v → mux2to1).
2. The main alu (alu.v → alu).
3. The alu control unit (alu_control.v →
alu_control).
4. A 5 bit 2:1 mux (mux.v → mux2to1).
5. A shift and add operator. An assign statement can be used here.

wire [31:0] alu_in1;
wire [3:0] operation;
mux2to1 #(32) m1(branch_imm,rt_data,alu_src,alu_in1);
alu_control ac(branch_imm[5:0],alu_op[1:0],operation);
alu alUnit(rs_data,alu_in1,alu_zero,alu_res);
mux2to1 #(5) m2(rt,rd,reg_dest,write_reg);
assign pc_branch = (branch_imm<<2) + pc_next;