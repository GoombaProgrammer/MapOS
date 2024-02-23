org 0x7e00
[bits 16]

_start:

	mov ah, 0x00   ; Set Video Mode
	mov al, 0x03   ; Mode 3 (80x25 characters)
	int 0x10       ; Call BIOS interrupt

    mov ax,0x13
    int 0x10

	jmp EnterPM

%include "../src/system/include/gdt.asm"

EnterPM:
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

VIDEO_MEMORY equ 0xb8000
GRAPHICS_MEMORY equ 0x0A0000
WHITE_ON_BLACK equ 0x0f ; the color byte for each character

StartProtectedMode:

	mov ax, dataseg
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

    ; output a pixel
	mov edi, GRAPHICS_MEMORY
    mov al, WHITE_ON_BLACK      ; the color of the pixel
    mov [edi], al

	jmp $

print_string_pm:
    pusha
    mov edx, VIDEO_MEMORY

print_string_pm_loop:
    mov al, [ebx] ; [ebx] is the address of our character
    mov ah, WHITE_ON_BLACK

    cmp al, 0 ; check if end of string
    je print_string_pm_done

    mov [edx], ax ; store character + attribute in video memory
    add ebx, 1 ; next char
    add edx, 2 ; next video memory position

    jmp print_string_pm_loop

print_string_pm_done:
    popa
    ret

times 512-($-$$) db 0
dw 0xaa55