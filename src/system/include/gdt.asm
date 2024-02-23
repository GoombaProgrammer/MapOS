; WHY DOES THIS EXIST - GOTTA HATE INTEL ENGINEERS
gdt_nulldesc:
    dd 0
    dd 0

; Code descriptor
gdt_codedesc:
    dw 0xFFFF
    dw 0x0000
    db 0x00
    db 10011010b
    db 11001111b ; 1111111111111111110110101010011010010010101101001
    db 0x00

; Data descriptor - literally code desc but with the exec bit changed
gdt_datadesc:
    dw 0xFFFF
    dw 0x0000
    db 0x00
    db 10010010b
    db 11001111b
    db 0x00

; why does this have to exist
gdt_end:

; only thing that matters.
gdt_descriptor:
    gdt_size:
        dw gdt_end - gdt_nulldesc - 1 ; WHY IDEAL SIZE MINUS 1??? WHY ENGINEERS??
        dd gdt_nulldesc ; bruh

codeseg equ gdt_codedesc - gdt_nulldesc
dataseg equ gdt_datadesc - gdt_nulldesc