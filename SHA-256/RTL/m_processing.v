`timescale 1ns / 1ps
module m_processing(i_clk,i_rst,w,k,i_count,i_padding_done,a_out,b_out,c_out,d_out,e_out,f_out,g_out,h_out);
	 
 input i_clk,i_rst,i_padding_done;
 input [6:0] i_count;
 input [31:0] w,k;
 
 output reg [31:0] a_out,b_out,c_out,d_out,e_out,f_out,g_out,h_out;
 
 reg temp_case,temp_if;
 reg [31:0] r_a,r_b,r_c,r_d,r_e,r_f,r_g,r_h;
 reg [31:0] r_semation_0,r_semation_1,r_ch,r_maj;
 
 always@(posedge i_clk)
 begin
 if(i_rst==0)
 begin
		temp_case=1'b0;
		a_out=32'h6a09e667;
		b_out=32'hbb67ae85;
		c_out=32'h3c6ef372;
		d_out=32'ha54ff53a;
		e_out=32'h510e527f;
		f_out=32'h9b05688c;
		g_out=32'h1f83d9ab;
		h_out=32'h5be0cd19;
 end
 else
 begin
		
		r_semation_0=({a_out[1:0],a_out[31:2]}) ^ ({a_out[12:0],a_out[31:13]}) ^ ({a_out[21:0],a_out[31:22]}); //last 22 ROTR22
		r_semation_1=({e_out[5:0],e_out[31:6]}) ^ ({e_out[10:0],e_out[31:11]}) ^ ({e_out[24:0],e_out[31:25]});
 
		r_maj=(a_out & b_out) ^ (a_out & c_out) ^ (b_out & c_out);
		r_ch=(e_out & f_out) ^ (~e_out & g_out);
		if(i_count==65)
		begin
		a_out=a_out;
		b_out=b_out;
		c_out=c_out;
		d_out=d_out;
		e_out=e_out;
		f_out=f_out;
		g_out=g_out;
		h_out=h_out;
		end
		else
		begin
		
		if(i_padding_done==1)
		begin
		case(temp_case)
		1'b0: temp_case=1'b1;
		1'b1: temp_if=1'b1;
		endcase
		end
		
		if(temp_if==1 && i_count!=64)
		begin
		r_a= h_out + r_semation_1 + r_ch + k + w + r_semation_0 + r_maj; 	// T2= r_semation_0 + r_maj(a,b,c);
		r_b= a_out;
		r_c= b_out;
		r_d= c_out;
		r_e= d_out + h_out + r_semation_1 + r_ch + k + w;		//T1 = h_out + r_semation_1 + r_ch + k + w;
		r_f= e_out;
		r_g= f_out;
		r_h= g_out;

		a_out=r_a;
		b_out=r_b;
		c_out=r_c;
		d_out=r_d; //alternative of non-blocking though
		e_out=r_e;
		f_out=r_f;
		g_out=r_g;
		h_out=r_h;
		
		end
		end
 end
 
 end


endmodule
