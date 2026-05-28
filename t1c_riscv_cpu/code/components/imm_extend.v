
// imm_extend.v - logic for sign extension
module imm_extend (
    input  [31:0]     instr, // instruction bits
    input  [ 1:0]     immsrc,
    output reg [31:0] immext
);

// Define opcodes to make the logic clear
localparam OPCODE_I_IMM = 7'b0010011; // For addi, slli, etc.
localparam OPCODE_LOAD  = 7'b0000011; // For lw, lh, etc.
localparam OPCODE_JALR  = 7'b1100111; // For jalr

always @(*) begin
    case(immsrc)
        // I−type
        2'b00: begin
            // This condition is now specific to SHIFT instructions by checking the opcode.
            if ((instr[6:0] == OPCODE_I_IMM) && (instr[14:12] == 3'b001 || instr[14:12] == 3'b101)) begin
                // This is a true shift (slli, srli, srai)
                immext = {{27{1'b0}}, instr[24:20]};
            end else begin
                // This is any other I-type (addi, slti, lw, lh, lhu, jalr)
                immext = {{20{instr[31]}}, instr[31:20]};
            end
        end
        // S−type (stores)
        2'b01:   immext = {{20{instr[31]}}, instr[31:25], instr[11:7]};
        // B−type (branches)
        2'b10:   immext = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};
        // J−type (jal)
        2'b11:   immext = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};
        default: immext = 32'bx; // undefined
    endcase
end

endmodule
