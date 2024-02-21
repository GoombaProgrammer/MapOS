# Current bootloader explanation
The current bootloader contains these lines of code:
```asm

jmp $

times 510-($-$$) db 0
dw 0xaa55
```

```asm
jmp $
```

This loops the OS forever! $ means the current memory address, thus, it keeps executing whatever it was doing.

The last two lines of code actually identifies the code as an Operating System to the BIOS.

```asm
times 510-($-$$) db 0
```
This fills the rest of the thing with 0's, it makes it 512 bytes.

You might be wondering why 510 bytes, not 512? Well, it subtracts 510 from the length of our previous code. $, as you know, is the current memory address, we subtract that. db 0 just tells it to fill in all zeroes.

```asm
dw 0xaa55
```

These are our magic bytes, it signifies that it actually is an actual Operating System so the BIOS can load it.

Running compile.bat, it compiles and runs the OS. which does nothing for now, but hey, atleast it doesn't crash!

That's our bootloader.