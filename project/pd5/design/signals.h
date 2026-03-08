
/* Your Code Below! Enable the following define's 
 * and replace ??? with actual wires */
// ----- signals -----
// You will also need to define PC properly
`define F_PC                pc
`define F_INSN              data_out

`define D_PC                ID_pc
`define D_OPCODE            OPCODE
`define D_RD                RD
`define D_RS1               RS_1
`define D_RS2               RS_2
`define D_FUNCT3            FUNCT3
`define D_FUNCT7            FUNCT7
`define D_IMM               IMM
`define D_SHAMT             SHAMT

`define R_WRITE_ENABLE      R_WRITE_ENABLE
`define R_WRITE_DESTINATION R_WRITE_DESTINATION
`define R_WRITE_DATA        R_WRITE_DATA
`define R_READ_RS1          R_READ_RS1
`define R_READ_RS2          R_READ_RS2
`define R_READ_RS1_DATA     R_READ_RS1_DATA
`define R_READ_RS2_DATA     R_READ_RS2_DATA

`define E_PC                DX_pc
`define E_ALU_RES           E_ALU_RES
`define E_BR_TAKEN          E_BR_TAKEN

`define M_PC                XM_pc
`define M_ADDRESS           M_ADDRESS
`define M_RW                M_RW
`define M_SIZE_ENCODED      M_SIZE_ENCODED
`define M_DATA              M_DATA

`define W_PC                MW_pc
`define W_ENABLE            W_ENABLE
`define W_DESTINATION       W_DESTINATION
`define W_DATA              W_DATA

// ----- signals -----

// ----- design -----
`define TOP_MODULE                 pd
// ----- design -----
