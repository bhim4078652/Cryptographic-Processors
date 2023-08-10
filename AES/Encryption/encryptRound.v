module encryptRound(i_clk,i_rst,in,i_key,out);
input i_clk,i_rst;
input [127:0] in;
input [127:0] i_key;

output [127:0] out;

wire [127:0] w_afterSubBytes;
wire [127:0] w_afterShiftRows;
wire [127:0] w_afterMixColumns;

subBytes s(in,w_afterSubBytes);
shiftRows r(w_afterSubBytes,w_afterShiftRows);
mixColumns m(w_afterShiftRows,w_afterMixColumns);
addRoundKey b(i_clk,i_rst,w_afterMixColumns,out,i_key);
		
endmodule