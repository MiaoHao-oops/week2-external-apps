TOOLS = ./tools
IMGDUMP = $(TOOLS)/imgdump
VDISK = ./apps.bin

HELLO_APP ?= ./hello_app
EBREAK ?= ./ebreak
APPS = $(HELLO_APP) $(EBREAK)

.PHONY: all clean hello_app ebreak imgdump vdisk

all: imgdump

img: clean hello_app ebreak imgdump vdisk
	$(IMGDUMP)/imgdump $(APPS)
	dd if=./tmp_file of=./apps.bin conv=notrunc
	mkdir -p ../arceos/payload
	mv ./apps.bin ../arceos/payload/apps.bin

hello_app:
	cd $(HELLO_APP) && make && cd -

ebreak:
	cd $(EBREAK) && make && cd -

imgdump:
	cd $(IMGDUMP) && make && cd -

vdisk:
	dd if=/dev/zero of=./apps.bin bs=1M count=32


clean:
	cd $(HELLO_APP) && make clean && cd -
	cd $(EBREAK) && make clean && cd -
	cd $(IMGDUMP) && make clean && cd -
	rm -rf apps.bin tmp_file



