CROSS_COMPILE=riscv64-linux-gnu-
CC=$(CROSS_COMPILE)gcc
OBJDUMP=$(CROSS_COMPILE)objdump
OBJCOPY=$(CROSS_COMPILE)objcopy

.PHONY: clean

all: c_hello_d.bin c_hello_d.S

c_hello_d.bin: c_hello_d.elf
	$(OBJCOPY) -O binary $< $@

c_hello_d.elf: c_hello_d.c
	$(CC) -mno-relax -Wl,--no-relax $< -o $@

c_hello_d.S: c_hello_d.elf
	$(OBJDUMP) -D $< > $@

clean:
	rm -rf c_hello_d.elf c_hello_d.bin c_hello_d.o c_hello_d.s c_hello_d.S
