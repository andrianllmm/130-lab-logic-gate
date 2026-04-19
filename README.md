# CMSC130 Lab - Access Control System

## Description

This project implements a simple access control system using Verilog logic gates.

## Inputs

- Y = You
- S = SO
- P = Parents
- L = Siblings
- T = Pet

## Outputs

- A = Money
- B = Car Key
- C = Bitcoin Wallet

## Project Structure

```
src/  Verilog design (RTL)
tb/   Testbench and verification
sim/  Simulation outputs (VCD, VVP)
```

## Requirements

- Icarus Verilog (`iverilog`)
- GTKWave (for waveform viewing)
- GNU Make (optional but recommended)
- VSCode with Digital IDE extension (optional but recommended)

## How to run

```sh
make run
```

or

```sh
iverilog -o sim/run.vvp src/access_control.v tb/tb_access_control.v
vvp sim/run.vvp
gtkwave sim/dump.vcd
```

See the [Makefile](Makefile) for the complete list of commands.
