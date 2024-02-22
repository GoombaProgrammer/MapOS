[org 0x7e00]

jmp EnterProtectedMode

EnterProtectedMode:

	mov ah, 0x00
    mov al, 0x03
    int 0x10

    mov ah, 0x02
    mov bh, 0x00
    mov dh, 0x00
    mov dl, 0x00
    int 0x10

	call EnableA20
    cli

	lgdt [gdt_descriptor]
	mov eax, cr0
	or eax, 1
	mov cr0, eax

	jmp codeseg:StartProtectedMode

EnableA20:
    in al, 0x92
    or al, 2
    out 0x92, al
    ret

[bits 32]

StartProtectedMode:

	mov ax, dataseg
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

	; [extern main]
	; call main

	mov [0xb8000], byte 'x'
	mov [0xb8002], byte '8'
	mov [0xb8004], byte '6'
	mov [0xb8006], byte '!'

	jmp $

print:
    mov ah, 0x0e
    mov al, [bx]

    cmp [bx], byte 0
    je exit

    int 0x10

    inc bx

    jmp print
    ret

exit:
    ret

gdt_nulldesc:
    dd 0
    dd 0
gdt_codedesc:
    dw 0xFFFF
    dw 0x0000
    db 0x00
    db 10011010b
	db 11001111b
	db 0x00

gdt_datadesc:
    dw 0xFFFF
    dw 0x0000
    db 0x00
    db 10010010b
	db 11001111b
	db 0x00

gdt_end:


gdt_descriptor:
	gdt_size:
		dw gdt_end - gdt_nulldesc - 1
		dd gdt_nulldesc

codeseg equ gdt_codedesc - gdt_nulldesc
dataseg equ gdt_datadesc - gdt_nulldesc

times (512-($-$$)) db 0
dw 0xaa55
