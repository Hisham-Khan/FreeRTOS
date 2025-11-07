PROJ = boot
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
	arm-none-eabi-as -mthumb -mcpu=$(CPU) -g -c $(PROJ).S -o $(PROJ).o
	arm-none-eabi-ld -Tmap.ld $(PROJ).o -o $(PROJ).elf
	arm-none-eabi-objdump -D -S $(PROJ).elf > $(PROJ).elf.lst
	arm-none-eabi-objcopy -O binary $(PROJ).elf $(PROJ).bin
	arm-none-eabi-readelf -a $(PROJ).elf > $(PROJ).elf.debug
	qemu-system-arm -S -M $(BOARD) -cpu $(CPU) -nographic -kernel $(PROJ).elf -gdb tcp::1234

gdb:
	gdb-multiarch -q $(PROJ).elf -ex "target remote localhost:1234"

clean:
	rm -rf *.out *.elf .gdb_history *.lst *.debug *.o *.bin