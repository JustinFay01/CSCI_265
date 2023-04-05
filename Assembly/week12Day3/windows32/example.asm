.586
.MODEL FLAT

INCLUDE io.h            ; header file for input/output

.STACK 4096



.DATA
fahren  DWORD   ?
celsius DWORD   ?
nine    DWORD   9
ten     DWORD   10
prompt1 BYTE    "Enter the temperature in Farenheit", 0
prompt2 BYTE    "The Celsius temperature is "
digit1  BYTE    0
digit2  BYTE    0
prompt3 BYTE    " degrees",0
temp    BYTE    40 DUP (?)

.CODE
_MainProc PROC
        ; Input the farenheit temperature to the EAX register
        ; Both "input" and "atod" are macros
        input   prompt1, temp, 40
        atod    temp            ; convert the string starting in "temp" to integer in EAX
        mov     fahren, eax

loop:
        ; Convert the temperature via the formula.  
        mov     eax, fahren
        sub     eax, 32         
        imul    eax, 5
        cdq                     ; set up for division
        idiv    nine            ; use the memory containing constant in the instruction
        mov     celsius, eax    ; store the result

        ; Now convert the number in EAX to a string and output the data
        ; Here is the tens digit.
        cdq
        idiv    ten
        add     eax, 48
        mov     digit1, al  ; get asci val in digit1

        
        mov     eax, celsius
        cdq
        idiv    ten
        imul    ten
        neg     eax     ; Subtract from the tens
        add     eax, celsius
        add     eax, 48
        mov     digit2, al
        
        output  prompt2, prompt2 ; new output
               
        inc     fahren  ; fahren++
        jmp     loop    ; jump macro to loop

        mov     eax, 0  ; exit with return code 0
        ret
_MainProc ENDP
END                             ; end of source code