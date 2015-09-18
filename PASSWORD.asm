;PASSWORD.asm
;shoaib ahmed
;18.05.15
;password check

assume cs:code,ds:data

data segment
pwd		db		"hello"
len1	db		(len1-pwd)
epwd	db		10 dup(?)
len2	db		(len1-pwd)
msg1	db		0ah,0dh,"Enter the password: $"
msg2	db		0ah,0dh,"Password Match$"
msg3	db		0ah,0dh,"Password does not match$"
msg4	db		0ah,0dh,"Exceeded 3 attempts$"
data ends

DISP 	MACRO	msg
		LEA		dx,msg
		MOV		ah,9
		INT		21h
		ENDM
code segment
START:	MOV		ax,data
		MOV		ds,ax
		MOV		es,ax
		MOV		cl,0

RPT:	PUSH	cx
		CALL	ENTPWD
		CALL	MATCH
		POP 	cx
		INC		cl
		CMP		cl,3
		JB		RPT
		DISP	msg4

		MOV		ah,4ch
		INT		21h

ENTPWD	PROC	near
		MOV		si,offset epwd
		DISP	msg1
		MOV		bl,0
AGAIN:	MOV		ah,8
		INT		21h
		CMP		al,0dh
		JE		FIN
		MOV		[si],al
		INC		si
		INC 	bl
		MOV		dl,"*"
		MOV		ah,2
		INT		21h
		JMP		AGAIN
FIN:	MOV		len2,bl
		RET
ENTPWD	ENDP

MATCH	PROC	near
		MOV		bl,len1
		CMP		bl,len2
		JNE		DNMAT
		LEA		si,pwd
		LEA		di,epwd
		CLD
		;PUSH	cx
		MOV		ch,0
		MOV		cl,len1
REP		CMPSB
		JNZ		DNMAT
		;POP		cx
		DISP	msg2
		MOV		ah,4ch
		INT 	21h
DNMAT:	DISP	msg3
		RET
MATCH	ENDP

code	ends
		end		START
