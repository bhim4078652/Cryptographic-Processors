module inverseShiftRows (in, o_shifted);
	input [0:127] in;
	output [0:127] o_shifted;
	
	// First row (r = 0) is not o_shifted
	assign o_shifted[0+:8] = in[0+:8];
	assign o_shifted[32+:8] = in[32+:8];
	assign o_shifted[64+:8] = in[64+:8];
   assign o_shifted[96+:8] = in[96+:8];
	
	// Second row (r = 1) is cyclically right o_shifted by 1 offset
   assign o_shifted[8+:8] = in[104+:8];
   assign o_shifted[40+:8] = in[8+:8];
   assign o_shifted[72+:8] = in[40+:8];
   assign o_shifted[104+:8] = in[72+:8];
	
	// Third row (r = 2) is cyclically right o_shifted by 2 offsets
   assign o_shifted[16+:8] = in[80+:8];
   assign o_shifted[48+:8] = in[112+:8];
   assign o_shifted[80+:8] = in[16+:8];
   assign o_shifted[112+:8] = in[48+:8];
	
	// Fourth row (r = 3) is cyclically right o_shifted by 3 offsets
   assign o_shifted[24+:8] = in[56+:8];
   assign o_shifted[56+:8] = in[88+:8];
   assign o_shifted[88+:8] = in[120+:8];
   assign o_shifted[120+:8] = in[24+:8];

endmodule
