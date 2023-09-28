extern printf
extern scanf

global main

section .data
    question:   db  "Quel age avez-vous : ", 0
    value_put:  db  "Vous avez donc %d", 10, 0
    fmt_scanf:  db  "%d", 0
    too_young:  db  "Vous etes trop jeune", 10, 0
    welcome:    db  "Bienvenue !", 10, 0

section .bss
    age:    resb    1

section .text
    global _start


_start:
    mov rdi, question
    mov rax, 0
    call printf

    mov rdi, fmt_scanf
    mov rsi, age
    mov rax, 0
    call scanf

    mov rdi, value_put
    movzx rsi, byte[age]
    mov rax, 0
    call printf

    cmp byte[age], 18
    jb tooYoung         ; saute si inférieur

    mov rdi, welcome
    mov rax, 0
    call printf
    jmp endLabel    ; saute directement vers le label de fin

tooYoung:
    mov rdi, too_young
    mov rax, 0
    call printf

endLabel:
    mov rax, 60
    mov rsi, 0
    syscall

    ret