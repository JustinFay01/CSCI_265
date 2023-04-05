; Example assembly language program -- adds two numbers
; Author:  R. Detmer
; Date:    1/2008

.586
.MODEL FLAT

INCLUDE io.h            ; header file for input/output

.STACK 4096

.DATA
number1 DWORD   ?
number2 DWORD   ?
prompt1 BYTE    "Enter Degrees in °F", 0
prompt2 BYTE    "Enter second number", 0
string  BYTE    40 DUP (?)
resultLbl BYTE  "The temperature in °C is: ", 0
sum     BYTE    11 DUP (?), 0

; Formula T(°C) = (T(°F) - 32) × 5/9

.CODE
_MainProc PROC
        input   prompt1, string, 40      ; read ASCII characters
        atod    string          ; convert to integer
        mov     number1, eax    ; store in memory

              ; des  src
        sub     eax, 32
        mov     number1, eax 
        mov     number1, 5
        imul    number1         ; multiply what's in eax 5 with number1 (stores in eax)
        mov     number1, 9      ; move 9 to number1 prepping for division
        idiv    number1         ; now do division
            
        dtoa    sum, eax        ; convert to ASCII characters
        output  resultLbl, sum          ; output label and sum

        mov     eax, 0  ; exit with return code 0
        ret
_MainProc ENDP
END                             ; end of source code    