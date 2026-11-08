FILENAME="${1%.*}"
riscv64-unknown-elf-gcc -march=rv32i -mabi=ilp32 -nostdlib $FILENAME.s -o $FILENAME.out
riscv64-unknown-elf-objcopy --reverse-bytes=4 -O binary $FILENAME.out $FILENAME.bin
xxd -p -c 4 $FILENAME.bin > $FILENAME.txt
rm $FILENAME.bin $FILENAME.out
