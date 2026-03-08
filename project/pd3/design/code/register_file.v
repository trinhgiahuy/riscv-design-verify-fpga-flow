module register_file #()
(
input clock,
input [4:0] addr_rs1,   
input [4:0] addr_rs2,   
input [4:0] addr_rd,
input [31:0] data_rd,
output [31:0] data_rs1,
output [31:0] data_rs2,
input write_enable
);

reg [31:0] x [0:31];
integer i;
reg [31:0] dout1;
reg [31:0] dout2;

initial begin
	for(i=0;i<32;i=i+1)
	begin
		if(i==2)
			x[i]=32'h01000000 + `MEM_DEPTH;
		else
			x[i]='d0;
	end
end


always @(posedge clock)
begin
	if(write_enable && addr_rd!=0)
		x[addr_rd] <= data_rd;

end

always @(*)
begin
	dout1=x[addr_rs1];
	dout2=x[addr_rs2];	
end

assign data_rs1 = dout1;
assign data_rs2 = dout2;

endmodule
