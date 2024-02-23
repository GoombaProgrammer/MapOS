org 0x7c00
[bits 16]

KERNEL_OFFSET equ 0x7e00

mov bx, stringthing
call print

boot:
    mov ah, 2
    mov al, 1
    mov ch, 0
    mov cl, 2
    mov dh, 0
    mov dl, [BOOT_DRIVE]
    mov bx, KERNEL_OFFSET
    int 0x13
    jc disk_error

    jmp KERNEL_OFFSET

disk_error:
    mov bx, failure
    call print
    jmp $

%include "../src/boot/print.asm"

stringthing: db "Booting up.. Please Wait.    ", 0
failure: db "Failed to boot up, please shutdown your computer.", 0

BOOT_DRIVE: db 0

times 510-($-$$) db 0
dw 0xaa55
