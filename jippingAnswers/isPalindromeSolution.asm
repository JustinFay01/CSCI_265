;   Detect palindromes for Week 14 day 1
;   Mike Jipping, April 2016/2017

.586
.MODEL FLAT

INCLUDE io.h            ; header file for input/output

.STACK 4096

; We don't need a lot of varaibles.
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

        mov     eax, 0
        lea     ecx, string
LEN:    cmp     string[eax], 0 
        je      LENGTHEND
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
END                             ; end of source code
