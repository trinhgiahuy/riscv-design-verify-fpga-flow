module pd(
  input clock,
  input reset
);

//Fetch Stage Signals
reg [31:0] pc;
wire [31:0] data_out;
reg [31:0] data_in;
wire read_write;

//Decode Stage Signals
reg [6:0] OPCODE;
reg [4:0] RD;
reg [4:0] RS_1;
reg [4:0] RS_2;
reg [2:0] FUNCT3;
reg [6:0] FUNCT7;
reg [31:0] IMM;
reg [4:0] SHAMT;
reg [31:0] IMMI;

//Fetch Stage Code
imemory memi(
	.clock(clock),
	.address(pc),
	.data_in(data_in),
	.data_out(data_out),
	.read_write(read_write)
);

always @(posedge clock)
begin
	if(reset) 
	begin
		pc <= 32'h01000000;
	end
	else
	begin
		pc <= pc+4;
	end
end

//Decode Stage Code
always @(data_out)
begin
	case(data_out[6:0])
		7'h17: IMMI = {data_out[31:12],12'h0};
		7'h23: IMMI = data_out[31] ? {20'hFFFFF,data_out[31:25],data_out[11:7]} : {20'h0,data_out[31:25],data_out[11:7]};
		7'h33: IMMI = 'd0;
		7'h37: IMMI = {data_out[31:12],12'h0};
		7'h63: IMMI = data_out[31] ? {20'hFFFFF,data_out[7],data_out[30:25],data_out[11:8],1'b0} : {20'h0,data_out[7],data_out[30:25],data_out[11:8],1'b0};
		7'h6F: IMMI = data_out[31] ? {12'hFFF,data_out[19:12],data_out[20],data_out[30:21],1'b0} : {12'h0,data_out[19:12],data_out[20],data_out[30:21],1'b0};
		7'h73: IMMI = 'd0;
		default : IMMI = data_out[31] ? {20'hFFFFF,data_out[31:20]} : {20'h0,data_out[31:20]};
	endcase

	OPCODE = data_out[6:0];
	RD = data_out[11:7];
	RS_1 = data_out[19:15];
	RS_2 = data_out[24:20];
	FUNCT3 = data_out[14:12];
	FUNCT7 = data_out[31:25];
	IMM = IMMI;
	SHAMT = data_out[24:20];
end


endmodule
