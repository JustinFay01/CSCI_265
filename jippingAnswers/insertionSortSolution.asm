;  Week 15 day 1 Exercise: Selection Sort!
;
;  Mike Jipping
;  April 2019


.586
.MODEL FLAT

INCLUDE io.h            ; header file for input/output

.STACK 4096

.DATA
array   DWORD   10, 30, 20, 100, 90, 30, 9, 40, 35, 0
temp    DWORD   ?
min     DWORD   ?
string  BYTE    100 DUP (?)
numstr  BYTE    11 DUP (?), 0
prompt1 BYTE    "Input a string", 0
prompt2 BYTE    "Sorted string", 0
inlimit DWORD   ?

.CODE
_MainProc PROC

        input   prompt1, string, 100

        ;  Find the length of the string
        mov     eax, 0
        lea     ecx, string
LEN:    cmp     string[eax], 0 
        je      LENGTHEND
        inc     eax
        jmp     LEN
LENGTHEND:
        mov     esi, eax   ; length of string in esi

;*** Now launch into the Selection Sort

        ; Outer Loop: for (int i = 0; i < n-1; i++)  
        mov     ecx, 0  ; outer loop
        dec     esi
outer:  cmp     ecx, esi
        jge     display

        mov     min, ecx
        
        ; Inner loop:  for (int j = i+1; j < n; j++) 
            mov     edx, ecx
            inc     edx
            mov     edi, esi
            inc     edi

inner:      cmp    edx, edi
            jge    swap

            ; compare string[edx] to string[min]
            mov     ebx, min
            mov    al, string[ebx]
            cmp    al, string[edx]
            jle    innerincr

            ; Record min
            mov     min, edx

            ; Increment and go back for this loop
innerincr:  inc    edx
            jmp    inner

            ; Swap with min
swap:       cmp    ecx, min
            je     outerincr  ; don't swap with the same index

            mov    edi, min
            mov    al, string[edi]
            mov    bl, string[ecx]
            mov    string[edi], bl
            mov    string[ecx], al

            ; Increment and go back for this loop
outerincr:  
        inc    ecx
        jmp    outer

;***  Print the new sorted list

display:
        output  prompt2, string

        mov     eax, 0  ; exit with return code 0
        ret
_MainProc ENDP
END                             ; end of source code

