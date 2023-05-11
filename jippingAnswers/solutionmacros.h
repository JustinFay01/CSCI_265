#
#  Macro File for use with Macro exerise (week 16 day 2)
#
#  Mike Jipping, April 2018

.586

mystrlen	MACRO	string
			mov     eax, 0
			lea     ecx, string
LEN :		cmp     string[eax], 0
			je      mLENGTHEND
			inc     eax
			jmp     LEN
mLENGTHEND:
			ENDM

lettercheck MACRO   reg,lab1,lab2
			mov     al, string[reg]
			cmp		al, 48
			jb		lab1
			cmp		al, 57
			ja		lab2
			ENDM

uppercasecheck  MACRO  lab1,lab2
				cmp		al, 65
				jb		lab1
				cmp		al, 90
				ja		lab2
				jmp		COMPARE
				ENDM

charactercheck  MACRO  lab1
				cmp		al, 97
				jb		lab1
				cmp		al, 122
				ja		lab1
				jmp		COMPARE
				ENDM

