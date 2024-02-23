del os.img
del bootloader.bin
del kernel.bin

nasm -f bin ../src/boot/mloader.asm -o bootloader.bin
nasm -f bin ../src/system/kernel.asm -o kernel.bin

copy /b bootloader.bin+kernel.bin os.img

pause

bochsrc.bxrc