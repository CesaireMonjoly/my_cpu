`ifndef MEMORY_SV
`define MEMORY_SV

module memory #(parameter SIZE = 64) (
        input clk,
        input logic [11:0] addr,
        input logic write_enable,
        input logic [11:0] data_in ,
        output logic [11:0] data_out 
    );

    reg [0:11] ram [0:SIZE-1]; 
    reg [0:11] addr_reg;

    assign data_out = ram[addr_reg];

    always @(posedge clk) begin
        if(write_enable) begin
            ram[addr] <= data_in;
        end
        else begin
            addr_reg <= addr;
        end
    end
endmodule

`endif
