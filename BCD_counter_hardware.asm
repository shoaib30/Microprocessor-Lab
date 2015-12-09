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

        MOV     cx,100d
        MOV     al,00h
        MOV     dx,PA
NXT:    OUT     dx,al
        CALL    DELAY
        ADD     al,1
        DAA
        LOOP    NXT
        MOV     cx,99d
NXT1:   SUB     al,1
        DAS
        OUT     dx,al
        CALL    DELAY
        LOOP    NXT1
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
