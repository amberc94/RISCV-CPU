#paths

SRC_DIR = srcs/cpu/new
TB_DIR = srcs/cpu_tests/new
SIM_DIR = sim
LIB_DIR = lib/xilinx-vivado
SCRIPT_DIR = srcipts


TB_ENTITY = CPU_tb

.PHONY: all analyze elaborate run clean

all: clean analyze elaborate run

analyze:
	@mkdir -p $(SIM_DIR)
	cd $(SIM_DIR) && ghdl -i --std=08 -frelaxed-rules -P../$(LIB_DIR) ../$(SRC_DIR)/*.vhd && ghdl -m --std=08 -frelaxed-rules -P../$(LIB_DIR) CPU
	cd $(SIM_DIR) && ghdl -a --std=08 -frelaxed-rules -P../$(LIB_DIR) ../$(TB_DIR)/CPU_tb.vhd

elaborate:
	cd $(SIM_DIR) && ghdl -e --std=08 -frelaxed-rules -P../$(LIB_DIR) $(TB_ENTITY)

run:
	cd $(SIM_DIR) && ghdl -r --std=08 -frelaxed-rules -P../$(LIB_DIR) $(TB_ENTITY) --wave=waveform.ghw
	cd $(SIM_DIR) && gtkwave waveform.ghw &

clean:
	rm -rf $(SIM_DIR)
