[org 0x7e00]
[bits 16]

section .text
    global _start

_start:
    mov ah, 0x00
    mov al, 0x03
    int 0x10

    mov ah, 0x02
    mov bh, 0x00
    mov dh, 0x00
    mov dl, 0x00
    int 0x10

    mov bx, string
    call print

    jmp $

print:
    mov ah, 0x0e
    mov al, [bx]

    cmp [bx], byte 0
    je exit

    int 0x10

    inc bx

    jmp print

exit:
    ret

string:
    db "Welcome to MapOS Buidl 1024!", 0

times (512-($-$$)) db 0
dw 0xaa55
