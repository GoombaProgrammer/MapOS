; MLOADER IS THE BOOTLOADER FOR MAP OPERATING SYSTEM
; AUTHOR: KAP PETROV
; ASSEMBLY SOURCE FILE

bits 16

KERNEL_OFFSET equ 0x1000

mov al, 1
mov bx, 0x0
mov es, bx
mov bx, KERNEL_OFFSET
call disk_read

call enter_pm

%include "assembly/enter_protected.asm"
%include "assembly/gdt.asm"

[bits 32]
pm_start:

	mov ax, DATA_SEG
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ds, ax

	call KERNEL_OFFSET
	jmp $

times 510-($-$$) db 0
dw 0xaa55