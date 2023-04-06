; Example assembly language program -- adds two numbers
; Author:  R. Detmer
; Date:    1/2008

.586
.MODEL FLAT

INCLUDE io.h            ; header file for input/output

.STACK 4096

.DATA
prompt1 BYTE    "Please enter today's temperature", 0
prompt2 BYTE    "Please enter tomorrow's temperature", 0
msg1    BYTE    "It’s freezing!", 0
msg2    BYTE    "It’s cold.  Wear a coat!", 0
msg3    BYTE    "It’s cool out.", 0
msg4    BYTE    "This is the best weather.", 0
msg5    BYTE    "It’s summertime!", 0
msg6    BYTE    "Tomorrow is warmer than today.", 0
msg7    BYTE    "Tomorrow is cooler than today.", 0
temp    DWORD   ?
tomorrow DWORD  ?
string  BYTE    10 DUP (?)
resultLbl BYTE  "The sum is", 0
sum     BYTE    11 DUP (?), 0

.CODE
_MainProc PROC
        ;  Input today's temperature
        input   prompt1, string, 10
        atod    string          
        mov     temp, eax   

        ; Now compare it and jump to the right place to print a message.
        ; Note that if we arrange the comparisons correctly, we only have to
        ; compare with a less than.
        cmp     eax, 32
        jl      freezing
        cmp     eax, 45
        jl      cold
        cmp     eax, 60
        jl      cool
        cmp     eax, 75
        jl      best

        ; last case, no more comparison needed
        output  msg5, string
        jmp     second

freezing:
        output  msg1, string
        jmp     second
        
cold:
        output  msg2, string
        jmp     second

cool:
        output  msg3, string
        jmp     second

best:
        output  msg4, string
        jmp     second
        
second:
        ; Now input tomorrow's temp
        input   prompt2, string, 10
        atod    string          
        mov     tomorrow, eax 
        
        ; Compare it and print the right message.
        cmp     temp, eax
        jl      warmer
        jg      cooler
        jmp     done  

warmer:
        output  msg6, string
        jmp     done

cooler:
        output  msg7, string
        jmp     done

done:
        mov     eax, 0  ; exit with return code 0
        ret
_MainProc ENDP
END                             ; end of source code

