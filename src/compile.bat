del os.img

nasm assembly/mloader.asm -f elf32 -o bootloader.o
nasm assembly/mloader.asm -f bin -o loader.bin

gcc  -m32 -ffreestanding -Wall -Wextra -c system/kernel.c -o kernel.o

ld -T NUL -o kernel.tmp -m i386pe -Ttext 0x1000 bootloader.o kernel.o
objcopy -O binary -j .text  kernel.tmp kernel.bin

copy /b loader.bin+kernel.bin os.img

pause

bochsrc.bxrc