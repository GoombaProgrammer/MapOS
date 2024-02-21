del kernel.bin
del bootloader.bin
del bootloader.img

nasm assembly/bootloader.asm -f bin -o bootloader.bin

nasm assembly/kernel.asm -f bin -o kernel.bin

copy /b bootloader.bin+kernel.bin bootloader.img

bochsrc.bxrc