SECONDS=0
shopt -s nullglob

rm /home/amber/RISCV-CPU/sim/test.txt
touch /home/amber/RISCV-CPU/sim/test.txt

for file in /home/amber/RISCV-CPU/src/tests/*.txt; do
	if [[ -f "$file" ]]; then
		cp "$file" /home/amber/RISCV-CPU/src/cpu/ROM.txt
		cd /home/amber/RISCV-CPU
		echo "$file" >> /home/amber/RISCV-CPU/sim/test.txt 

		make
	fi
done
duration=$SECONDS
tests=$(grep -c "FFFFFFFF" "/home/amber/RISCV-CPU/sim/test.txt)"
echo "Elapsed time: $((duration/60)):$((duration % 60))"
echo "Tests passed: $tests"
