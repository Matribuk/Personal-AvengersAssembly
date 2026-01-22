; Assembly language program to print "Hello world!" to the console
; ARM64 (AArch64) macOS syntax
; Assemble with: as -arch arm64 hello.asm -o hello.o
; Link with: ld -arch arm64 -o hello hello.o -lSystem -syslibroot $(xcrun --show-sdk-path) -e _start
;   Run with: ./hello
; Syntax reference:
;   .text: Define a section in the program (text for code, data for variables)
;   .global: Define a global symbol (entry point for the linker)
;   .ascii: Define ASCII string (no null terminator)
;   .asciz: Define ASCII string with null terminator
;   .align: Align the next instruction to a power of 2 boundary
;   mov: Move data into a register
;   adr: Load address of a label into a register (PC-relative)
;   svc: Supervisor call - software interrupt to invoke a system call
;       0x80 is used to invoke macOS kernel services on ARM64 systems
;   x0-x30: 64-bit general purpose registers
;   x16: Used to specify the syscall number on macOS ARM64


.global _start                      // Entry point for the program, for the linker
.align 4                            // Align code to 4-byte boundary

_start:                             // The start section begins
    // write(fd, buffer, count)
    mov x0, #1                      // x0 = file descriptor (fd) 1 is stdout
    adrp x1, msg@PAGE               // x1 = page address of the message
    add x1, x1, msg@PAGEOFF         // x1 = full address of the message
    mov x2, msg_len                 // x2 = length of the message
    mov x16, #4                     // x16 = syscall number for sys_write = 4
    svc #0x80                       // call kernel
    
    // exit(status)
    mov x0, #0                      // x0 = exit code 0
    mov x16, #1                     // x16 = syscall number for sys_exit = 1
    svc #0x80                       // call kernel

.data                               // Create the data section
msg:
    .ascii "Hello world!\n"         // Define the message string
    msg_len = . - msg               // Length of the message, current address - start address
