A primitive single-cycle RISCV CPU core in VHDL. Implements exclusively the rv32i ISA. No CSR, no I/O, no UART, ebreak just halts the CPU testbench. 

No AI was used in this project.

Requirements:
- ghdl (tested with 7.0.0-dev)
- riscv64-gnu-toolchain (tested with 16.1.0) NOTE: you gotta build it yourself with -march=rv32i because the multilib packages don't respect the flag and create compressed opcodes
- vivado (tested with 2019.2)
- gtkwave (tested with 3.3121)

To Run:
-~~compile xilinx vendor libraries using the ghdl vendor scrips and place them in lib/ (only needs to be done once)~~ no longer required
- run scripts/compile-asm.sh on a test risc assembly file and copy the resultant *.txt to ROM.txt in src/cpu/
- `make`
- check sim/waveform.ghw in gtkwave and see if DEBUG_OUTPUT matches your expectations
- to run tests, run `CONFIG_FILES=/path/to/test_config.yaml make` in your clone of riscv-arch-tests, then copy your elfs from the work folder to src/tests. run `convert-tests.sh` to convert elfs to hexdump and `run-tests.sh' to run them (with the paths in each script updated). test output will be in sim/test.txt (FFFFFFFF is successful, 11111111 or nothing is fail) 

To Do:
- fully implement CSR and Zicsr
- implement UART
- integrate with official riscv testing framework (31 of 39 passed as of Nov 12 2026)
- run on Basys 3 FPGA
