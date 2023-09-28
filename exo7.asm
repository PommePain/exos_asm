extern printf
extern scanf

global main

section .data
    question:   db  "Nombre 1 : ", 0
    q2:         db  "Nombre 2 : ", 0
    valueMess:  db  "Nombre choisi = %d", 10, 0
    fmt_scanf:  db  "%d", 0
    result:     db  "Le quotient est = %d", 10, 0
    err_mess:   db  "Probleme dans un des deux nombres", 10, 0
    resValue:   db  0
    count:      db  0

section .bss
    valueA: resb    1
    valueB: resb    1

section .text
    global _start

_start:
    mov rdi, question
    mov rax, 0
    call printf

    mov rdi, fmt_scanf
    mov rsi, valueA
    mov rax, 0
    call scanf

    mov rdi, valueMess
    movzx rsi, byte[valueA]
    mov rax, 0
    call printf

    mov rdi, q2
    mov rax, 0
    call printf

    mov rdi, fmt_scanf
    mov rsi, valueB
    mov rax, 0
    call scanf

    mov rdi, valueMess
    movzx rsi, byte[valueB]
    mov rax, 0
    call printf

    cmp byte[valueA], 0
    je errorLabel

    cmp byte[valueB], 0
    je errorLabel

    mov bl, byte[valueA]
    mov bh, byte[valueB]

    cmp bl, byte[valueB]
    jb errorLabel

whileLoop:
    cmp bl, 0
    je finalResultLabel

    inc byte[resValue]
    mov byte[count], 0
    jmp forLoop

forLoop:
    cmp bh, byte[count]
    je whileLoop

    inc byte[count]
    dec bl
    jmp forLoop

finalResultLabel:
    mov rdi, result
    movzx rsi, byte[resValue]
    mov rax, 0
    call printf
    jmp endLabel

errorLabel: 
    mov rdi, err_mess
    mov rax, 0
    call printf
    jmp _start

endLabel:
    mov rax, 60
    mov rsi, 0
    syscall

    ret