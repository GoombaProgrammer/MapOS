del kernel.bin
del bootloader.bin
del bootloader.img

nasm assembly/bootloader.asm -f bin -o bootloader.bin

nasm assembly/kernel.asm -f bin -o kernel.bin

: nasm assembly/kernel.asm -f elf -o kernel.o
: gcc -ffreestanding -mno-red-zone -c "system/kernel.cpp" -o mkrn.o
: ld -o kernel.tmp -Ttext 0x7e00 kernel.o mkrn.o

: objcopy -O binary kernel.tmp kernel.bin

copy /b bootloader.bin+kernel.bin bootloader.img

bochsrc.bxrc