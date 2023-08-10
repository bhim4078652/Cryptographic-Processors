module addRoundKey(i_clk,i_rst,i_data, out, i_key);
input i_clk,i_rst;
input [127:0] i_data;
input [127:0] i_key;
output reg [127:0] out;

always @(posedge i_clk)
begin
	if(i_rst)
	out <= 128'd0;
	
	else
	out = i_key ^ i_data;
end

endmodule