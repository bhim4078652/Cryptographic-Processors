module addRoundKey_last (i_start,i_clk,i_rst,i_data, out, i_key,o_vld);
input i_start;
input i_clk,i_rst;
input [127:0] i_data;
input [127:0] i_key;
output reg [127:0] out;
output reg o_vld;
always @(posedge i_clk)
begin
	if(i_rst)
	begin
	out <= 128'd0;
	o_vld <= 1'b0;
	end
	
	else if(i_start)
	begin
	out <= i_key ^ i_data;
	o_vld <= 1'b1;
	end
end

endmodule