;shoaib ahmed
;ALP to implement and elevator
;elevator.asm

assume cs:code,ds:data
data segment
PA      EQU     20a0h
PB      EQU     20a1h
PC      EQU     20a2h
CR      EQU     20a3h
data ends

code segment
START:  MOV     ax,data
        MOV     ds,ax
        MOV     al,82h
        MOV     dx,CR
        OUT     dx,al

        MOV     al,00h
        MOV     dx,PA
        OUT     dx,al
        MOV     al,0f0h
        OUT     dx,al
        MOV     dx,PB

SCAN:   IN      al,dx
        AND     al,0fh
        CMP     al,0fh
        JE      SCAN
        MOV     cl,01
ROTA:   ROR     al,1
        JC      NXT
        JMP     STMOV

NXT:    ADD     cl,03h
        JMP     ROTA

STMOV:  MOV     dx,PA
        MOV     al,0f0h

NXTLED: OUT     dx,al
        CALL    DELAY
        INC     al
        DEC     cl
        JNZ     NXTLED
        CALL    DELAY
        CALL    DELAY
        DEC     al
        AND     al,0fh

CMDOWN: OUT     dx,al
        CALL    DELAY
        DEC     al
        CMP     al,00h
        JGE     CMDOWN

        MOV     ah,4ch
        INT     21h

DELAY   PROC
        MOV     si,0fffh
l2:     MOV     di,0fffh
l1:     DEC     di
        JNZ     l1
        DEC     si
        JNZ     l2
        RET
DELAY   ENDP

code    ends
        end START
