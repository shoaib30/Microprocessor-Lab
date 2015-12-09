assume cs:code,ds:data
data segment
PA      EQU     44a0h       ;20a0h
PB      EQU     44a1h       ;20a1h
PC      EQU     44a2h       ;20a2h
CR      EQU     44a3h       ;20a3h
rowVal  db      ?
colVal  db      ?
sCode   db      ?
NUM1    db      ?
NUM2    db      ?
OP      db      ?
data end

code segment
START:  MOV     ax,data
        MOV     ds,ax

NUMM1:  CALL    INP
        MOV     NUM1,al
        CALL    DELAY
        CALL    DISP

OPR:    CALL    INP
        MOV     OP,al
        CALL    DELAY
        ;CALL    DISP
        CMP     OP,11d
        JE      P1
        MOV     dl,'-'
        JMP     DIP
P1:     MOV     dl,'+'
DIP:    MOV     ah,2
        INT     21h

NUM2:   CALL    INP
        MOV     NUM2,al
        CALL    DELAY
        CALL    DISP

        CMP     OP,11d
        JE      AD
SU:     MOV     al.NUM1
        SUB     al,NUM2
        JMP     PRIN
AD:     MOV     al,NUM1
        ADD     al,NUM2
        JMP     PRIN
PRIN:   PUSH    ax
        MOV     dl,'='
        MOV     ah,2
        INT     21h
        POP     ax
        CALL    DISP

        MOV     ah,4ch
        INT     21h

INP     PROC
AGN:    MOV     al,90h      ;for A i/p and B,C o/p

        MOV     dx,CR
        OUT     dx,al

        MOV     bl,01h
        MOV     bh,3h
        MOV     ah,01
        MOV     cl,00h

NXTROW: MOV     dx,PC
        MOV     al,bl
        OUT     dx,al

        MOV     dx,PA
        IN      al,dx
        CMP     al,00h
        JNE     CAL
        ADD     cl,08h
        INC     ah
        SHL     bl,01h
        DEC     bh
        JNZ     NXTROW
        JMP     AGN

CAL:    MOV     rowVal,ah
        MOV     ah,00h

ROTA:   ROR     al,01
        JC      NXT
        INC     ah
        INC     cl
        JMP     ROTA

NXT:    MOV     sCode,cl
        MOV     colVal,ah
        MOV     al,cl
        RET
INP     ENDP

DISP    PROC
        AAM
        ADD     ax,3030h
        MOV     dl,ah
        MOV     ah,2
        PUSH    ax
        INT     21h
        POP     ax
        MOV     dl,al
        MOV     ah,2
        INT     21h
        RET
DISP    ENDP

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

CODE    ENDS
        END     START
