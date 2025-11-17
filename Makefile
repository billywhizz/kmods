obj-m = comfile.o
kver = $(shell uname -r)
all:
	${MAKE} comfile.ko
	${MAKE} tiny.com
comfile.ko:
	make -C /lib/modules/$(kver)/build/ M=$(PWD) modules
install:
	sudo insmod comfile.ko
uninstall:
	sudo rmmod comfile.ko
disasm:
	objdump -m i386:x86-64 -b binary --adjust-vma=0xabcd1000 -D tiny.com
clean:
	rm -f .*.cmd
	rm -f *.mod
	rm -f *.mod.c
	rm -f *.symvers
	rm -f *.order
	rm -f *.o
tiny.com:
	nasm -f bin -o tiny.com tiny.asm
	chmod +x tiny.com
cleanall:
	${MAKE} clean
	rm -f tiny.com
	rm -f *.ko
