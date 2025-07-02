`ifndef DECODER_V
`define DECODER_V

`include "src/instructions.sv"

module decoder (
        input clk,
        input logic [11:0] opcode,
        output [2:0] reg_a,
        output [2:0] reg_b,
        output [2:0] instruction_type,
        output [2:0] sub_instruction
    );
    assign instruction_type = opcode[11:9];
    assign sub_instruction = opcode[8:6];
    assign reg_a = opcode[5:3];
    assign reg_b = opcode[2:0];

endmodule

`endif
