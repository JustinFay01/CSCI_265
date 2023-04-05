.586                    ; Assembler Directive (Similar to Import Statement)
                        ; Labels include: Number, Sum, and MainProc

                        ; Compiler dosen't care about white space, 
                        ; Assembler expects Label Start at location 0 
.MODEL FLAT
 
.STACK  4096            ; reserve 4096-byte stack
 
.DATA                   ; reserve storage for data, Tells assmbler what it is going to interpret
number  DWORD   -105    ; Local Variable, "Variable name, Type, Value" 
sum     DWORD   ?       ; Memory is allocated by first available
 
.CODE                           ; start of main program code
_MainProc    PROC
        mov     eax, number     ; Stack Instruction "Function, Destination, Source"
        add     eax, 158        
        mov     sum, eax        
 
        mov   eax, 0            ; 0 in eax is return convention         
        ret
_MainProc    ENDP
 
END                             ; end of source code