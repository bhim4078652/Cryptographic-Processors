module AES_Decrypt_tb;
parameter Nk=6;

reg [127:0] in1;
reg [32*Nk-1:0] key1;
reg i_clk,i_rst,i_vld;
reg [127:0] mem[1:0];

wire o_vld;
wire [127:0] out1;

integer f;

AES_Decrypt #(192,12,6) a(i_clk,i_rst,i_vld,in1,key1,out1,o_vld);

initial 
forever #5 i_clk = ~ i_clk;

initial 
begin
f=$fopen("output_decoding.txt","w");

i_clk=0;
i_rst=0;
i_vld=0;

#3 i_rst=1;

#7 i_rst=0;
	i_vld=1;

$readmemh("output_encoding.txt",mem);
in1=mem[0];
key1=192'h_000102030405060708090a0b0c0d0e0f1011121314151617;


#200 $finish;

end

always @(o_vld)
begin
if(o_vld==1'b1)
begin
	$fwrite(f,"%b\n",out1);
	$fclose(f);
end
end


endmodule