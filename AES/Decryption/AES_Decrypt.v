module AES_Decrypt#(parameter N=128,parameter Nr=10,parameter Nk=4)(i_clk,i_rst,i_vld,in,key,out,o_vld);
input i_clk,i_rst,i_vld;
input [127:0] in;
input [N-1:0] key;

output o_vld;
output [127:0] out;

wire w_vld;
wire [(128*(Nr+1))-1 :0] w_fullkeys;
wire [127:0] w_states [Nr+1:0] ;
wire [127:0] w_afterSubBytes;
wire [127:0] w_afterShiftRows;

reg [4:0] count;
reg start;

always @(posedge i_clk)
begin
	if(i_rst)
	begin
	count <= 5'd0;
	start <=0;
	end
	
	else if(i_vld && count < Nr+2)
	begin
	count <= count + 5'd1;
	start <=0;
	
	if(count+1 == Nr+2)
	start <= 1;
	
	end
	
	
	else if (count == Nr+2)
	count <= 5'd0;
	
	else
	count <= count;
end


keyExpansion #(Nk,Nr) ke (i_clk,key,i_rst,i_vld,w_fullkeys,w_vld);

addRoundKey addrk1 (i_clk,i_rst,in,w_states[0],w_fullkeys[127:0]);

genvar i;
generate
	
	for(i=1; i<Nr ;i=i+1)begin : loop
		decryptRound dr(i_clk,i_rst,w_states[i-1],w_fullkeys[i*128+:128],w_states[i]);
		
		end
		inverseShiftRows sr(w_states[Nr-1],w_afterShiftRows);
		inverseSubBytes sb(w_afterShiftRows,w_afterSubBytes);
		addRoundKey_last addrk2(start,i_clk,i_rst,w_afterSubBytes,out,w_fullkeys[((128*(Nr+1))-1)-:128],o_vld);

endgenerate
endmodule