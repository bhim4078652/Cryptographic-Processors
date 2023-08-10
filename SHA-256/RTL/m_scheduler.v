`timescale 1ns / 1ps
module m_scheduler(i_clk,i_rst,i_flag_0_15,i_padding_done,data_in,o_mreg_15,iteration_out); 
		
input i_clk,i_rst,i_flag_0_15,i_padding_done;
input [31:0] data_in;

output reg [31:0] o_mreg_15;
output reg [6:0] iteration_out;

reg temp_case;
reg [6:0] r_count;
reg [31:0] mreg_0,mreg_1,mreg_2,mreg_3,mreg_4,mreg_5,mreg_6,mreg_7,mreg_8,mreg_9,mreg_10,mreg_11,mreg_12,mreg_13,mreg_14;

wire [31:0] w_sigma_0,w_sigma_1,w_mreg15;

assign w_sigma_0=({mreg_1[6:0],mreg_1[31:7]} ^ {mreg_1[17:0],mreg_1[31:18]} ^ mreg_1[31:0]>>2'b11);
assign w_sigma_1=({mreg_14[16:0],mreg_14[31:17]} ^ {mreg_14[18:0],mreg_14[31:19]} ^ mreg_14[31:0]>>4'b1010);
assign w_mreg15=(mreg_0 + w_sigma_0 + mreg_9 + w_sigma_1);
always@(posedge i_clk)
begin
if(i_rst==0)
begin
	temp_case<=1'b0;
	iteration_out<=7'd0;
	r_count<=7'd1;
	o_mreg_15<=32'd0;
	mreg_14<=32'd0;
	mreg_13<=32'd0;
	mreg_12<=32'd0;
	mreg_11<=32'd0;
	mreg_10<=32'd0;
	mreg_9<=32'd0;
	mreg_8<=32'd0;
	mreg_7<=32'd0;
	mreg_6<=32'd0;
	mreg_5<=32'd0;
	mreg_4<=32'd0;
	mreg_3<=32'd0;
	mreg_2<=32'd0;
	mreg_1<=32'd0;
	mreg_0<=32'd0;
end
else
begin
	if(i_flag_0_15==0 && r_count<17 && r_count>0)
	begin
		o_mreg_15<=data_in;
		mreg_14<=o_mreg_15;
		mreg_13<=mreg_14;
		mreg_12<=mreg_13;
		mreg_11<=mreg_12;
		mreg_10<=mreg_11;
		mreg_9<=mreg_10;
		mreg_8<=mreg_9;
		mreg_7<=mreg_8;
		mreg_6<=mreg_7;
		mreg_5<=mreg_6;
		mreg_4<=mreg_5;
		mreg_3<=mreg_4;
		mreg_2<=mreg_3;
		mreg_1<=mreg_2;
		mreg_0<=mreg_1;
	end
	else				//i_flag_0_15==1 when all the 32 bit data_in from 32*16=512block has received
	begin
		if(r_count!=64 && r_count>0)
		begin
			o_mreg_15<=w_mreg15;
			mreg_14<=o_mreg_15;
			mreg_13<=mreg_14;
			mreg_12<=mreg_13;
			mreg_11<=mreg_12;
			mreg_10<=mreg_11;
			mreg_9<=mreg_10;
			mreg_8<=mreg_9;
			mreg_7<=mreg_8;
			mreg_6<=mreg_7;
			mreg_5<=mreg_6;
			mreg_4<=mreg_5;
			mreg_3<=mreg_4;
			mreg_2<=mreg_3;
			mreg_1<=mreg_2;
			mreg_0<=mreg_1;
		end
	end
	if(r_count==0 && i_padding_done==0)
	begin
		r_count<=7'd0;
	end
	else
	begin
		if(r_count==64 && i_padding_done==1)
		begin
		r_count<=7'd64;
		iteration_out<=7'd64;
		o_mreg_15<=o_mreg_15;
		end
		else
		begin
			if(i_padding_done==0)
			begin
			r_count<=7'd1;
			end
			else
			begin
			case(temp_case)
			1'b0: temp_case<=1'b1;
			1'b1: begin
					iteration_out<=r_count;
					r_count<=r_count+7'd1;
					end
			endcase
			end
		end
	end
end
end

endmodule
