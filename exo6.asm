extern printf
extern scanf

global main

section .data
    question:   db  "Nombre 1 : ", 0
    q2:         db  "Nombre 2 : ", 0
    valueMess:  db  "Nombre choisi = %d", 10, 0
    fmt_scanf:  db  "%d", 0
    result:     db  "Le produit est = %d", 10, 0
    err_mess:   db  "Un nombre est negatif ou egal a 0", 10, 0
    resValue:   db  0
    firstCount: db  0
    secondCount:    db  0

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

    mov bl, byte[valueB]
    mov bh, byte[valueA]

firstLoop:
    cmp byte[firstCount], bl
    jae finalResult             ; si supérieur ou égal la première boucle est donc finie

    inc byte[firstCount]        ; incrémentation
    mov byte[secondCount], 0
    jmp secondLoop

secondLoop:
    cmp byte[secondCount], bh
    jae firstLoop

    inc byte[secondCount]
    inc byte[resValue]

    jmp secondLoop

finalResult:
    mov rdi, result
    movzx rsi, byte[resValue]
    mov rax, 0
    call printf

    jmp endLabel

errorLabel: 
    mov rdi, err_mess
    mov rax, 0
    call printf
    jmp _start      ; afin de repartir au début du programme

endLabel:
    mov rax, 60
    mov rsi, 0
    syscall

    ret