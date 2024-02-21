
[org 0x7c00]

mov bp, 0x7000
mov sp, bp
mov bh, 'a'
push bx

mov bx, string

call PrintString

pop bx
mov ah, 0x0e
mov al, bh
int 0x10

jmp $

PrintString:
	mov ah, 0x0e
	mov al, [bx]
	cmp al, 0
	je exit
	int 0x10
	inc bx
	jmp PrintString
	ret

exit:
	ret

string:
	db "Welcome to Map Operating System Build 1024", 0

times 510-($-$$) db 0
dw 0xaa55