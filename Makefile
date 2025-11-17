obj-m = comfile.o
kver = $(shell uname -r)
all:
	${MAKE} uninstall
	${MAKE} cleanall
	${MAKE} comfile.ko
	${MAKE} install
	${MAKE} tiny.com
	${MAKE} disasm
comfile.ko: comfile.c
	make -C /lib/modules/$(kver)/build/ M=$(PWD) modules
install: comfile.ko
	sudo insmod comfile.ko
uninstall: comfile.ko
	sudo rmmod comfile.ko
disasm: tiny.com
	objdump -m i386:x86-64 -b binary -D tiny.com
clean:
	rm -f .*.cmd
	rm -f *.mod
	rm -f *.mod.c
	rm -f *.symvers
	rm -f *.order
	rm -f *.o
tiny.com: tiny.asm
	nasm -f bin -o tiny.com tiny.asm
	chmod +x tiny.com
cleanall:
	${MAKE} clean
	rm -f tiny.com
	rm -f *.ko
