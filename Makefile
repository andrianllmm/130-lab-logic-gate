# Automates compilation, simulation, waveform generation,
# and cleanup for the access control Verilog project.

SRC = src/access_control.v    # Design source file
TB  = tb/tb_access_control.v  # Testbench file
SIM_DIR = sim                 # Simulation output directory

OUT = $(SIM_DIR)/run.vvp      # Compiled simulation executable
VCD = $(SIM_DIR)/dump.vcd     # Waveform output file

# Default target
all: run

# Create simulation directory if not exists
setup:
	mkdir -p $(SIM_DIR)

# Compile Verilog source and testbench
compile: setup
	iverilog -o $(OUT) $(SRC) $(TB)

# Run simulation (console output only)
run: compile
	vvp $(OUT)

# Run simulation and open waveform viewer
wave: compile
	vvp $(OUT)
	gtkwave $(VCD)

# Remove compiled and waveform files
clean:
	rm -rf $(SIM_DIR)/*.vvp $(SIM_DIR)/*.vcd

# Full reset
reset: clean
	rm -rf $(SIM_DIR)

# Prevent conflicts with files named like targets
.PHONY: all setup compile run wave clean reset
