org 0x7e00

_start:
	mov ah, 0
	mov ax,13h
	int 0x10

	mov bx, stffff
	call print
	jmp .done

.done:
	hlt

include "../src/boot/print.asm"

stffff: db "Kernel loaded!", 0

times 512-($-$$) db 0
dw 0xaa55