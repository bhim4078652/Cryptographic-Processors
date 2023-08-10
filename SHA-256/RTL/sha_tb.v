`timescale 1ns / 1ps
module sha_tb();
reg clk;
reg [7:0] data_in;
reg rst;
reg byte_rdy;
reg byte_stop;

wire [255:0] out;
wire overflow;
wire o_valid;

integer f1,f2;
Sha256_main DUT(clk,rst,byte_rdy,byte_stop,data_in,overflow,out,o_valid);


initial
begin
	forever #5 clk = !clk;
end


initial
begin
f1=$fopen("output.txt","w");
f2=$fopen("input_sha.txt","r");
clk = 1;
rst = 1;

#3 rst = 0;
#10 rst = 1;
#2 byte_rdy = 1;
	while(!$feof(f2))
	begin
		$fscanf(f2,"%b\n",data_in);
		#10;
	end
	
	byte_rdy = 0;
	#3 byte_stop = 1;
	$fclose(f2);
	
#2000 $finish ;
end

always @(o_valid)
begin
if(o_valid==1'b1)
begin
	$fwrite(f1,"%h\n",out);
	$fclose(f1);
end
end
endmodule      

