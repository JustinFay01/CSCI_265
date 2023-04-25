; A solution for Week 15 day 2: find array minimum recursively
;
; Solution #3: Like solution #2, we work our way to the end of the array, and compare 
;   backwards.  However, this solution uses indexed addressing on a global array label.
;
; Mike Jipping
; April 2017

.586
.MODEL FLAT

INCLUDE io.h            ; header file for input/output

.STACK 4096

; Declarations.  Note that we just declare an initialized array of integers.
.DATA
resultp BYTE    "The minimum in that array is", 0
resulta BYTE    10 DUP (?)
array   DWORD   5, 20, 10, 34, 100, 2400, 2, -7, 3, -5, 4

.CODE
_MainProc PROC

        ; Load up the parameters
        mov     eax, 0   
        push    eax   
        mov     eax, 11
        push    eax    

        ; Now make the call
        mov     eax, array[0]
        call    findmin  

        ; Return: adjust the stack (throw away the parameters), print, quit.
        add     esp, 8     ; discard two of the parameters  

        dtoa    resulta, eax        
        output  resultp, resulta
              
quit:   mov     eax, 0      ; exit with return code 0
        ret
_MainProc   ENDP        

findmin PROC

        ; First preserve the register environment so we can restore it.
        ; Notice that we do not store/restore EAX because it holds the return value
        push    ebp             ; establish stack frame
        mov     ebp, esp
        push    ebx             ; save registers
        push    ecx
        push    edx

        ; Now gather the parameters from the stack
        mov     ecx, [ebp+8]    ; length
        mov     edx, [ebp+12]   ; index

        ; Are we at the end of the array?
		inc     edx
        cmp     ecx, edx
        je      done

        ; Load up the parameters
        push    edx   
        push    ecx 

        ; Now make the call
        call    findmin  

        ; Return: adjust the stack (throw away the parameters)
        add     esp, 8   

done:
        dec     edx
        cmp     eax, array[edx*4]
        jl      return
        mov     eax, array[edx*4]

return:
        pop     edx             ; restore registers
        pop     ecx
        pop     ebx
        pop     ebp             ; restore base pointer
        ret                  
        
findmin ENDP

END                             ; end of source code

