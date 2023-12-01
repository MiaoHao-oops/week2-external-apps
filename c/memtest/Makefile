CROSS_COMPILE=riscv64-linux-gnu-
CC=$(CROSS_COMPILE)gcc
OBJDUMP=$(CROSS_COMPILE)objdump
OBJCOPY=$(CROSS_COMPILE)objcopy

.PHONY: clean

all: c_memtest.bin c_memtest.S

c_memtest.bin: c_memtest.elf
	$(OBJCOPY) -O binary $< $@

c_memtest.elf: c_memtest.c
	$(CC) -fno-stack-protector $< -o $@

c_memtest.S: c_memtest.elf
	$(OBJDUMP) -D $< > $@

clean:
	rm -rf c_memtest.elf c_memtest.bin c_memtest.o c_memtest.s c_memtest.S
