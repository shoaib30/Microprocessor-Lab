assume cs:code,ds:data;

data segment
PA      EQU     44a0h       ;20a0h
PB      EQU     44a1h       ;20a1h
PC      EQU     44a2h       ;20a2h
CR      EQU     44a3h       ;20a3h
rowVal  db      ?
colVal  db      ?
sCode   db      ?
data end

code segment
START:  MOV     ax,data
        MOV     ds,ax

        MOV     al,90h      ;for A i/p and B,C o/p
        MOV     dx,CR
        OUT     dx,al

AGN:    MOV     bl,01h
        MOV     bh,3h
        MOV     ah,01

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
        CALL    DISP
        MOV     ah,4ch
        INT     21h

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
