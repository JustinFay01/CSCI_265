; Solution to Week 13 day 2 exercise
;
; Mike Jipping
; March 2017

.586
.MODEL FLAT

INCLUDE io.h            ; header file for input/output

.STACK 4096

.DATA
; For the first number: storage, prompt, and input string
number1 DWORD   ?                        
prompt1 BYTE    "Enter first number", 0  
string1 BYTE    40 DUP (?)

; For the second number: storage, prompt, and input string
number2 DWORD   ?                        
prompt2 BYTE    "Enter second number", 0
string2 BYTE    40 DUP (?)

; Three "relationship messages"
msg1    BYTE    " is less than ", 0
msg2    BYTE    " is equal to ", 0
msg3    BYTE    " is greater than ", 0

; Final result will be built here
result  BYTE    80 DUP (?)

.CODE
_MainProc PROC
        
        ; Start off by entering the two numbers and storing them
        input   prompt1, string1, 40      
        atod    string1          
        mov     number1, eax    

        input   prompt2, string2, 40      
        atod    string2
        mov     number2, eax

        ; Load the address of the final string into the ECX
        lea     ecx, result

        ; First while loop, copying the first number 
        lea     ebx, string1
while1: mov     eax, [ebx]      ; <-- Notice indirect addressing!
        cmp     al, 0           ; Did we get to the final 0?
        je      done1
        mov     [ecx], eax      ; Move the character
        inc     ebx             ; Increment counters
        inc     ecx
        jmp     while1

        ; Here we decide which of three relationship messages to print.
        ; The address is placed in the EBX and used with indirect 
        ; addressing.
done1:  mov     eax, number1
        cmp     eax, number2
        jl      less
        je      equal

        lea     ebx, msg3
        jmp     while2

less:   lea     ebx, msg1
        jmp     while2

equal:  lea     ebx, msg2
        
        ; Now copy the relationship message into the result string
while2: mov     eax, [ebx]
        cmp     al, 0
        je      done2
        mov     [ecx], eax
        inc     ebx
        inc     ecx
        jmp     while2

        ; Now copy the last number into the result string
done2:
        lea     ebx, string2
while3: mov     eax, [ebx]
        cmp     al, 0
        je      done3
        mov     [ecx], eax
        inc     ebx
        inc     ecx
        jmp     while3

        ; And display it.
done3:
        mov     ebx, 0
        mov     [ecx], ebx
        output  result, result

        mov     eax, 0  ; exit with return code 0
        ret
_MainProc ENDP
END                             ; end of source code

