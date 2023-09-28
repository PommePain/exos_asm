extern printf
extern scanf

global main

section .data
    question:   db  "Donnez un nombre entre 10 et 20 : ", 0
    value_put:  db  "Vous avez choisi le nombre : %d", 10, 0
    fmt_scanf:  db  "%d", 0
    too_high_message:   db  "Le nombre est trop grand", 10, 0
    too_low_message:    db  "Le nombre est trop petit", 10, 0
    welcome:    db  "OK !", 10, 0

section .bss
    value:    resb    1

section .text
    global _start


_start:
    mov rdi, question
    mov rax, 0
    call printf

    mov rdi, fmt_scanf
    mov rsi, value
    mov rax, 0
    call scanf

    mov rdi, value_put
    movzx rsi, byte[value]
    mov rax, 0
    call printf

    cmp byte[value], 20
    ja tooHigh

    cmp byte[value], 10
    jb tooLow

    mov rdi, welcome
    mov rax, 0
    call printf
    jmp endLabel

tooHigh:
    mov rdi, too_high_message
    mov rax, 0
    call printf
    jmp endLabel

tooLow:
    mov rdi, too_low_message
    mov rax, 0
    call printf

endLabel:
    mov rax, 60
    mov rsi, 0
    syscall

    ret