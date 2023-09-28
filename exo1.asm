extern printf   ; on inclut printf et scanf de la libc
extern scanf

global main

section .data
    question:   db  "Entre une valeur : ", 0
    value_put:  db  "Valeur entree : %d", 10, 0
    fmt_scanf:  db  "%d", 0 
    hello:      db  "Bonjour", 10, 0
    compteur:   db  0

section .bss
    value:      resb    1   ; Variable non initialisée

section .text
    global _start

_start:
    push rbp

    mov rdi, question
    mov rax, 0
    call printf

    mov rdi, fmt_scanf
    mov rsi, value
    mov rax, 0
    call scanf

    mov rdi, value_put, 
    movzx rsi, byte[value]
    mov rax, 0
    call printf

    mov bl, byte[value]

helloLoop:
    ; on compare notre compteur au registre bl
    cmp [compteur], bl

    ; si le compteur est supérieur ou égal alors on saute à la fin
    jae endHelloLoop
    inc byte[compteur] ; Sinon on incrémente et on resautera au début de la boucle

    mov rdi, hello
    mov rax, 0
    call printf
    jmp helloLoop
endHelloLoop:

end:
    ; On récupère le haut de la pile afin de remettre dans rbp le contenu "sauvegardé"
    pop rbp

    ; termine le programme proprement
    mov rax, 60
    mov rdi, 0
    syscall
    ret