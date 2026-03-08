module imemory #()
(
input clock,
input [31:0] address,
input [31:0] data_in,
output [31:0] data_out,
input read_write
);

reg [7:0] magic_mem [0 : `MEM_DEPTH];
reg [31:0] dout;
reg [31:0] magic_mem_temp [0:`LINE_COUNT];
integer i;

initial 
begin
	$readmemh(`MEM_PATH,magic_mem_temp,1,`LINE_COUNT);
	for(i=1;i<=`LINE_COUNT;i=i+1)
	begin
		magic_mem[(i-1)*4]=magic_mem_temp[i][7:0];
		magic_mem[((i-1)*4)+1]=magic_mem_temp[i][15:8];
		magic_mem[((i-1)*4)+2]=magic_mem_temp[i][23:16];
		magic_mem[((i-1)*4)+3]=magic_mem_temp[i][31:24];
	end
end



always @(posedge clock)
begin
	if(read_write)
	begin
		magic_mem[address] <= data_in[7:0];
		magic_mem[address+1] <= data_in[15:8];
		magic_mem[address+2] <= data_in[23:16];
		magic_mem[address+3] <= data_in[31:24];
	end

end

always @(*)
begin	
	if(~read_write)
		dout = {magic_mem[address+3],magic_mem[address+2],magic_mem[address+1],magic_mem[address]};
	else
		dout ='d0;
end

assign data_out = dout;

endmodule
