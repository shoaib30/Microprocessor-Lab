assume cs:code,ds:data
data segment
PA      EQU     44a0h       ;20a0h
PB      EQU     44a1h       ;20a1h
PC      EQU     44a2h       ;20a2h
CR      EQU     44a3h       ;20a3h

data ends

code segment
start:  MOV     ax,data
        MOV     ds,ax
        MOV     dx,CR       ;initializing 8155
        MOV     al,80h      ;all ports for O/P
        OUT     dx,al

        MOV     al,01
RPT:    MOV     dx,pa
        OUT     dx,al
        CALL    delay
        ROR     al,1
        PUSH    ax
        MOV     ah,06h
        MOV     dl,0ffh
        INT     21h
        POP     ax
        JZ      rpt

        MOV     ah,4ch
        INT     21h

DELAY   PROC
        MOV     si,0ffh
l2:     MOV     di,0ffh
l1:     DEC     di
        JNZ     l1
        DEC     si
        JNZ     l2
        RET
DELAY   ENDP
code    ends
        end     START
