TOOLS = ./tools
IMGDUMP = $(TOOLS)/imgdump
APPS ?= ./hello_app
VDISK = ./apps.bin

.PHONY: all clean

all: imgdump

img: apps imgdump vdisk
	$(IMGDUMP)/imgdump $(APPS)
	cat $(APPS)/tmp_head $(APPS)/hello_app.bin > $(APPS)/hello_app.img
	dd if=$(APPS)/hello_app.img of=./apps.bin conv=notrunc
	mkdir -p ../arceos/payload
	mv ./apps.bin ../arceos/payload/apps.bin

apps:
	cd $(APPS) && make && cd -

imgdump:
	cd $(IMGDUMP) && make && cd -

vdisk:
	dd if=/dev/zero of=./apps.bin bs=1M count=32


clean:
	cd $(APPS) && make clean && cd -
	cd $(IMGDUMP) && make clean && cd -



