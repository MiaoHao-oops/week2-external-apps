TOOLS = ./tools
IMGDUMP = $(TOOLS)/imgdump
VDISK = ./apps.bin

HELLO_APP ?= ./hello_app
PUT_D ?= ./put_d
APPS = $(HELLO_APP) $(PUT_D)

.PHONY: all clean hello_app put_d imgdump vdisk

all: imgdump

img: clean hello_app put_d imgdump vdisk
	$(IMGDUMP)/imgdump $(APPS)
	dd if=./tmp_file of=./apps.bin conv=notrunc
	mkdir -p ../arceos/payload
	mv ./apps.bin ../arceos/payload/apps.bin

hello_app:
	cd $(HELLO_APP) && make && cd -

put_d:
	cd $(PUT_D) && make && cd -

imgdump:
	cd $(IMGDUMP) && make && cd -

vdisk:
	dd if=/dev/zero of=./apps.bin bs=1M count=32


clean:
	cd $(HELLO_APP) && make clean && cd -
	cd $(PUT_D) && make clean && cd -
	cd $(IMGDUMP) && make clean && cd -
	rm -rf apps.bin tmp_file



