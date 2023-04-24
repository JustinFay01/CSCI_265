; Week 15 day 1: Properly format a sentance.
;
; Mike Jipping
; April 2017

.586
.MODEL FLAT

INCLUDE io.h            ; header file for input/output

.STACK 4096

; You will need two messages for I/O and two strings
.DATA
prompt  BYTE    "Enter a sentance", 0
resultp BYTE    "The proper format is", 0
string  BYTE    40 DUP (?)
result  BYTE    40 DUP (?)

.CODE
_MainProc PROC

        ;  Read the string from the user
        input   prompt, string, 40

        ; Load up the parameters
        lea     eax, result   
        push    eax   
        lea     eax, string       
        push    eax      

        ; Now make the call
        call    format  ; asciiToHex(string, result)

        ; Return: adjust the stack (throw away the parameters), print, quit.
        add     esp, 8      ; discard parameters  
        output  resultp, result
              
quit:   mov     eax, 0      ; exit with return code 0
        ret
_MainProc   ENDP            
        
;-----------------------------------------------------------------------------------------
; This is the "format" function.

format  PROC
            ; First preserve the register environment so we can restore it.
            push    ebp             ; establish stack frame
            mov     ebp, esp
            push    eax             ; save registers
            push    ebx
            push    ecx
            push    edx

            ; Now gather the parameters from the stack
            mov     ecx, [ebp+8]    ; original sentance
            mov     edx, [ebp+12]   ; destination sentance

            ; now we start converting
            mov     ebx, 0          ; ebx is our current character

            ; start by checking if we have reached the 0 at the end of the string
while1:     mov     al, [ecx]
            cmp     al, 0
            je      done

            ; Are we at the beginning?
            mov     eax, [ebp+8]
            cmp     eax, ecx
            jne     rest

            ; This is the first letter, uppercase it!
            mov     al, [ecx]
            cmp     al, 96
            jle     copy
            sub     al, 32
            jmp     copy

rest:       ; This is not the first letter, let's lowercase it!
            mov     al, [ecx]
            cmp     al, ' '
            je      copy
            cmp     al, 96
            jg      copy

            ; Wrong case, make it lowercase
            add     al, 32
            jmp     copy

            ; Now copy to the string, whose address is in the EDX register.
copy:
            mov     [edx], al
            inc     ecx
            inc     edx
            jmp     while1

done:       ; Finish by copying the 0 to the string pointed to by the EDX
            mov     [edx], eax

            ; pop and restore registers
            pop     edx             ; restore registers
            pop     ecx
            pop     ebx
            pop     eax
            pop     ebp             ; restore base pointer
            ret                     ; return
format  ENDP
END