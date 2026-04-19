SRC = src/access_control.v
TB  = tb/tb_access_control.v
SIM_DIR = sim

OUT = $(SIM_DIR)/run.vvp
VCD = $(SIM_DIR)/dump.vcd

all: run

setup:
	mkdir -p $(SIM_DIR)

compile: setup
	iverilog -o $(OUT) $(SRC) $(TB)

run: compile
	vvp $(OUT)

wave: compile
	vvp $(OUT)
	gtkwave $(VCD)

clean:
	rm -rf $(SIM_DIR)/*.vvp $(SIM_DIR)/*.vcd

reset: clean
	rm -rf $(SIM_DIR)

.PHONY: all setup compile run wave clean reset
