;Executable name        Vigenere
;Version                :1.0
;Created                :2016:04:11
;Updated                :2016:04:27
;Author                 :Ross Wilkinson
;This program uses the vigenere cipher to encode
;Build this program using:
;       nasm -f elf32 Vigenere.asm
;       gcc -m32 Vigenere.o -o Vigenere
bits 32
Extern printf, getchar, putchar
global main

SECTION .data           ; Section containing initialized data
desArray db "CRYPTOGRAMCRYPTOGRAMCRYPTOGRAMCRYPTOGRAMCRYPTOGRAMCRYPTOGRAMCRYPTOGRAMCRYPTOGRAMCRYPTOGRAMCRYPTOGRAMCRYPTOGRAMCRYPTOGRAMCRYPTOGRAMCRYPTOGRAMCRYPTOGRAMCRYPTOGRAMCRYPTOGRAMCRYPTOGRAMCRYPTOGRAMCRYPTOGRAM"
fmt: db "total chars: %d",10,0

SECTION .bss            ;Contains unint data
srcArray resb 200       ;This is the input array

SECTION .text           ;Code goes here

global main             ;Linker's entry point

main:
        nop             ;an empty instruction
        xor ebx, ebx    ;char count init:0
        xor eax, eax    ;char buffer

Loop:
        cmp ebx, 200    ;max array size
        jge vigenset
        call getchar    ;any extern funct call goes to eax
        mov dword [srcArray + ebx], eax
        inc ebx         ;char count+1
        jmp Loop

vigenset:
        xor ebx,ebx ;clear for esi index
        xor ecx,ecx ;clear for edi index
vigen:
        cmp ebx, 200
        jge print
        mov al, byte [srcArray + ebx]
        cmp al, 'A' ; 65  'A'
        jl skip
        cmp al, 'z' ; 122  'z'
        jg skip
        cmp al, 'Z' ; 90  'Z'
        jle upper
        cmp al, 'a' ; 97  'a'
        jl skip
        jmp lower
upper:
        xor edx, edx
        xor eax, eax
        mov dl, byte [srcArray + ebx]
        sub dl, 65 ;'A' 65

        mov al, byte [desArray + ecx]
        sub al, 65 ;'A' 65 keyword is uppercase

        add dl, al

        cmp edx, 26 ;need to mod?
        jl addupper
        sub dl, 26

addupper:
        add dl, 65 ;'A' ;storing computed letter into array;
        mov byte [srcArray + ebx], dl
        inc ebx
        inc ecx
        jmp vigen


lower:
        xor edx, edx
        xor eax, eax
        mov dl, byte [srcArray + ebx]
        sub dl, 97 ; 'a' 97

        mov al, byte [desArray + ecx]
        sub al, 65 ;'A' 65

        add dl, al

        cmp edx, 26 ;need to mod?
        jl addlower
        sub dl, 26

addlower:

        add dl, 97
        mov byte [srcArray + ebx], dl
        inc ebx
        inc ecx
        jmp vigen
skip:
        inc ebx ;skip this char
        jmp vigen
print:
        xor ebx, ebx
printn:
        xor ecx,ecx
        cmp ebx, 200
        jge done
        mov cl, byte [srcArray + ebx]
        push ecx
        call putchar
        add esp, 4
        inc ebx
        jmp printn
done:
        push ebx
        push fmt
        call printf
        add esp, 8
        ret
