PrintString:
	mov ah, 0x0e
	mov al, [bx]
	cmp [bx], byte 0
	je exit
	int 0x10
	inc bx
	jmp PrintString

exit:
	ret

var:
	db "Welcome to MapOS 1.0 Build 1024", 0