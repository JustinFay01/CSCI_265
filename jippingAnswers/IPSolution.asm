;  Week 16 day 1 -- read an IP number and subnet mask and print the network ID
;
;  Mike Jipping
;  May 2021

.586
.MODEL FLAT

INCLUDE io.h            ; header file for input/output

.STACK 4096

.DATA
octets  DWORD   4 DUP (?)
subnet  DWORD   4 DUP (?)
octetstr BYTE	16 DUP (?)
prompt1 BYTE    "Enter the IP number", 0
prompt2 BYTE    "Enter the subnet mask", 0
string  BYTE    80 DUP (?)
resultLbl BYTE  "The network ID is", 0

.CODE
_MainProc PROC

;*** First read the IP address and convert the numbers to octets

        input   prompt1, string, 40      ; read ASCII characters
		mov     edx, 0    ; octet #
		mov     ebx, 0    ; character counter
nexto:  mov		ecx, 0	  ; digit in octet
	; for each octet...
oct:    mov		al, string[ebx]
		mov     octetstr[ecx], al
		inc     ebx
		inc     ecx
		cmp     string[ebx], "."   ; dot in the middle of the string
		je      gotdot
		cmp     string[ebx], 0     ; at the end of the string (no dot)
		je      gotdot
		jmp	    oct
	; turn the dot into a 0 for "atod"
gotdot: mov     octetstr[ecx], 0
		atod	octetstr
		mov     octets[edx*4], eax
		inc		ebx
		inc     edx
		cmp     edx, 4
		jl		nexto	
		
		input   prompt2, string, 40      ; read ASCII characters
		mov     edx, 0    ; octet #
		mov     ebx, 0    ; character counter
nexts:  mov		ecx, 0	  ; digit in octet
	; for each octet...
octs:   mov		al, string[ebx]
		mov     octetstr[ecx], al
		inc     ebx
		inc     ecx
		cmp     string[ebx], "."    ; dot in the middle of the string
		je      gotdots
		cmp     string[ebx], 0      ; at the end of the string (no dot)
		je      gotdots
		jmp	    octs
	; turn the dot into a 0 for "atod"
gotdots: 
		mov     octetstr[ecx], 0
		atod	octetstr
		mov     subnet[edx*4], eax
		inc		ebx
		inc     edx
		cmp     edx, 4
		jl		nexts	

		mov		eax, octets[0]
		mov     ebx, subnet[0]
		and     subnet[0], eax
		mov		eax, octets[4]
		and     eax, subnet[4]
		mov     octets[4], eax
		mov		eax, octets[8]
		and     eax, subnet[8]
		mov     octets[8], eax
		mov		eax, octets[12]
		and     eax, subnet[12]
		mov     octets[12], eax

; convert the 4 octets to a dotted string
		mov     edx, 0   ; octet #
		mov     ecx, 0   
		mov     ebx, 0   
octo: 	dtoa    string[ebx], octets[edx*4]
look0:  cmp     string[ebx], 0
        je      dodot
		inc     ebx
		jmp     look0
dodot:  cmp     edx, 3
        je      outt
		mov     string[ebx], "."
		inc     edx
		inc     ebx
		jmp     octo

; output the string
outt:   mov     string[ebx], 0
        output  resultLbl, string

        mov     eax, 0  ; exit with return code 0
        ret
_MainProc ENDP
END                             ; end of source code

