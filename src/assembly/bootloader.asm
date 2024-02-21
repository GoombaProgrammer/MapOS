
[org 0x7c00]
[bits 16]

boot:
    mov ah, 0x02
    mov al, 0x01
    mov ch, 0x00
    mov cl, 0x02
    mov dh, 0x00
    mov dl, 0x00
    mov bx, 0x7e00
    int 0x13
    jc disk_error
    mov bx, good
    call printf

    jmp 0x7e00

disk_error:
    mov bx, fail
    call printf
    hlt

jmp $

printf:
    mov ah, 0x0e
    mov al, [bx]

    cmp [bx], byte 0
    je exit

    int 0x10

    inc bx

    jmp printf

exit:
    ret

fail:
    db "Failed to load!", 0
good:
    db "Loaded Kernel.. Starting...", 0

times 510-($-$$) db 0
dw 0xaa55