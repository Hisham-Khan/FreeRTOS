PROJ = main
OBJ = boot.o
CPU ?= cortex-m3
BOARD ?= stm32vldiscovery

%.o: %.S
	arm-none-eabi-as -mcpu=$(CPU) -mthumb -g -c $^ -o $@

.PHONY: all
all: $(PROJ).elf

# %.o: %.c
# 	arm-none-eabi-gcc $(INC) -mcpu=$(CPU) -mthumb -g -c $^ -o $@

$(PROJ).elf: $(OBJ)
	arm-none-eabi-ld -Tmap.ld $^ -o $@
	arm-none-eabi-objdump -D -S $@ > $@.lst
	arm-none-eabi-readelf -a $@ > $@.debug

qemu:
	qemu-system-arm -M $(BOARD) -cpu $(CPU) -nographic -kernel $(PROJ).elf -gdb tcp::1234

gdb:
	gdb-multiarch -q $(PROJ).elf -ex "target remote localhost:1234"

clean:
	rm -f $(OBJ) *.elf *.lst *.debug *.out *.gdb_history