module pd(
  input clock,
  input reset
);

//Fetch Stage Signals
reg [31:0] pc;
wire [31:0] data_out;
reg [31:0] data_in;
wire read_write;
wire PC_SEL;
wire [31:0] pc_mux;

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

//Execute Stage Signals
wire R_WRITE_ENABLE;
wire [4:0] R_WRITE_DESTINATION;
wire [31:0] R_WRITE_DATA;
wire [4:0] R_READ_RS1;
wire [4:0] R_READ_RS2;
reg [31:0] R_READ_RS1_DATA;
reg [31:0] R_READ_RS2_DATA;
wire [31:0] R_READ_RS1_DATA_mux;
wire [31:0] R_READ_RS2_DATA_mux;
wire signed [31:0] S_RS1;
wire signed [31:0] S_RS1_mux;
wire signed [31:0] S_RS2;
wire signed [31:0] S_RS2_mux;
wire [3:0] FUNC37;
reg [31:0] E_PC;
reg [31:0] E_ALU_RES;
reg E_BR_TAKEN;

//Memory Stage Signals
wire [31:0] M_PC             ; 
wire [31:0] M_ADDRESS        ;   
wire M_RW             ;   
wire [1:0] M_SIZE_ENCODED   ;   
wire [31:0] M_DATA           ;  
reg [31:0] dout_dm;
reg [31:0] dout_dm_int;

//Write Back Stage Signals
wire [31:0] W_PC;
wire W_ENABLE;
wire [4:0] W_DESTINATION;
wire [31:0] W_DATA;
reg [1:0] WBSEL;

//Fetch Stage Code
imemory memi(
	.clock(clock),
	.address(pc),
	.data_in(data_in),
	.data_out(data_out),
	.read_write(read_write)
);

assign pc_mux= PC_SEL ? E_ALU_RES : pc+4;

always @(posedge clock)
begin
	if(reset) 
	begin
		pc <= 32'h01000000;
	end
	else
	begin
		pc <= pc_mux;
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

//Execute Stage Code
assign R_READ_RS1 = RS_1;
assign R_READ_RS2 = RS_2;
assign R_WRITE_DESTINATION = RD;

register_file regif(
	.clock(clock),
	.addr_rs1(R_READ_RS1),
	.addr_rs2(R_READ_RS2),
	.addr_rd(R_WRITE_DESTINATION),
	.data_rd(R_WRITE_DATA),
	.data_rs1(R_READ_RS1_DATA),
	.data_rs2(R_READ_RS2_DATA),
	.write_enable(R_WRITE_ENABLE)
);

assign R_READ_RS1_DATA_mux = (OPCODE==7'h63 || OPCODE==7'h17 || OPCODE==7'h6F) ? pc : R_READ_RS1_DATA;
assign R_READ_RS2_DATA_mux = (OPCODE==7'h13) ? IMM : R_READ_RS2_DATA;
assign FUNC37={FUNCT7[5],FUNCT3};
assign S_RS1 =R_READ_RS1_DATA;
assign S_RS1_mux =R_READ_RS1_DATA_mux;
assign S_RS2=R_READ_RS2_DATA;
assign S_RS2_mux=R_READ_RS2_DATA_mux;


always @(*)
begin
	case(OPCODE)
		7'h3: begin
			E_ALU_RES = R_READ_RS1_DATA_mux + IMM;
			E_PC = pc;
			E_BR_TAKEN ='d0;
			WBSEL='d0;
		end
		7'h13: begin
			case(FUNCT3)
				3'h0: E_ALU_RES = R_READ_RS1_DATA_mux + R_READ_RS2_DATA_mux;
				3'h2: begin
					if(S_RS1_mux < S_RS2_mux)
						E_ALU_RES = 'd1;
					else
						E_ALU_RES = 'd0;
				end
				3'h3: begin
					if(R_READ_RS1=='d0 && R_READ_RS2=='d2 && R_READ_RS2_DATA_mux!='d0)
						E_ALU_RES = 'd1;
					else if(R_READ_RS1=='d0 && R_READ_RS2=='d2)
						E_ALU_RES = 'd0;
					else if(R_READ_RS1_DATA_mux < R_READ_RS2_DATA_mux)
						E_ALU_RES = 'd1;
					else
						E_ALU_RES = 'd0;
				end
				3'h4: E_ALU_RES = R_READ_RS1_DATA_mux ^ R_READ_RS2_DATA_mux;
				3'h6: E_ALU_RES = R_READ_RS1_DATA_mux | R_READ_RS2_DATA_mux;
				3'h7: E_ALU_RES = R_READ_RS1_DATA_mux & R_READ_RS2_DATA_mux;
				default : E_ALU_RES ='d0;
			endcase
			case(FUNC37)
				4'h1: E_ALU_RES = R_READ_RS1_DATA_mux << R_READ_RS2_DATA_mux[4:0];
				4'h5: E_ALU_RES = R_READ_RS1_DATA_mux >> R_READ_RS2_DATA_mux[4:0];
				4'hD: E_ALU_RES = S_RS1_mux >>> S_RS2_mux[4:0];
				default: E_ALU_RES = E_ALU_RES;
			endcase
			E_PC = pc;
			E_BR_TAKEN ='d0;
			WBSEL='d1;
		end
		7'h17: begin
			E_ALU_RES = R_READ_RS1_DATA_mux + IMM;
			E_PC = pc;
			E_BR_TAKEN ='d0;
			WBSEL='d1;
		end
		7'h23: begin
			E_ALU_RES = R_READ_RS1_DATA_mux + IMM;
			E_PC = pc;
			E_BR_TAKEN ='d0;
			WBSEL='d0;
		end
		7'h37: begin
			E_ALU_RES = IMM;
			E_PC = pc;
			E_BR_TAKEN ='d0;
			WBSEL='d1;
		end
		7'h63: begin
			case(FUNCT3)
				3'h0: if(R_READ_RS1_DATA == R_READ_RS2_DATA)
					E_BR_TAKEN = 'd1;
				else 
					E_BR_TAKEN ='d0;
				3'h1: if(R_READ_RS1_DATA != R_READ_RS2_DATA)
					E_BR_TAKEN = 'd1;
				else
					E_BR_TAKEN ='d0;
				3'h6: if(R_READ_RS1_DATA < R_READ_RS2_DATA)
					E_BR_TAKEN = 'd1;
				else
					E_BR_TAKEN ='d0;
				3'h7: if(R_READ_RS1_DATA >= R_READ_RS2_DATA) 
					E_BR_TAKEN = 'd1;
				else
					E_BR_TAKEN = 'd0;
				3'h4: if(S_RS1 < S_RS2)
					E_BR_TAKEN = 'd1;
				else
					E_BR_TAKEN ='d0;
				3'h5: if(S_RS1 >= S_RS2) 
					E_BR_TAKEN = 'd1;
				else
					E_BR_TAKEN = 'd0;
				default: E_BR_TAKEN ='d0;
			endcase
				E_ALU_RES = R_READ_RS1_DATA_mux + IMM;
				E_PC=pc;
				WBSEL='d0;
		end
		7'h67: begin
			E_ALU_RES = R_READ_RS1_DATA_mux + IMM;
			E_PC = pc;
			E_BR_TAKEN ='d0;
			WBSEL='d2;
		end
		7'h6F: begin
			E_ALU_RES = R_READ_RS1_DATA_mux + IMM;
			E_PC = pc;
			E_BR_TAKEN ='d0;
			WBSEL='d2;
		end
		default: begin
			case(FUNC37)
				4'h0: E_ALU_RES = R_READ_RS1_DATA_mux + R_READ_RS2_DATA_mux;
				4'h1: E_ALU_RES = R_READ_RS1_DATA_mux << R_READ_RS2_DATA_mux[4:0];
				4'h2: begin
					if(S_RS1_mux < S_RS2_mux)
						E_ALU_RES = 'd1;
					else
						E_ALU_RES = 'd0;
				end
				4'h3: begin
					if(R_READ_RS1=='d0 && R_READ_RS2=='d2 && R_READ_RS2_DATA_mux!='d0)
						E_ALU_RES = 'd1;
					else if(R_READ_RS1=='d0 && R_READ_RS2=='d2)
						E_ALU_RES = 'd0;
					else if(R_READ_RS1_DATA_mux < R_READ_RS2_DATA_mux)
						E_ALU_RES = 'd1;
					else
						E_ALU_RES = 'd0;
				end
				4'h4: E_ALU_RES = R_READ_RS1_DATA_mux ^ R_READ_RS2_DATA_mux;
				4'h5: E_ALU_RES = R_READ_RS1_DATA_mux >> R_READ_RS2_DATA_mux[4:0];
				4'h6: E_ALU_RES = R_READ_RS1_DATA_mux | R_READ_RS2_DATA_mux;
				4'h7: E_ALU_RES = R_READ_RS1_DATA_mux & R_READ_RS2_DATA_mux;
				4'h8: E_ALU_RES = R_READ_RS1_DATA_mux - R_READ_RS2_DATA_mux;
				4'hD: E_ALU_RES = S_RS1_mux >>> S_RS2_mux[4:0];
				default : E_ALU_RES ='d0;
			endcase
			E_PC = pc;
			E_BR_TAKEN ='d0;
			WBSEL='d1;
		end
	endcase

end

//Memory Stage Code
assign M_ADDRESS = E_ALU_RES; 
assign M_PC = pc;
assign M_RW = (OPCODE=='h23) ? 1'b1 : 1'b0;
assign M_SIZE_ENCODED = (OPCODE=='h23) ? FUNCT3[1:0] : 'd0;
dmemory dm(
	.clock(clock),
	.address(M_ADDRESS),
	.data_in(R_READ_RS2_DATA),
	.data_out(dout_dm),
	.access_size(M_SIZE_ENCODED),
	.read_write(M_RW)
);

always @(*)
begin
	case(OPCODE)
		7'h3: begin
			if(FUNCT3=='d0)
				dout_dm_int = (dout_dm[7])? {24'hFF_FFFF,dout_dm[7:0]} : {24'h0,dout_dm[7:0]};
			else if(FUNCT3=='d1)
				dout_dm_int = (dout_dm[15])? {16'hFFFF,dout_dm[15:0]} : {16'h0,dout_dm[15:0]};
			else if(FUNCT3=='d2)
				dout_dm_int = dout_dm;
			else if(FUNCT3=='d4)
				dout_dm_int = {24'h0,dout_dm[7:0]};
			else if(FUNCT3=='d5)
				dout_dm_int = {16'h0,dout_dm[15:0]};

		end
		default: dout_dm_int = dout_dm;
	endcase
end

assign M_DATA=dout_dm_int;

//Write back Stage Code
assign W_PC =pc;
assign W_ENABLE= ~(OPCODE=='h63 || OPCODE=='h23) ? 1'b1 : 1'b0;
assign W_DESTINATION= RD;
assign W_DATA = (WBSEL=='h0) ? M_DATA : ((WBSEL=='h1) ? E_ALU_RES : ((WBSEL=='h2) ? pc+4 : 'd0));
assign R_WRITE_ENABLE = W_ENABLE;
assign R_WRITE_DATA = W_DATA;
assign PC_SEL= (E_BR_TAKEN == 1'b1 || OPCODE==7'h67 || OPCODE==7'h6F) ? 1'b1 : 1'b0;

endmodule

