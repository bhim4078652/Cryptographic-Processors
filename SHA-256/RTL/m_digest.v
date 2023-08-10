`timescale 1ns / 1ps
module m_digest(i_clk,i_rst,i_count,a_in,b_in,c_in,d_in,e_in,f_in,g_in,h_in,o_hash,o_vld);

input i_clk,i_rst;
input [6:0] i_count; //1-64 itterations
input [31:0] a_in,b_in,c_in,d_in,e_in,f_in,g_in,h_in;

output reg o_vld=0;
output reg [255:0] o_hash;

reg temp_delay;

reg [31:0] H0 ;
reg [31:0] H1 ;
reg [31:0] H2 ;
reg [31:0] H3 ;
reg [31:0] H4 ;
reg [31:0] H5 ;
reg [31:0] H6 ;
reg [31:0] H7 ;

reg [31:0] temp_H0;
reg [31:0] temp_H1;
reg [31:0] temp_H2;
reg [31:0] temp_H3;
reg [31:0] temp_H4;
reg [31:0] temp_H5;
reg [31:0] temp_H6;
reg [31:0] temp_H7;


always@(posedge i_clk)
begin
	if(i_rst==0)
	begin
	temp_delay=1'b0;
	o_hash=256'd0;

	H0=32'h6a09e667;
	H1=32'hbb67ae85;
	H2=32'h3c6ef372;
	H3=32'ha54ff53a;
	H4=32'h510e527f;
	H5=32'h9b05688c;
	H6=32'h1f83d9ab;
	H7=32'h5be0cd19;

	temp_H0=32'd0;
	temp_H1=32'd0;
	temp_H2=32'd0;
	temp_H3=32'd0;
	temp_H4=32'd0;
	temp_H5=32'd0;
	temp_H6=32'd0;
	temp_H7=32'd0;

	o_hash=256'd0;
end
else
begin
	if(i_count==7'd64) //only add for 1 time for 1 512_block
	 begin//32'bit modulo adder
	 temp_H0=H0+a_in;
	 if(temp_H0<32'hFFFFFFFF || temp_H0==32'hFFFFFFFF)H0=temp_H0;
	 else H0=temp_H0-32'hFFFFFFFF;
	 
	 temp_H1=H1+b_in;
	 if(temp_H1<32'hFFFFFFFF || temp_H1==32'hFFFFFFFF)H1=temp_H1;
	 else H1=temp_H1-32'hFFFFFFFF;
	 
	 temp_H2=H2+c_in;
	 if(temp_H2<32'hFFFFFFFF || temp_H2==32'hFFFFFFFF)H2=temp_H2;
	 else H2=temp_H2-32'hFFFFFFFF;
	 
	 temp_H3=H3+d_in;
	 if(temp_H3<32'hFFFFFFFF || temp_H3==32'hFFFFFFFF)H3=temp_H3;
	 else H3=temp_H3-32'hFFFFFFFF;
	 
	 temp_H4=H4+e_in;
	 if(temp_H4<32'hFFFFFFFF || temp_H4==32'hFFFFFFFF)H4=temp_H4;
	 else H4=temp_H4-32'hFFFFFFFF;
	 
	 temp_H5=H5+f_in;
	 if(temp_H5<32'hFFFFFFFF || temp_H5==32'hFFFFFFFF)H5=temp_H5;
	 else H5=temp_H5-32'hFFFFFFFF;
	 
	 temp_H6=H6+g_in;
	 if(temp_H6<32'hFFFFFFFF || temp_H6==32'hFFFFFFFF)H6=temp_H6;
	 else H6=temp_H6-32'hFFFFFFFF;
	 
	 temp_H7=H7+h_in;
	 if(temp_H7<32'hFFFFFFFF || temp_H7==32'hFFFFFFFF)H7=temp_H7;
	 else H7=temp_H7-32'hFFFFFFFF;
	 if(temp_delay==0)
	 begin
	 temp_delay=temp_delay+1'd1;
	 o_hash={H0,H1,H2,H3,H4,H5,H6,H7};
	 o_vld=1;
	 end
	 end
	end
end
endmodule
