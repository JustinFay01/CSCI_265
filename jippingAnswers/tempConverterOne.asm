; Fahrenheit to Celsius conversion
; Mike Jipping
; March 2017

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
prompt1 BYTE    "Enter the temperature in Farenheit", 0
prompt2 BYTE    "The Celsius temperature is", 0
temp    BYTE    40 DUP (?)
celstr  BYTE    11 DUP (?), 0

;--------------------------------------------------------------------------------------------
; Here's the actual code.

.CODE
_MainProc PROC
        ; Input the farenheit temperature to the EAX register
        ; Both "input" and "atod" are macros
        input   prompt1, temp, 40
        atod    temp            ; convert the string starting in "temp" to integer in EAX

        ; Convert the temperature via the formula.  The input value is still in EAX
        sub     eax, 32         
        imul    eax, 5
        cdq                     ; set up for division
        idiv    nine            ; use the memory containing constant in the instruction

        ; Now convert the number in EAX to a string and output the data
        ; Both "dtoa" and "output" are macros
        dtoa    celstr, eax     ; convert to ASCII characters
        output  prompt2, celstr ; output 

        ; Done! Return
        mov     eax, 0  ; exit with return code 0
        ret
_MainProc ENDP
END                             ; end of source code

