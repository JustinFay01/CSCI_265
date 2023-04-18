;----------------------------------------------------------------------
;
;  MP6 Solution
;
;  Find the factorial

.586
.MODEL FLAT

INCLUDE io.h            ; header file for input/output

.STACK 4096

; Data section --> Include space for messages

.DATA
number    DWORD   ?
prompt1   BYTE    "Enter number", 0
fail      BYTE    "Operation failed",0
negative  BYTE    "Cannot find factorial of negative number",0
string    BYTE    40 DUP (?)
resultLbl BYTE    "The result is"
sum       BYTE    20 DUP (?), 0

.CODE
_MainProc PROC
        input   prompt1, string, 40      ; read ASCII characters
        atod    string          ; convert to integer
        mov     ebx, eax    ; store in memory

		; Negative input?
        cmp eax, 0
        jl NEGNUM

		; Computation loop
FACTORIAL:
        sub ebx, 1
        cmp ebx, 1
        je PRINTRES
        mul ebx
        jmp FACTORIAL

		; Error message
NEGNUM:
        output fail,negative
        jmp FINISH

		; Print up the result as part of result label
PRINTRES:
        dtoa sum, eax
        output resultLbl,resultLbl

		; all done
FINISH:
        mov     eax, 0  ; exit with return code 0
        ret
_MainProc ENDP
END                             ; end of source code

