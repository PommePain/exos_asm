extern printf
extern scanf

global main

section .data
    question:   db  "Donnez un nombre entre 10 et 20 : ", 0
    fmt_scanf:  db  "%d", 0
    error_message:   db  "Erreur sur le nombre ! ", 10, 0
    welcome:    db  "OK !", 10, 0

section .bss
    value:  resb    1

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

    cmp byte[value], 10
    jb errorLabel

    cmp byte[value], 20
    ja errorLabel

    mov rdi, welcome
    mov rax, 0
    call printf

    jmp endLabel

errorLabel:
    ; Affichage du message d'erreur et retour au saut au label _start
    mov rdi, error_message
    mov rax, 0
    call printf
    jmp _start

endLabel:
    mov rax, 60
    mov rsi, 0
    syscall

    ret