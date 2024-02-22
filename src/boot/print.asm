print:

	cmp [bx], byte 0
	je exit

    mov ah, 0x0e
	mov al, [bx]
	int 10h

	inc bx

	jmp print

    ret

exit:
    ret