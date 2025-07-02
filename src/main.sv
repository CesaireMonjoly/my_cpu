/*
================SPEC================

4 non-specified 12-bits registers
A : 000
B : 001
C : 010
D : 011

User Stack :
    Comme une stack calssique 

    Pointeur de stack SP 100
    Pointeur de base BP 101

Branch Stack :
    On push les address que le pipeline doit prendre quand on call JUMP_IF_E, avec l'instruction PUSH_BRANCH
    On évites de mettre PUSH_BRANCH dans une boucle for, on la met avant et on pop quand on sort de la boucle for
    e.g.

    for(int i = 0;i < 5; i++){
        for(int j = 0; j < 7 ;j++){
            //do sometinhg...
        }
    }

    PUSH_BRANCH second_label
    PUSH_BRANCH first_label

    XOR C, C
    first_label :
        XOR D, D
    second_label :
        //do something...
        ADD D, 1
        MOV A, D
        SUB A, 5
        JUMP_IF_POS second_label
    
        ADD C, 1
        MOV A, C
        SUB A, 7
        JUMP_IF_POS first_label

    (est-ce qu'on pop auto quand la branch est pas prise ou on laisse la liberté a l'utilisateur de le faire a la main ?)

    Pointeur de stack B_SP 110
    Poitneur de base B_BP 111

*/

/*
================Instructions================
*/

`include "src/instructions.sv"
`include "src/decoder.sv"
`include "src/alu.sv"
`include "src/memory.sv"

module core (
        input CLK,
        input RESET,
        output [4:0] LEDS,
        input RXD,
        output TXD
    );

    //State machine
    localparam FETCH = 3'd0;
    localparam DECODE = 3'd1;
    localparam EXEC = 3'd2;
    localparam WRITE_BACK = 3'd3;
    localparam INCR_PC = 3'd4;


    wire clk;
    wire resetn;
    reg [2:0] state;
    reg [11:0] program_counter;
    reg [11:0] current_instruction;
    
    reg [11:0] registers [0:3];
    

    reg [11:0] branch_stack_pointer;
    reg [11:0] branch_base_pointer;



    //ALU=================
    logic [11:0] alu_output;
    logic [11:0] alu_reg_a;
    logic [11:0] alu_reg_b;
    logic [2:0] alu_func_code;
    wire alu_carry_out;
    wire alu_equ_out;
    wire alu_overflow;
 
    alu core_alu (
        .a_in(alu_reg_a),
        .b_in(alu_reg_b),
        .carry_in(alu_carry_in),
        .func_code(alu_func_code),
        .a_out(alu_output),
        .carry_out(alu_carry_out),
        .equ_out(alu_equ_out),
        .overflow_out(alu_overflow)
    );
    //=====================





    //Decoder==============
    logic [11:0] dec_opcode;
    wire [3:0] dec_operation_type;
    wire [2:0] dec_reg_a;
    wire [2:0] dec_reg_b;
    wire [11:0] dec_addr;
    wire [2:0] dec_instruction_type;
    wire [2:0] dec_sub_instruction;

    decoder core_decoder (
        .clk(clk),
        .opcode(dec_opcode),
        .reg_a(dec_reg_a),
        .reg_b(dec_reg_b),
        .instruction_type(dec_instruction_type),
        .sub_instruction(dec_sub_instruction)
    );
    //=====================




    //Main Memory=========
    logic [11:0] mem_addr;
    logic mem_write_enable;
    logic [11:0] mem_data_in;
    wire [11:0] mem_data_out;

    memory #(
        .SIZE(255)
    ) main_memory (
        .clk(clk),
        .addr(mem_addr),
        .write_enable(mem_write_enable),
        .data_in(mem_data_in),
        .data_out(mem_data_out)
    );
    //====================





    //User Stack==========
    reg [11:0] stack_pointer;
    reg [11:0] base_pointer;

    reg stack_write_enable;
    reg [11:0] stack_in;
    reg [11:0] stack_out;

    memory #(
        .SIZE(64)
    ) user_stack (
        .clk(clk),
        .addr(stack_pointer),
        .write_enable(stack_write_enable),
        .data_in(stack_in),
        .data_out(stack_out)
    );
    //====================

    always @ (posedge clk) begin
        case (state)
            FETCH : begin
                mem_addr <= program_counter;
                current_instruction <= mem_data_out;
                state <= DECODE;
            end
            DECODE : begin
                dec_opcode <= current_instruction;
                state <= EXEC;
            end
            EXEC : begin
                case (instruction_type) 
                    ALU_INSTRUCTION : begin

                    end
                    JUMP_INSTRUCTION : begin

                    end
                    MEM_MAN_INSTRUCTION : begin

                    end
                    DIRECT_JUMP begin :

                    end
                endcase

                state <= WRITE_BACK;
            end
            WRITE_BACK : begin
                case (instruction_type) 
                    ALU_INSTRUCTION : begin

                    end
                    JUMP_INSTRUCTION : begin

                    end
                    MEM_MAN_INSTRUCTION : begin

                    end
                    DIRECT_JUMP begin :

                    end
                endcase
                state <= INCR_PC;
            end
            INCR_PC : begin
                program_counter <= program_counter + 1;
                state <= FETCH;
            end
            default : begin
                state <= FETCH;
            end
        endcase
    end
endmodule

