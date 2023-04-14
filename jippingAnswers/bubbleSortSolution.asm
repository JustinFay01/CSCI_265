;  Week 14 day 1 Exercise: Bubble Sort!
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
string  BYTE    100 DUP (?)
numstr  BYTE    11 DUP (?), 0
prompt1 BYTE    "Unsorted List", 0
prompt2 BYTE    "Sorted List", 0
inlimit DWORD   ?

.CODE
_MainProc PROC

;***  Print the original, unsorted list

        ; ECX holds the address of the string being built
        lea	   ecx, string

        ; EBX will hold the address of the current item in the array
        lea    ebx, array

        ; Look for the 0 at the end of the list
out1:   mov    eax, [ebx]
        cmp    al, 0
        je     outputstring

        ; Convert the number to a series of characters
        dtoa   numstr, eax

        ; Copy the characters to the string being built
        lea    edx, numstr
while1: mov     eax, [edx]
        cmp     al, 0     
        jne     movechar
        add     ebx,4
        jmp     out1
movechar:
        mov     [ecx], eax      ; Move the character
        inc     edx             ; Increment counters
        inc     ecx
        jmp     while1

        ; Now output the string.
outputstring:   
        output  prompt1, string


;*** Now launch into the Bubble Sort

        ; Outer Loop: for (int i = 0; i < n-1; i++)  
        mov     ecx, 0  ; outer loop
outer:  cmp     ecx, 9
        jge     display2
        
        ; Inner loop:  for (int j = 0; j < n-i-1; j++) 
            mov     edx, 0  
            mov     edi, 9   ; compute n-i-1
            sub     edi, ecx
            sub     edi, 1
            mov     inlimit, edi

inner:      cmp    edx, inlimit
            jge    outerincr

            ; Compare array[j] to array[j+1]
            ; We have to compute both
            ; Compute j
            lea    eax, array
            mov    edi, edx
            imul   edi, 4
            add    eax, edi
            ; Compute i+1
            lea    ebx, array
            add    ebx, edi
            add    ebx, 4

            ; Move array[j] to EAX and compare to [EBX], or array[j+1]
            mov    eax, [eax]
            cmp    eax, [ebx]
            jle    innerincr

            ; Swap two adjacent items
            mov    edi, [ebx]
            mov    [ebx], eax
            lea    eax, array
            mov    ebx, edx
            imul   ebx, 4
            add    eax, ebx
            mov    [eax], edi

            ; Increment and go back for this loop
innerincr:  inc    edx
            jmp    inner

            ; Increment and go back for this loop
outerincr:  
        inc    ecx
        jmp    outer



;***  Print the new sorted list

display2:
        ; ECX holds the address of the string being built
        lea	   ecx, string

        ; EBX will hold the address of the current item in the array
        lea    ebx, array

        ; Look for the 0 at the end of the list
out2:   mov    eax, [ebx]
        cmp    al, 0
        je     outputstring2

        ; Convert the number to a series of characters
        dtoa   numstr, eax

        ; Copy the characters to the string being build
        lea    edx, numstr
while2: mov     eax, [edx]
        cmp     al, 0     
        jne     movechar2
        add     ebx,4
        jmp     out2
movechar2:
        mov     [ecx], eax      ; Move the character
        inc     edx             ; Increment counters
        inc     ecx
        jmp     while2

        ; Now output the string.
outputstring2:   
        output  prompt1, string

        mov     eax, 0  ; exit with return code 0
        ret
_MainProc ENDP
END                             ; end of source code

