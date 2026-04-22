# CMSC 130 Lab - Access Control System

## Description

This project implements a combinational logic-based access control system using Verilog HDL. It evaluates access permissions for three secure compartments based on five users using Boolean logic.

The system is designed, simulated, and verified using Icarus Verilog and GTKWave.

---

## Inputs

Each input represents a user:

- **Y** = You (primary user)
- **S** = SO (significant other)
- **P** = Parents
- **L** = Siblings
- **T** = Pet

---

## Outputs

Each output represents a secured compartment:

- **A** = Money access
- **B** = Car key access
- **C** = Bitcoin wallet access

Each output is determined by predefined Boolean expressions combining user permissions.

---

## Project Structure

```
src/  # Verilog RTL design (access control logic)
tb/   # Testbench for functional verification
sim/  # Simulation outputs (VCD waveform, compiled VVP file)
```

---

## Requirements

- Icarus Verilog (`iverilog`) - compilation and simulation
- GTKWave - waveform visualization
- GNU Make - build automation (recommended)
- VS Code - development environment (optional)

---

## Build and Run Instructions

### Using Makefile (recommended)

Compile and run simulation:

```sh
make run
```

View waveform:

```sh
make wave
```

Clean generated files:

```sh
make clean
```

Full reset:

```sh
make reset
```

---

### Manual Execution

Compile:

```sh
iverilog -o sim/run.vvp src/access_control.v tb/tb_access_control.v
```

Run simulation:

```sh
vvp sim/run.vvp
```

View waveform:

```sh
gtkwave sim/dump.vcd
```
