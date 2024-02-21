# What's real mode?
Real mode is a 16 bit mode assisted by the BIOS - Basic Input Output System.

BIOS - Simple Tools to interact with the computer. We can use it to - say - display characters to the screen, 
input chars from the keyboards, read from disk, etc.

# Simple bootloader explanation
The first bootloader from the initial commit contains these lines of code:
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

# BIOS, Printing the alphabet, Conditional jumps!
How to print a char you might ask, here's the steps:
1) Switch to teletype mode:
        Move 0x0e in the AH Register
        Move the char you want to print in the AL register
        Call Interrupt 0x10

If we repeat this tediously multiple times, we can print a full String! okay, okay, here's the code.

```asm
    mov ah, 0x0e
    mov al, '[insert char]'
    int 0x10
```

Hmm, we can represent a char using these: '', what about using Hex codes?

A is represented by 0x41, B by 0x42, and so on. Wait, we can print the alphabet using these!

We can also use decimal values for these, A is 65 then, B 66, etc.

Just increment the number eachtime until you reach Z and boom, alphabet!

Here's a example:

```asm

mov ah, 0x0e
mov al, 65
int 0x10

mov ah, 0x0e
mov al, 0x41
int 0x10

mov ah, 0x0e
mov al, 'A'
int 0x10

mov ah, 0x0e
mov al, 0b1000001
int 0x10

```

This prints four A's, using a different value each time!

We can do something like this, first of all, print the letter A, Let's use decimal values like 65.

If after this we print 66, that prints B. 67, C, etc. There's a way to automate this.

if we move A into al, it will stay in al, even after printing it. so we can use a command to increment al.

This command is:

```asm
inc al
```

using this some of times, we can print some of the alphabet.

```asm
mov ah, 0x0e
mov al, 65
int 0x10

inc al
int 0x10

inc al
int 0x10

inc al
int 0x10

inc al
int 0x10

inc al
int 0x10

inc al
int 0x10
```

This prints, ABCDEFG.

There must be a faster way! hmmm, what about a loop!

That works, there's a problem though.. It keeps on printing even after Z. printing unwanted numbers and symbols.

Let me introduce you to conditional jumps.

In this new program, i will move 4 into bx, i want check if bx == 5.

fortunately, there's this cmp instruction. which compares 2 numbers or registers.

je after a cmp means jump to label only if latest cmp returned equal.

```asm
mov bx, 4
cmp bx, 5
je label

label:
    mov ah, 0x0e
    mov al, 'X'
    int 0x10

```

This is equivalent to:
```c
bx = 4;
if(bx == 5)
{
    printf("X");
}
```

so in c, printing the alphabet the way we intend would be:

```c
char al = (char)65;
while(1)
{
    if(al == 'Z' + 1) break;
    printf("%c", al);
    al++;
}
```

In assembly:

```asm
mov ah, 0x0e
mov al, 65
int 0x10

loop:
    inc al
    cmp al, 'Z' + 1
    je exit
    int 0x10
    jmp loop

exit:
    jmp $
```
This prints the alphabet! yay!

Kek, HERE'S YOUR HOMEWORK!!!!!!!!!!!!!!!

Print the alphabet in alternating caps.
