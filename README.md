A primitive single-cycle RISCV CPU core in VHDL. Implements exclusively the rv32i ISA. No CSR, no I/O, no UART, ebreak just halts the CPU testbench. 

No AI was used in this project.

Requirements:
- ghdl (tested with 7.0.0-dev)
- riscv64-gnu-toolchain (tested with 16.1.0) NOTE: you gotta build it yourself with -march=rv32i because the multilib packages don't respect the flag and create compressed opcodes
- vivado (tested with 2019.2)
- gtkwave (tested with 3.3121)

To Run:
- compile xilinx vendor libraries using the ghdl vendor scrips and place them in lib/ (only needs to be done once)
- run scripts/compile-asm.sh on a test risc assembly file and copy the resultant *.txt to ROM.txt in src/cpu/
- `make`
- check sim/waveform.ghw in gtkwave and see if DEBUG_OUTPUT matches your expectations

To Do:
- fully implement CSR and Zicsr
- implement UART
- integrate with official riscv testing framework (21 of 39 passed as of Nov 10 2026)
- run on Basys 3 FPGA
