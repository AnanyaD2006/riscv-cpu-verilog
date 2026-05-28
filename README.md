# Single-Cycle RV32I RISC-V CPU

A fully functional single-cycle RISC-V processor implemented in Verilog, 
supporting the complete RV32I base integer instruction set.

## Features
- Implements all RV32I instruction types: R, I, S, B, U, J
- Sub-word memory access — byte, halfword, and word (lb/lh/lw/lbu/lhu/sb/sh/sw)
- Harvard architecture — separate instruction and data memory
- Synchronous data memory writes, combinational reads
- Verified via a hand-written RV32I assembly test suite covering all 47 instructions

## Module Structure
| File | Description |
|------|-------------|
| `t1c_riscv_cpu.v` | Top-level module — connects CPU, instruction memory, data memory |
| `riscv_cpu.v` | Single-cycle CPU core — controller + datapath |
| `data_mem.v` | Data RAM (64 × 32-bit), supports sub-word access |
| `instr_mem.v` | Instruction ROM (512 × 32-bit), loaded from .hex |
| `rv32i_test.s` | RV32I assembly test program |
| `rv32i_test.hex` | Assembled binary of test program |

## Tools
- Verilog (RTL design)
- Intel Quartus Prime
- ModelSim (simulation and verification)

## Architecture
Single-cycle design — every instruction completes in one clock cycle. 
The critical path runs through a load word (lw) instruction: 
PC → instruction memory → decode → register read → ALU → data memory → writeback.
