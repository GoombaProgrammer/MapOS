del os.img
del bootloader.bin
del kernel.bin

fasm ../src/boot/mloader.asm bootloader.bin
fasm ../src/system/kernel.asm kernel.bin

copy /b bootloader.bin+kernel.bin os.img

: pause

bochsrc.bxrc