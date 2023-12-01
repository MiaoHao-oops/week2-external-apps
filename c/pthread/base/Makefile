CROSS_COMPILE=riscv64-linux-gnu-
CC=$(CROSS_COMPILE)gcc
OBJDUMP=$(CROSS_COMPILE)objdump
OBJCOPY=$(CROSS_COMPILE)objcopy

.PHONY: clean

all: c_pthread_base.bin c_pthread_base.S

c_pthread_base.bin: c_pthread_base.elf
	$(OBJCOPY) -O binary $< $@

c_pthread_base.elf: c_pthread_base.c
	$(CC) -fno-stack-protector $< -o $@

c_pthread_base.S: c_pthread_base.elf
	$(OBJDUMP) -D $< > $@

clean:
	rm -rf c_pthread_base.elf c_pthread_base.bin c_pthread_base.o c_pthread_base.s c_pthread_base.S
