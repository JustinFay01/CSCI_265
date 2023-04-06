; Fahrenheit to Celsius conversion, part 2
; Mike Jipping
; Week 13 Day 1 Solution
; March 2018

.586
.MODEL FLAT

INCLUDE io.h            ; header file for input/output

.STACK 4096

;--------------------------------------------------------------------------------------------
; Declarations
; Note that we declare a constant in a memory location (nine) for the idiv instruction

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

;--------------------------------------------------------------------------------------------
; Here's the actual code.

.CODE
_MainProc PROC
        ; Input the farenheit temperature to the EAX register
        ; Both "input" and "atod" are macros
        input   prompt1, temp, 40
        atod    temp            ; convert the string starting in "temp" to integer in EAX
        mov     fahren, eax

looper:
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
        mov     digit1, al

        ; Here is the ones digit.  Note we use a "neg" instruction to subtract the tens
        ; digit from the converted temperature
        mov     eax, celsius
        cdq
        idiv    ten
        imul    ten
        neg     eax
        add     eax, celsius
        add     eax, 48
        mov     digit2, al

        ; Now output without using "atod" -- because we don't need it.
        output  prompt2, prompt2 ; output
        
        ; For the loop
        inc     fahren
        jmp     looper

        ; Done! Return
        mov     eax, 0  ; exit with return code 0
        ret
_MainProc ENDP
END                             ; end of source code
