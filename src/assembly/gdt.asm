gdt_null:
    dd 0
    dd 0

gdt_code:
    dw 0xFFFF
    dw 0x0000
    db 0x00

    db 10011010b
    db 11001111b
    db 0x00

gdt_data:
    dw 0xFFFF
    dw 0x0000
    db 0x00

    db 10010010b
    db 11001111b
    db 0x00

gdt_end:

gdt_descriptor:
   gdt_size:
        dw gdt_end - gdt_null - 1
        dd gdt_null

CODE_SEG equ gdt_code - gdt_null
DATA_SEG equ gdt_data - gdt_null