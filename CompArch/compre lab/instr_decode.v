sign_ext sgnExt(instruction[15:0],branch_imm[31:0]);
register_file rf(clk,reset,instruction[25:21],instruction[20:16],write_reg,write_data,reg_write_in,rs_data,rt_data);
control_circuit conCirc(clk,reset,instruction[31:26],reg_write_out,mem_to_reg,branch,mem_write,mem_read,alu_src,alu_op, reg_dst);
