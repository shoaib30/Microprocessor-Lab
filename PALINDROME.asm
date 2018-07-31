;palindrome.asm
;Shoaib Ahmed
;18.05.15
;Test whether string is palindrome

assume cs:code,ds:data
data segment
str1	db		"madam"
len1	db		(len1-str1)
str2	db		10 dup(?)
msg1	db		0ah,0dh,"String is palindrome$"
msg2	db		0ah,0dh,"String is not palindrome$"
data ends

code segment
DISP	MACRO	msg
		LEA		dx,msg
		MOV		ah,9
		INT		21h
		ENDM

START:	MOV		ax,data
		MOV		ds,ax
		MOV		es,ax

		LEA		si,len1
		DEC		si
		LEA		di,str2
		MOV		ch,0
		MOV		cl,len1
RPT:	MOV		al,[si]
		MOV		[di],al
		DEC		si
		INC		di
		LOOP	RPT

		LEA		si,str1
		LEA		di,str2
		CLD
		MOV		ch,0
		MOV		cl,len1
		REP		CMPSB
		JNZ		NOTPAL
		DISP	msg1
		JMP		FIN

NOTPAL:	DISP	msg2
FIN:	MOV		ah,4ch
		INT		21h

code	ends
		end 	START
