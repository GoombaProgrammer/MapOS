disk_read:
    mov ah, 2
    mov cl, 2
    mov ch, 0
    mov dh, 0

    int 0x13
    jc .err

    cmp al, 1
    jne .err
    ret

.err:
    hlt

enter_pm:
    mov ah, 0x0
    mov al, 0x3
    int 0x10

    call EnA

    cli
    lgdt [gdt_descriptor]

    mov eax, cr0
    or eax, 1
    mov cr0, eax

    jmp CODE_SEG:pm_start

EnA:
    in al, 0x92
    or al, 2
    out 0x92, al
    ret