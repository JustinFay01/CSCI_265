;   Source: Mike Jipping, April 2016/2017 


.586
.MODEL FLAT

INCLUDE io.h            ; header file for input/output
INCLUDE macros.h

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

        mystrlen string

        ;  Now we have the length of the string.  Let's analyze the front 
        ;  of the string and the end of the string.

LENGTHEND:
        mov     ebx, 0
        mov     ecx, eax
        dec     ecx

CHECK:  lettercheck ebx,isNotALetter1,checkUpperCase1
        lettercheck ecx,isNotALetter2,checkUpperCase2
        
COMPARE:
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
        jmp		DONE

isNotALetter1:
        inc		ebx
        jmp		CHECK

isNotALetter2:
        dec		ecx
        jmp		CHECK

checkUpperCase1:
        uppercasecheck isNotALetter1,checkCharacter1

checkUpperCase2:
        uppercasecheck isNotALetter2,checkCharacter2

checkCharacter1:
        charactercheck		isNotALetter1

checkCharacter2:
        charactercheck		isNotALetter2

DONE:
        mov     eax, 0  ; exit with return code 0
        ret
_MainProc ENDP
END                             ; end of source code