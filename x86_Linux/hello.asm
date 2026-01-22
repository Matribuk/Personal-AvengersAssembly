; Assembly language program to print "Hello world!" to the console
; x86 32-bit Linux syntax
; nasm syntax
; Assemble with: nasm -f elf32 hello.asm -o hello.o
; Link with: ld -m elf_i386 hello.o -o hello
;   Run with: ./hello
; Syntax reference:
;   section: Define a section in the program (text for code, data for variables)
;   global: Define a global symbol (entry point for the linker)
;   db: Define byte (8 bits of memory for the variable)
;   dw: Define Word. Generally 2 bytes on a typical x86 32-bit system
;   dd: Define double word. Generally 4 bytes on a typical x86 32-bit system
;   equ: Define a constant value
;   mov: Move data from one location to another
;   int: Software interrupt to invoke a system call :
;       0x80 is used to invoke Linux kernel services on x86 systems, stop the process


section        .text                        ; Create the text section
global         _start                       ; Entry point for the program, for the linker
_start:                                     ; The start section begins
    mov edx, len                            ; move the length of the message to EDX
    mov ecx, msg                            ; move the message to ECX
   
    mov ebx, 1                              ; file descriptor (fd) 1 is stdout
    
    mov eax, 4                              ; syscall number for sys_write = 4
    int 0x80                                ; call kernel
    
    mov eax, 1                              ; syscall number for sys_exit = 1
    int 0x80                                ; exit code 0

section        .data                        ; Create the data section
    msg        db "Hello world!", 0xa
    len        equ $ - msg                  ; Length of the message


