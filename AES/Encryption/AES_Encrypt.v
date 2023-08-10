module AES_Encrypt#(parameter N=128,parameter Nr=10,parameter Nk=4)(i_clk,i_rst,i_vld,in,i_key,out,o_vld);
input i_clk,i_rst,i_vld;
input [127:0] in;
input [N-1:0] i_key;

output o_vld;
output [127:0] out;

wire w_vld;
wire [(128*(Nr+1))-1 :0] w_fullkeys;
wire [127:0] w_states [Nr+1:0] ;
wire [127:0] w_afterSubBytes;
wire [127:0] w_afterShiftRows;

reg [4:0] r_count;
reg r_start;

always @(posedge i_clk)
begin
	if(i_rst)
	begin
	r_count <= 5'd0;
	r_start <=0;
	end
	
	else if(i_vld && r_count < Nr+2)
	begin
	r_count <= r_count + 5'd1;
	r_start <=0;
	
	if(r_count+1 == Nr+2)
	r_start <= 1;
	
	end
	
	
	else if (r_count == Nr+2)
	r_count <= 5'd0;
	
	else
	r_count <= r_count;
end
	
keyExpansion #(Nk,Nr) ke (i_clk,i_key,i_rst,i_vld,w_fullkeys,w_vld);

addRoundKey addrk1 (i_clk,i_rst,in,w_states[0],w_fullkeys[((128*(Nr+1))-1)-:128]);

genvar i;
generate
	
	for(i=1; i<Nr ;i=i+1)begin : loop
		encryptRound er(i_clk,i_rst,w_states[i-1],w_fullkeys[(((128*(Nr+1))-1)-128*i)-:128],w_states[i]);
		end
		
		
		subBytes sb(w_states[Nr-1],w_afterSubBytes);
		shiftRows sr(w_afterSubBytes,w_afterShiftRows);
		addRoundKey_last addrk2(r_start,i_clk,i_rst,w_afterShiftRows,out,w_fullkeys[127:0],o_vld);

endgenerate
endmodule