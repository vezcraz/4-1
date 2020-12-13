for i in range(32):
	s = f'D_ff ff{i}(clk, reset, regWrite, decoderOut1bit, writeData[{i}],regOut[{i}]);'
	print(s)
# s=""
# for i in range(32):
# 	s+=f'else if(select=={i}) muxOut = in{i};\n'
# 	print(s)

# for i in range(32):
# 	print(f'register32bit r{i}(clk, reset, regWrite, decoderOut[{i}],writeData[{i}],outR{i} );')
# s=""
# for i in range(32):
# 	s = s+f'out{i}, '
# print(s)