TOOLS = ./tools
IMGDUMP = $(TOOLS)/imgdump
VDISK = ./apps.bin

HELLO_APP ?= ./hello_app
PUT_D ?= ./put_d
C_HELLO ?= ./c/hello
C_HELLO_D ?= ./c/hello_d
C_MEMTEST ?= ./c/memtest
C_PTHREAD_BASE ?= ./c/pthread/base
C_PTHREAD_PARALLEL ?= ./c/pthread/parallel
APPS = c_hello c_hello_d c_memtest c_pthread_base c_pthread_parallel

.PHONY: all clean hello_app put_d imgdump vdisk

all: imgdump

img: clean $(APPS) imgdump vdisk
	$(IMGDUMP)/imgdump $(C_PTHREAD_BASE)/c_pthread_base.elf $(C_PTHREAD_PARALLEL)/c_pthread_parallel.elf $(C_HELLO)/c_hello.elf $(C_HELLO_D)/c_hello_d.elf $(C_MEMTEST)/c_memtest.elf
	dd if=./tmp_file of=./apps.bin conv=notrunc
	mkdir -p ../arceos/payload
	mv ./apps.bin ../arceos/payload/apps.bin

hello_app:
	cd $(HELLO_APP) && make && cd -

put_d:
	cd $(PUT_D) && make && cd -

c_hello:
	cd $(C_HELLO) && make && cd -

c_hello_d:
	cd $(C_HELLO_D) && make && cd -

c_memtest:
	cd $(C_MEMTEST) && make && cd -

c_pthread_base:
	cd $(C_PTHREAD_BASE) && make && cd -

c_pthread_parallel:
	cd $(C_PTHREAD_PARALLEL) && make && cd -

imgdump:
	cd $(IMGDUMP) && make && cd -

vdisk:
	dd if=/dev/zero of=./apps.bin bs=1M count=32


clean:
	cd $(HELLO_APP) && make clean && cd -
	cd $(PUT_D) && make clean && cd -
	cd $(C_HELLO) && make clean && cd -
	cd $(C_HELLO_D) && make clean && cd -
	cd $(C_MEMTEST) && make clean && cd -
	cd $(C_PTHREAD_BASE) && make clean && cd -
	cd $(C_PTHREAD_PARALLEL) && make clean && cd -
	cd $(IMGDUMP) && make clean && cd -
	rm -rf apps.bin tmp_file



