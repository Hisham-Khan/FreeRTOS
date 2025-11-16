PROJ = boot
FREERTOS_PATH = ../FreeRTOS-Kernel
CPU ?= cortex-m3
BOARD ?= stm32vldiscovery
OBJ = boot.o \
	  start.o \
	  portFunctions.o \
	  ${FREERTOS_PATH}/tasks.o \
	  ${FREERTOS_PATH}/list.o \
	  ${FREERTOS_PATH}/portable/MemMang/heap_4.o \
	  ${FREERTOS_PATH}/portable/GCC/ARM_CM3/port.o \

CFLAGS = -mcpu=$(CPU) -mthumb -g -ffreestanding

INC = -I${FREERTOS_PATH}/portable/GCC/ARM_CM3/ \
	  -I${FREERTOS_PATH}/include/ \
	  -I./

.PHONY: all
all: $(PROJ).elf

%.o: %.S
	arm-none-eabi-as -mcpu=$(CPU) -mthumb -g -c $^ -o $@

%.o: %.c
	arm-none-eabi-gcc $(INC) $(CFLAGS) -c $^ -o $@

$(PROJ).elf: $(OBJ)
	arm-none-eabi-ld -Tmap.ld $^ -o $@
	arm-none-eabi-objdump -D -S $@ > $@.lst
	arm-none-eabi-readelf -a $@ > $@.debug
	qemu-system-arm -S -M $(BOARD) -cpu $(CPU) -nographic -kernel $(PROJ).elf -gdb tcp::1234

.PHONY: qemu
qemu: $(PROJ).elf
	qemu-system-arm -S -M $(BOARD) -cpu $(CPU) -nographic -kernel $(PROJ).elf -gdb tcp::1234

.PHONY: gdb
gdb:
	gdb-multiarch -q $(PROJ).elf -ex "target remote localhost:1234"

.PHONY: clean
clean:
	rm -rf *.out *.elf .gdb_history *.lst *.debug *.o *.bin *.elf.lst *.elf.debug