# 4-bit CPU in Verilog

A complete 4-bit single-cycle CPU designed and verified from first principles in Verilog — built up from individual logic gates through a full custom instruction set architecture (ISA), simulated end-to-end with Icarus Verilog.

## Overview

This project implements a small but genuinely complete CPU: an 8-instruction ISA, a 4-register file, a 5-operation ALU, a program counter, instruction memory, and a control unit, all wired into a working single-cycle datapath. Every module was built and independently verified in simulation before integration, and the full CPU has been tested against multiple hand-assembled programs exercising arithmetic, bitwise logic, and control (halt) instructions.

## Architecture

```
program counter → instruction memory → ┬→ control unit  ┐
                                        └→ register file ┘→ ALU → write-back → (register file)
```

- **Program counter** — 4-bit, increments each clock cycle, freezes on `HLT`, resets to 0.
- **Instruction memory** — 16 × 12-bit ROM, addressed directly by the program counter.
- **Control unit** — decodes the 4-bit opcode into control signals (register write enable, write-back source select, ALU operation, halt, output enable).
- **Register file** — 4 registers (R0–R3), dual read ports (simultaneous Rd/Rs read), single write port.
- **ALU** — 4-bit, supports ADD, SUB (via two's complement), AND, OR, XOR, with carry and zero flags. Built from a hand-designed ripple-carry adder composed of four 1-bit full adders.
- **Write-back mux** — selects between the ALU result and the immediate field to write into the register file, depending on instruction type.

## Instruction set

12-bit fixed-width instruction format: `opcode[11:8] | dest[7:6] | src[5:4] | immediate[3:0]`

| Opcode | Mnemonic | Operation | Fields used |
|---|---|---|---|
| `0000` | HLT | Stop execution | — |
| `0001` | LOAD Rd, #imm | `Rd = imm` | dest, immediate |
| `0010` | ADD Rd, Rs | `Rd = Rd + Rs` | dest, src |
| `0011` | SUB Rd, Rs | `Rd = Rd - Rs` | dest, src |
| `0100` | AND Rd, Rs | `Rd = Rd & Rs` | dest, src |
| `0101` | OR Rd, Rs | `Rd = Rd \| Rs` | dest, src |
| `0110` | XOR Rd, Rs | `Rd = Rd ^ Rs` | dest, src |
| `0111` | OUT Rd | Print Rd's value | dest |

Registers are addressed with 2 bits: `00`=R0, `01`=R1, `10`=R2, `11`=R3.

## Repository structure

```
src/    — synthesizable hardware modules (the actual circuit)
tb/     — testbenches (simulation-only test rigs, never synthesized)
docs/   — architecture diagram
```

## Building and running

Requires [Icarus Verilog](http://bleyer.org/icarus/) and (optionally) [GTKWave](http://gtkwave.sourceforge.net/) for waveform inspection.

Compile and run the full CPU:

```bash
iverilog -o cpu_sim src/full_adder.v src/adder4.v src/alu.v src/register4.v \
    src/register_file.v src/program_counter.v src/instruction_memory.v \
    src/control_unit.v src/cpu.v tb/cpu_tb.v
vvp cpu_sim
```

Individual modules can be compiled and tested in isolation using their matching testbench in `tb/` — e.g.:

```bash
iverilog -o alu_sim src/full_adder.v src/adder4.v src/alu.v tb/alu_tb.v
vvp alu_sim
```

View any generated `.vcd` waveform with:

```bash
gtkwave <name>.vcd
```

## Sample program and output

The default program in `instruction_memory.v`:

```
LOAD R0, #5
LOAD R1, #3
ADD  R0, R1
OUT  R0
HLT
```

Output:

```
OUT:  8
CPU halted.
```

The CPU has also been verified against additional hand-assembled programs exercising `SUB` (including two's-complement wraparound) and `XOR`, each producing correct results and halting cleanly.

## What this project demonstrates

- Combinational logic design (adders, ALU, multiplexers) built up from individual logic gates
- Sequential logic design (D flip-flops, clocked registers, a register file with reset)
- A custom-designed instruction set architecture and fixed-width instruction encoding
- A control unit implementing instruction decode via opcode-to-control-signal translation
- Full datapath integration into a working single-cycle CPU
- Testbench-driven verification methodology, with a testbench for every module, independent of the synthesizable design
- Waveform-based debugging using GTKWave

## Possible extensions

- Conditional jumps (`JMP`, `JZ`) using the ALU's zero flag and reserved opcode space (`1000`–`1111`)
- A larger register file or wider data path
- A simple assembler to convert human-readable mnemonics into instruction memory contents automatically
- Synthesis onto real FPGA hardware
