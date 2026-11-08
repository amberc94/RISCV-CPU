#paths

SRC_DIR = srcs/cpu/new
TB_DIR = srcs/cpu_tests/new
SIM_DIR = sim

TB_ENTITY = CPU_tb

.PHONY: all analyze elaborate run clean

all: clean analyze elaborate run

analyze:
	@mkdir -p $(SIM_DIR)
	cd $(SIM_DIR) && ghdl -i ../$(SRC_DIR)/*.vhd && ghdl -m -P../$(SRC_DIR)/xilinx-vivado CPU 
	cd $(SIM_DIR) && ghdl -a -P../$(SRC_DIR)/xilinx-vivado ../$(TB_DIR)/CPU_tb.vhd

elaborate:
	cd $(SIM_DIR) && ghdl -e -P../$(SRC_DIR)/xilinx-vivado $(TB_ENTITY)

run:
	cd $(SIM_DIR) && ghdl -r -P../$(SRC_DIR)/xilinx-vivado $(TB_ENTITY) --wave=waveform.ghw

clean:
	rm -rf $(SIM_DIR)
