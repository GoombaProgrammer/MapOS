org 0
bits 16

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

    mov ah, 0x0e
    mov al, 'W'
    int 0x10

    mov al, 'e'
    int 0x10

    mov al, 'l'
    int 0x10

    mov al, 'c'
    int 0x10

    mov al, 'o'
    int 0x10

    mov al, 'm'
    int 0x10

    mov al, 'e'
    int 0x10

    mov al, ' '
    int 0x10

    mov al, 'T'
    int 0x10

    mov al, 'o'
    int 0x10

    mov al, ' '
    int 0x10

    mov al, 'K'
    int 0x10

    mov al, 'e'
    int 0x10

    mov al, 'r'
    int 0x10

    mov al, 'n'
    int 0x10

    mov al, 'e'
    int 0x10

    mov al, 'l'
    int 0x10

    mov al, '!'
    int 0x10

.done:
    hlt

times (512-($-$$)) db 0
dw 0xaa55
