shopt -s nullglob


for file in /home/amber/RISCV-CPU/src/tests/*.elf; do
	if [[ -f "$file" ]]; then
		FILENAME="${file%.*}"
		riscv64-unknown-elf-objcopy -O binary $file  $FILENAME.bin
		xxd -p -c 1  $FILENAME.bin > $FILENAME.txt
		rm $FILENAME.bin 
	fi
done
