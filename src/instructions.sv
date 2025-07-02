`ifndef INSTURCTIONS_V
`define INSTURCTIONS_V

//ALU //incr/decr ? 
`define ADD 6'd0       
`define SUB 6'd1       
`define ROT_L 6'd2     
`define ROT_R 6'd3     
`define XOR 6'd4       
`define AND 6'd5       
`define OR 6'd6        
`define NOT 6'd7       


//pipline jump to the last address pushed on the branch stack (i.e. [B_SP])
`define JUMP_IF_E 6'd8//take the jump if equ_flag is 1
`define JUMP_IF_NE 6'd9//take the jump if equ_flag is 0
`define JUMP_IF_POS 6'd10//take the jump if sign_flag is 1
`define JUMP_IF_NEG 6'd11//take the jump if sign_flag is 0

`define B_JUMP_IF_E 6'd12//take the jump if equ_flag is 1
`define B_JUMP_IF_NE 6'd13//take the jump if equ_flag is 0
`define B_JUMP_IF_POS 6'd14//take the jump if sign_flag is 1
`define B_JUMP_IF_NEG 6'd15//take the jump if sign_flag is 0

//MEM MANGEMENT (STACK & REGISTERS)
`define PUSH 6'd16 
`define POP 6'd17
`define PUSH_BRANCH 6'd18 
`define POP_BRANCH 6'd19    

`define MOV_R_R 6'd20
`define MOV_A_R 6'd21
`define MOV_R_A 6'd22
`define MOV_A_A 6'd23


//DIRECT_JMP and NOP
`define JUMP 6'd24         
`define NOP 6'd25


//INSTRUCTION TYPE
`define ALU_INSTRUCTION 2'd0
`define JUMP_INSTRUCTION 2'd1
`define MEM_MAN_INSTRUCTION 2'd2
`define DIRECT_JUMP 2'd3

`endif
