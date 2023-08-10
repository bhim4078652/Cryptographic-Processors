`timescale 1ns / 1ps
module m_pader_parser(i_clk,i_rst,i_byte_rdy,i_byte_stop,data_in,o_overflow,o_flag_0_15,padd_out,o_padding_done,o_start);

input i_clk,i_rst,i_byte_rdy,i_byte_stop;
input [7:0] data_in ;

output reg o_overflow,o_flag_0_15;
output reg [31:0] padd_out;
output reg o_padding_done;
output reg o_start;

reg [7:0] r_block_512 [63:0]; //8bit word * 64 add = 512
reg [6:0] r_add_512_block; // Memory Address Register !7 bit reg can address 127 loc max
reg [63:0] r_m_size;  // l 64-bit number encoded for representing the length of input message
reg temp_chk; //to run if(temp_chk) func only once in if(stop_byte)

reg [6:0] r_add_out0;
reg [6:0] r_add_out1;
reg [6:0] r_add_out2;
reg [6:0] r_add_out3;


always@(posedge i_clk)
begin
	if(i_rst==0)
	begin
		r_add_out0=7'd0;
		r_add_out1=7'd1;
		r_add_out2=7'd2;
		r_add_out3=7'd3;
		r_add_512_block=7'd0;
		r_m_size=64'd0;
		o_padding_done=1'b0;
		padd_out=32'd0;
		o_overflow=1'b0;
		temp_chk=1'b0;
		o_flag_0_15=1'b0;
		o_start=1'b0;
	end
	else
	begin
		if(i_byte_rdy) //data stop byte received and checked by UART and i_byte_rdy=1
		begin
		r_block_512[r_add_512_block]=data_in;
		r_add_512_block=r_add_512_block+7'd1;
		end
		
		else  	//i_byte_rdy would go down after byte is tranferd and UART is in IDLE
		//else start padding when stop byte is received 
		begin
			if(i_byte_stop)
			begin
			//padding begins
				if(r_add_512_block<55)
				begin
					if(temp_chk==0)
					begin
						o_padding_done=1'b0; //in progress
						r_m_size[63:0]=(r_add_512_block)*8; //add is incremented but we also start add from '0' so its good
						r_block_512[r_add_512_block]=8'b1_000_0000; //as r_add_512_block is already on new location --->> add 1_000_0000 byte
						temp_chk=1'b1;
					end //no else
		
					if(r_add_512_block<55)
					begin
					
						case(r_add_512_block)
						7'd1: begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd2: begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd3: begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd4: begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd5: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd6: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd7: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd8: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd9: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd10: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd11: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd12: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd13: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd14: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd15: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd16: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd17: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd18: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd19: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd20: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd21: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd22: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd23: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd24: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd25: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd26: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd27: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd28: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd29: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd30: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd31: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd32: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd33: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd34: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd35: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd36: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd37: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd38: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd39: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd40: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd41: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd42: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd43: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd44: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd45: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd46: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd47: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd48: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd49: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd50: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd51: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd52: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd53: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd54: 
						begin
								r_add_512_block=r_add_512_block+7'd1;
								r_block_512[r_add_512_block]=8'd0;
						end
						7'd55: 
						begin
								r_block_512[r_add_512_block]=8'd0; //last address for '0's of  K
						end
						
						default:
						begin
								o_overflow=1'b1; //if address was <55 still no case started
								o_padding_done=1'b0; //then there is an error 
						end
						
						endcase
					end
				end
				else
				begin
				o_start=1'b1;//to start iterative_processing right after o_padding_done
				r_block_512[63]=r_m_size[7:0];
				r_block_512[62]=r_m_size[15:8];
				r_block_512[61]=r_m_size[23:16];
				r_block_512[60]=r_m_size[31:24];
				r_block_512[59]=r_m_size[39:32];	//allocating the 64-bit r_m_size in the block
				r_block_512[58]=r_m_size[47:40];
				r_block_512[57]=r_m_size[55:48];
				r_block_512[56]=r_m_size[63:56];  //r_block_512[56] location for LSB of 64-bit r_m_size
				
				o_padding_done=1'b1; //out this to start m_iteration
				
				end
end
else
begin
//avoiding stop byte check to keep less out flags
end
end

if(r_add_512_block==55 && i_byte_stop==0)	//to make sure data is less than or equal allowed space and
												// we have free space for padding
begin
o_overflow=1'b1;
o_padding_done=1'b0; //if overflow !! don't start Hashing
end
else
begin
o_overflow=1'b0;				//Overflow of input message
end

if(o_padding_done==1)		//parsing
begin
if(r_add_out0==0)		//set 0 in reset
begin
	padd_out[7:0]=r_block_512[r_add_out3];
	padd_out[15:8]=r_block_512[r_add_out2];		//taken 32-bit data
	padd_out[23:16]=r_block_512[r_add_out1];
	padd_out[31:24]=r_block_512[r_add_out0];
	
	r_add_out0=r_add_out0+7'd4;
	r_add_out1=r_add_out1+7'd4;
	r_add_out2=r_add_out2+7'd4;		//to take 4 addresses in 1 cycle
	r_add_out3=r_add_out3+7'd4;

end
else
begin
	if(r_add_out3<64)		//to stop after last location is addressed
	begin
	
	padd_out[7:0]=r_block_512[r_add_out3];
	padd_out[15:8]=r_block_512[r_add_out2];		//taken 32-bit data
	padd_out[23:16]=r_block_512[r_add_out1];
	padd_out[31:24]=r_block_512[r_add_out0];
	
	r_add_out0=r_add_out0+7'd4;
	r_add_out1=r_add_out1+7'd4;
	r_add_out2=r_add_out2+7'd4;		//to take 4 addresses in 1 cycle
	r_add_out3=r_add_out3+7'd4;
	
	end
	else
	begin
	o_flag_0_15=1'b1;
	end
end
end
else
begin
//nothing
end
end
end
endmodule
