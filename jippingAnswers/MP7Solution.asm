;   Detect palindromes
;   Mike Jipping, April 2016

.586
.MODEL FLAT

INCLUDE io.h            ; header file for input/output

.STACK 4096

.DATA

prompt  BYTE    "Enter phrase", 0
string  BYTE    40 DUP (?)
notPalindrome BYTE  "This is not a palindrome", 0
palindrome    BYTE  "This is a palindrome", 0

.CODE

_MainProc PROC

;  Read the string from the user

        input   prompt, string, 40   

;  Find the length of the string
;  Squish out the bad characters in the process

        mov     eax, 0
        lea     ecx, string
LEN:    cmp     string[eax], 0 
        je      LENGTHEND

;     Check to see if the letter is < "0"

SQUISH: cmp     string[eax], "0"
        jge     SQUISH2
        push    eax
        call    SHIFTER
        add     esp, 4      ; discard parameters
        jmp     LEN

;     Check to see if the letter is < "A"

SQUISH2: 
        cmp     string[eax], "A"
        jge     LCASE
        push    eax
        call    SHIFTER
        add     esp, 4      ; discard parameters
        jmp     LEN

;     Check to see if the letter is UPPERCASE

LCASE:
        cmp     string[eax],"Z"
        jg      SQUISH3
        add     string[eax], 32

;     Check to see if the letter is < "a"

SQUISH3:
        cmp     string[eax], "a"
        jge     SQUISH4
        push    eax
        call    SHIFTER
        add     esp, 4      ; discard parameters
        jmp     LEN

;     Check to see if the letter is > "z"

SQUISH4:
        cmp     string[eax], "z"
        jle     SQDONE
        push    eax
        call    SHIFTER
        add     esp, 4      ; discard parameters
        jmp     LEN
SQDONE: 
        inc     eax
        jmp     LEN

;  Now we have the length of the string.  Let's analyze the front 
;  of the string and the end of the string.

LENGTHEND:
        mov     ebx, 0
        mov     ecx, eax
        dec     ecx

CHECK:  mov     al, string[ebx]
        cmp     al, string[ecx]
        jne     REPORTNO
        
        inc     ebx
        dec     ecx
        cmp     ebx, ecx
        jng     CHECK

;  Report YES!
        output  prompt, palindrome
        jmp     DONE
        
;  Report NO!
REPORTNO:     
        output  prompt, notPalindrome

DONE:
        mov     eax, 0  ; exit with return code 0
        ret
_MainProc ENDP

; SHIFTER shifts the string in memory one character to the left, starting
; at the position held in the first parameter

SHIFTER PROC
            push    ebp             ; establish stack frame
            mov     ebp, esp
            push    eax             ; save registers
            push    ebx
            push    ecx
            push    edx
            mov     ebx, [ebp+8]    ; index of char to be discarded
            
            ; Move the character at EBX+1 to EBX
SHIFTLOOP:  mov     al, string[ebx+1]
            mov     string[ebx], al
            cmp     al, 0
            je      SHIFTDONE
            inc     ebx
            jmp     SHIFTLOOP

SHIFTDONE:  pop     edx             ; restore registers
            pop     ecx
            pop     ebx
            pop     eax
            pop     ebp             ; restore base pointer
            ret                     ; return
SHIFTER ENDP

END                             ; end of source code
