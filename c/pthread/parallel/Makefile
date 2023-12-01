CROSS_COMPILE=riscv64-linux-gnu-
CC=$(CROSS_COMPILE)gcc
OBJDUMP=$(CROSS_COMPILE)objdump
OBJCOPY=$(CROSS_COMPILE)objcopy

.PHONY: clean

all: c_pthread_parallel.bin c_pthread_parallel.S

c_pthread_parallel.bin: c_pthread_parallel.elf
	$(OBJCOPY) -O binary $< $@

c_pthread_parallel.elf: c_pthread_parallel.c
	$(CC) -fno-stack-protector $< -o $@

c_pthread_parallel.S: c_pthread_parallel.elf
	$(OBJDUMP) -D $< > $@

clean:
	rm -rf c_pthread_parallel.elf c_pthread_parallel.bin c_pthread_parallel.o c_pthread_parallel.s c_pthread_parallel.S
