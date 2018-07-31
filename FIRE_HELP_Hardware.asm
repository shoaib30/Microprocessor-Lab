;Fire and help hardware exp
;Shoaib Ahmed
;18.11.15
;FIRE_HELP_HARDWARE.asm

assume cs:code,ds:data
data segment
FIRE    db      71h,9fh,0f5h,61h        ;in reverse incase fire is displayed ulta
HELP    db      0d1h,61h,0e3h,31h
PA      EQU     20a0h
PB      EQU     20a1h
PC      EQU     20a2h
CR      EQU     20a3h
data ends

code segment
START:  MOV     ax,data
        MOV     ds,ax

        MOV     dx,CR
        MOV     al,80h
        OUT     dx,al

INFI:   LEA     si,FIRE
        MOV     cx,4

NXTCH:  MOV     al,[si]
        CALL    SNDBIT
        INC     si
        LOOP    NXTCH
        CALL    DELAY

        MOV     cx,4

NXTCH1: MOV     al,[si]
        CALL    SNDBIT
        INC     si
        LOOP    NXTCH1
        CALL    DELAY

        MOV     ah,06h      ;waiting for i/o
        MOV     dl,0ffh     ;checking input
        INT     21h

        JZ      INFI
        MOV     ah,4ch
        INT     21h

DELAY   PROC
        PUSH    si
        MOV     si,0ffh
l2:     MOV     di,0ffh
l1:     DEC     di
        JNZ     l1
        DEC     si
        JNZ     l2
        POP     si
        RET
DELAY   ENDP

SNDBIT  PROC
        PUSH    cx
        MOV     cx,8
NXTBIT: MOV     dx,PB
        OUT     dx,al
        PUSH    ax
        MOV     dx,PC
        MOV     al,00
        OUT     dx,al
        MOV     al,0ffh
        OUT     dx,al
        POP     ax
        ROR     al,1
        LOOP    NXTBIT
        POP     cx
        RET
SNDBIT  ENDP


code    ends
        end START
