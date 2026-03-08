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
reg [31:0] ID_pc;
reg [31:0] ID_data_out;

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
reg [31:0] DX_pc;
reg [6:0] DX_OPCODE;
reg [4:0] DX_RD;
reg [4:0] DX_RS_1;
reg [4:0] DX_RS_2;
reg [2:0] DX_FUNCT3;
reg [6:0] DX_FUNCT7;
reg [31:0] DX_IMM;
reg [4:0] DX_SHAMT;
wire stall;

//Execute Stage Signals
wire R_WRITE_ENABLE;
wire [4:0] R_WRITE_DESTINATION;
wire [31:0] R_WRITE_DATA;
wire [4:0] R_READ_RS1;
wire [4:0] R_READ_RS2;
reg [31:0] R_READ_RS1_DATA;
reg [31:0] R_READ_RS2_DATA;
wire [31:0] R_READ_RS1_DATA_mux;
wire [31:0] R_READ_RS1_DATA_mux1;
wire [31:0] R_READ_RS2_DATA_mux;
wire [31:0] R_READ_RS2_DATA_mux1;
wire signed [31:0] S_RS1;
wire signed [31:0] S_RS1_mux;
wire signed [31:0] S_RS2;
wire signed [31:0] S_RS2_mux;
wire [3:0] FUNC37;
reg [31:0] E_PC;
reg [31:0] E_ALU_RES;
reg E_BR_TAKEN;
reg [31:0] XM_pc;
reg [31:0] XM_E_ALU_RES;
reg [6:0] XM_OPCODE;
reg [2:0] XM_FUNCT3;
reg [31:0] XM_R_READ_RS2_DATA;
wire [31:0] XM_R_READ_RS2_DATA_int;
reg [4:0] XM_RD;
reg [1:0] XM_WBSEL;
reg [4:0] XM_RS_2;
wire MX_BYP1;
wire MX_BYP2;
reg MX_BYP1_reg;
reg MX_BYP2_reg;
wire WM_BYP1;
wire WM_BYP2;

//Memory Stage Signals
wire [31:0] M_PC             ; 
wire [31:0] M_ADDRESS        ;   
wire M_RW             ;   
wire [1:0] M_SIZE_ENCODED   ;   
wire [31:0] M_DATA           ;  
reg [31:0] dout_dm;
reg [31:0] dout_dm_int;
reg [31:0] MW_pc;
reg [6:0] MW_OPCODE;
reg [4:0] MW_RD;
reg [1:0] MW_WBSEL;
reg [31:0] MW_M_DATA;
reg [31:0] MW_E_ALU_RES;
wire WM_BYP;

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

assign pc_mux= PC_SEL ? E_ALU_RES : (stall ? pc : pc+4);

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

//Pipeline Fetch Stage
always @(posedge clock)
begin
	if(reset)
	begin
		ID_pc<=32'h00000000;
		ID_data_out<='d0;
	end
	else if(stall)
	begin
		ID_pc<=ID_pc;
		ID_data_out<=ID_data_out;
	end
	else if(E_BR_TAKEN)
	begin
		ID_pc<=pc;
		ID_data_out<='d13;
	end
	else
	begin
		ID_pc <= pc;
		ID_data_out <=data_out;
	end
end

//Decode Stage Code
always @(ID_data_out)
begin
	case(ID_data_out[6:0])
		7'h17: IMMI = {ID_data_out[31:12],12'h0};
		7'h23: IMMI = ID_data_out[31] ? {20'hFFFFF,ID_data_out[31:25],ID_data_out[11:7]} : {20'h0,ID_data_out[31:25],ID_data_out[11:7]};
		7'h33: IMMI = 'd0;
		7'h37: IMMI = {ID_data_out[31:12],12'h0};
		7'h63: IMMI = ID_data_out[31] ? {20'hFFFFF,ID_data_out[7],ID_data_out[30:25],ID_data_out[11:8],1'b0} : {20'h0,ID_data_out[7],ID_data_out[30:25],ID_data_out[11:8],1'b0};
		7'h6F: IMMI = ID_data_out[31] ? {12'hFFF,ID_data_out[19:12],ID_data_out[20],ID_data_out[30:21],1'b0} : {12'h0,ID_data_out[19:12],ID_data_out[20],ID_data_out[30:21],1'b0};
		7'h73: IMMI = 'd0;
		default : IMMI = ID_data_out[31] ? {20'hFFFFF,ID_data_out[31:20]} : {20'h0,ID_data_out[31:20]};
	endcase

	OPCODE = ID_data_out[6:0];
	RD = ID_data_out[11:7];
	RS_1 = ID_data_out[19:15];
	RS_2 = ID_data_out[24:20];
	FUNCT3 = ID_data_out[14:12];
	FUNCT7 = ID_data_out[31:25];
	IMM = IMMI;
	SHAMT = ID_data_out[24:20];
end

//Stall Logic
assign stall=((DX_OPCODE == 7'h3) && ((RS_1 == DX_RD) || (RS_2 ==DX_RD)) && ((OPCODE != 7'h23) && (OPCODE!=7'h37))) || (OPCODE==7'h23 && RS_2==XM_RD && RS_2!=0) || ((MW_RD==RS_1) && (MW_RD!=0) && (MW_RD!=XM_RD) && (MW_RD!=DX_RD) && (OPCODE!=7'h37 && OPCODE!=7'h17 && OPCODE!=7'h6F && OPCODE!=7'h67) && (MW_OPCODE!=7'h63 && MW_OPCODE!=7'h23)) || ((MW_RD==RS_2) && (MW_RD!=0) && (MW_RD!=XM_RD) && (MW_RD!=DX_RD) && (OPCODE!=7'h13 && OPCODE!=7'h37 && OPCODE!=7'h17 && OPCODE!=7'h6F && OPCODE!=7'h67) && (MW_OPCODE!=7'h63 && MW_OPCODE!=7'h23)) ? 1 : 0;

//Pipeline Decode Stage
always @(posedge clock)
begin
	if(reset)
	begin
		DX_pc<=32'h00000000;
		DX_OPCODE<='d0;
		DX_RD<='d0;
		DX_RS_1<='d0;
		DX_RS_2<='d0;
		DX_FUNCT3<='d0;
		DX_FUNCT7<='d0;
		DX_IMM<='d0;
		DX_SHAMT<='d0;
	end
	else if(E_BR_TAKEN || stall)
	begin
		DX_pc<=ID_pc;
		DX_OPCODE<='d13;
		DX_RD<='d0;
		DX_RS_1<='d0;
		DX_RS_2<='d0;
		DX_FUNCT3<='d0;
		DX_FUNCT7<='d0;
		DX_IMM<='d0;
		DX_SHAMT<='d0;
	end
	else if(OPCODE==7'h37 || OPCODE==7'h17 || OPCODE==7'h6F)
	begin
		DX_pc<=ID_pc;
		DX_OPCODE<=OPCODE;
		DX_RD<=RD;
		DX_RS_1<='d0;
		DX_RS_2<='d0;
		DX_FUNCT3<=FUNCT3;
		DX_FUNCT7<=FUNCT7;
		DX_IMM<=IMM;
		DX_SHAMT<=SHAMT;
	end
	else if(OPCODE==7'h13 || OPCODE==7'h67 || OPCODE==7'h3)
	begin
		DX_pc<=ID_pc;
		DX_OPCODE<=OPCODE;
		DX_RD<=RD;
		DX_RS_1<=RS_1;
		DX_RS_2<='d0;
		DX_FUNCT3<=FUNCT3;
		DX_FUNCT7<=FUNCT7;
		DX_IMM<=IMM;
		DX_SHAMT<=SHAMT;
	end
	else if(OPCODE==7'h63 || OPCODE==7'h23)
	begin
		DX_pc<=ID_pc;
		DX_OPCODE<=OPCODE;
		DX_RD<='d0;
		DX_RS_1<=RS_1;
		DX_RS_2<=RS_2;
		DX_FUNCT3<=FUNCT3;
		DX_FUNCT7<=FUNCT7;
		DX_IMM<=IMM;
		DX_SHAMT<=SHAMT;
	end
	else 
	begin
		DX_pc<=ID_pc;
		DX_OPCODE<=OPCODE;
		DX_RD<=RD;
		DX_RS_1<=RS_1;
		DX_RS_2<=RS_2;
		DX_FUNCT3<=FUNCT3;
		DX_FUNCT7<=FUNCT7;
		DX_IMM<=IMM;
		DX_SHAMT<=SHAMT;
	end
end

//Execute Stage Code
assign R_READ_RS1 = DX_RS_1;
assign R_READ_RS2 = DX_RS_2;
assign R_WRITE_DESTINATION = DX_RD;

register_file regif(
	.clock(clock),
	.addr_rs1(R_READ_RS1),
	.addr_rs2(R_READ_RS2),
	.addr_rd(W_DESTINATION),
	.data_rd(R_WRITE_DATA),
	.data_rs1(R_READ_RS1_DATA),
	.data_rs2(R_READ_RS2_DATA),
	.write_enable(R_WRITE_ENABLE)
);


assign MX_BYP1= ((XM_RD == DX_RS_1) && (DX_RS_1 !=0)) ? 1 : 0;
assign MX_BYP2= ((XM_RD == DX_RS_2) && (DX_RS_2 !=0)) ? 1 : 0;
always @(posedge clock)
begin
	if (reset)
	begin
		MX_BYP1_reg <= 'd0;
		MX_BYP2_reg <= 'd0;
	end
	else begin
		MX_BYP1_reg <= MX_BYP1;
		MX_BYP2_reg <= MX_BYP2;
	end
end
assign WM_BYP1= ((MW_RD == DX_RS_1) && (DX_RS_1 !=0)) ? 1 : 0;
//assign WM_BYP1= ((MW_RD == DX_RS_1) && (~MX_BYP1_reg) && (DX_RS_1 !=0)) ? 1 : 0;
assign WM_BYP2= ((MW_RD == DX_RS_2) && (DX_RS_2 !=0)) ? 1 : 0;
//assign WM_BYP2= ((MW_RD == DX_RS_2) && (~MX_BYP2_reg) && (DX_RS_2 !=0)) ? 1 : 0;
//assign R_READ_RS1_DATA_mux1 = (DX_OPCODE==7'h63 || DX_OPCODE==7'h17 || DX_OPCODE==7'h6F) ? DX_pc : R_READ_RS1_DATA;
assign R_READ_RS1_DATA_mux1 = R_READ_RS1_DATA;
assign R_READ_RS2_DATA_mux1 = (DX_OPCODE==7'h13) ? DX_IMM : R_READ_RS2_DATA;
assign R_READ_RS1_DATA_mux = MX_BYP1 ? XM_E_ALU_RES : (WM_BYP1 ? W_DATA : R_READ_RS1_DATA_mux1);
assign R_READ_RS2_DATA_mux = MX_BYP2 ? XM_E_ALU_RES : (WM_BYP2 ? W_DATA : R_READ_RS2_DATA_mux1);	
assign FUNC37={DX_FUNCT7[5],DX_FUNCT3};
//Need to fix below inst
assign S_RS1 =R_READ_RS1_DATA;
assign S_RS1_mux =R_READ_RS1_DATA_mux;
assign S_RS2=R_READ_RS2_DATA;
assign S_RS2_mux=R_READ_RS2_DATA_mux;


always @(*)
begin
	case(DX_OPCODE)
		7'h3: begin
			E_ALU_RES = R_READ_RS1_DATA_mux + DX_IMM;
			E_PC = DX_pc;
			E_BR_TAKEN ='d0;
			WBSEL='d0;
		end
		7'h13: begin
			case(DX_FUNCT3)
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
			E_PC = DX_pc;
			E_BR_TAKEN ='d0;
			WBSEL='d1;
		end
		7'h17: begin
			E_ALU_RES = DX_pc + DX_IMM;
			E_PC = DX_pc;
			E_BR_TAKEN ='d0;
			WBSEL='d1;
		end
		7'h23: begin
			E_ALU_RES = R_READ_RS1_DATA_mux + DX_IMM;
			E_PC = DX_pc;
			E_BR_TAKEN ='d0;
			WBSEL='d0;
		end
		7'h37: begin
			E_ALU_RES = DX_IMM;
			E_PC = DX_pc;
			E_BR_TAKEN ='d0;
			WBSEL='d1;
		end
		7'h63: begin
			case(DX_FUNCT3)
				3'h0: if(R_READ_RS1_DATA_mux == R_READ_RS2_DATA_mux)
					E_BR_TAKEN = 'd1;
				else 
					E_BR_TAKEN ='d0;
				3'h1: if(R_READ_RS1_DATA_mux != R_READ_RS2_DATA_mux)
					E_BR_TAKEN = 'd1;
				else
					E_BR_TAKEN ='d0;
				3'h6: if(R_READ_RS1_DATA_mux < R_READ_RS2_DATA_mux)
					E_BR_TAKEN = 'd1;
				else
					E_BR_TAKEN ='d0;
				3'h7: if(R_READ_RS1_DATA_mux >= R_READ_RS2_DATA_mux) 
					E_BR_TAKEN = 'd1;
				else
					E_BR_TAKEN = 'd0;
				3'h4: if(S_RS1_mux < S_RS2_mux)
					E_BR_TAKEN = 'd1;
				else
					E_BR_TAKEN ='d0;
				3'h5: if(S_RS1_mux >= S_RS2_mux) 
					E_BR_TAKEN = 'd1;
				else
					E_BR_TAKEN = 'd0;
				default: E_BR_TAKEN ='d0;
			endcase
				//E_ALU_RES = R_READ_RS1_DATA_mux + DX_IMM;
				E_ALU_RES = DX_pc + DX_IMM;
				E_PC=DX_pc;
				WBSEL='d0;
		end
		7'h67: begin
			E_ALU_RES = R_READ_RS1_DATA_mux + DX_IMM;
			E_PC = DX_pc;
			E_BR_TAKEN ='d1;
			WBSEL='d2;
		end
		7'h6F: begin
			//E_ALU_RES = R_READ_RS1_DATA_mux + DX_IMM;
			E_ALU_RES = DX_pc + DX_IMM;
			E_PC = DX_pc;
			E_BR_TAKEN ='d1;
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
			E_PC = DX_pc;
			E_BR_TAKEN ='d0;
			WBSEL='d1;
		end
	endcase

end

//Branch Prediction
assign PC_SEL= (E_BR_TAKEN == 1'b1 || DX_OPCODE==7'h67 || DX_OPCODE==7'h6F) ? 1'b1 : 1'b0;

//Pipeline Execute Stage
always @(posedge clock)
begin
	if(reset)
	begin
		XM_pc<=32'h00000000;
		XM_E_ALU_RES<='d0;
		XM_OPCODE<='d0;
		XM_FUNCT3<='d0;
		XM_R_READ_RS2_DATA<='d0;
		XM_RS_2<='d0;
	end
	else
	begin
		XM_pc<=E_PC;
		XM_E_ALU_RES<=E_ALU_RES;
		XM_OPCODE<=DX_OPCODE;
		XM_FUNCT3<=DX_FUNCT3;
		XM_R_READ_RS2_DATA<=R_READ_RS2_DATA;
		XM_RD<=DX_RD;
		XM_WBSEL<=WBSEL;
		XM_RS_2<=DX_RS_2;
	end
end

//Memory Stage Code
assign WM_BYP= ((MW_RD == XM_RS_2) && (XM_RS_2 !=0)) ? 1 : 0;
assign M_ADDRESS = XM_E_ALU_RES; 
assign M_PC = XM_pc;
assign M_RW = (XM_OPCODE=='h23) ? 1'b1 : 1'b0;
assign M_SIZE_ENCODED = (XM_OPCODE=='h23) ? XM_FUNCT3[1:0] : 'd0;
assign XM_R_READ_RS2_DATA_int = WM_BYP ? W_DATA : XM_R_READ_RS2_DATA;
dmemory dm(
	.clock(clock),
	.address(M_ADDRESS),
	.data_in(XM_R_READ_RS2_DATA_int),
	.data_out(dout_dm),
	.access_size(M_SIZE_ENCODED),
	.read_write(M_RW)
);

always @(*)
begin
	case(XM_OPCODE)
		7'h3: begin
			if(XM_FUNCT3=='d0)
				dout_dm_int = (dout_dm[7])? {24'hFF_FFFF,dout_dm[7:0]} : {24'h0,dout_dm[7:0]};
			else if(XM_FUNCT3=='d1)
				dout_dm_int = (dout_dm[15])? {16'hFFFF,dout_dm[15:0]} : {16'h0,dout_dm[15:0]};
			else if(XM_FUNCT3=='d2)
				dout_dm_int = dout_dm;
			else if(XM_FUNCT3=='d4)
				dout_dm_int = {24'h0,dout_dm[7:0]};
			else if(XM_FUNCT3=='d5)
				dout_dm_int = {16'h0,dout_dm[15:0]};

		end
		default: dout_dm_int = dout_dm;
	endcase
end

assign M_DATA=dout_dm_int;

//Pipeline Memory Stage
always @(posedge clock)
begin
	if(reset)
	begin
		MW_pc<=32'h00000000;
		MW_OPCODE<='d0;
		MW_RD<='d0;
		MW_WBSEL<='d0;
		MW_M_DATA<='d0;
		MW_E_ALU_RES<='d0;
	end
	else
	begin
		MW_pc<=XM_pc;
		MW_OPCODE<=XM_OPCODE;
		MW_RD<=XM_RD;
		MW_WBSEL<=XM_WBSEL;
		MW_M_DATA<=M_DATA;
		MW_E_ALU_RES<=XM_E_ALU_RES;
	end
end

//Write back Stage Code
assign W_PC =MW_pc;
assign W_ENABLE= ~(MW_OPCODE=='h63 || MW_OPCODE=='h23) ? 1'b1 : 1'b0;
assign W_DESTINATION=MW_RD;
assign W_DATA = (MW_WBSEL=='h0) ? MW_M_DATA : ((MW_WBSEL=='h1) ? MW_E_ALU_RES : ((MW_WBSEL=='h2) ? MW_pc+4 : 'd0));
assign R_WRITE_ENABLE = W_ENABLE;
assign R_WRITE_DATA = W_DATA;
//Need to add pipeline registers for write back stage for register writes
//Also think about placing PC_SEL in EXecution stage so that branch
//prediction get easier.
endmodule

