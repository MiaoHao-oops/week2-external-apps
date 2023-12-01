CROSS_COMPILE=riscv64-linux-gnu-
CC=$(CROSS_COMPILE)gcc
OBJDUMP=$(CROSS_COMPILE)objdump
OBJCOPY=$(CROSS_COMPILE)objcopy

.PHONY: clean

all: c_hello.bin c_hello.S

c_hello.bin: c_hello.elf
	$(OBJCOPY) -O binary $< $@

c_hello.elf: c_hello.c
	$(CC) -fno-stack-protector $< -o $@

c_hello.S: c_hello.elf
	$(OBJDUMP) -D $< > $@

clean:
	rm -rf c_hello.elf c_hello.bin c_hello.o c_hello.s c_hello.S
