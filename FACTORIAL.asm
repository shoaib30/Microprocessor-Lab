;shoaib ahmed
;30.9.15
;factorial
;FACT.asm

assume cs:code,ds:data

data segment
x       db      4
fact    db      ?
data ends

code segment
START:  MOV     ax,data
        MOV     ds,ax
        MOV     al,x
        CALL    FACTO
        MOV     al,fact
        AAM
        ADD     ax,3030h
        PUSH    ax
        MOV     dl,ah
        MOV     ah,2h
        INT     21h
        POP     ax
        MOV     dl,al
        MOV     ah,2h
        INT     21h

        MOV     ah,4ch
        INT     21h

FACTO   PROC
        CMP     al,1
        JBE     FIN
        PUSH    ax
        DEC     al
        CALL    FACTO
        POP     ax
        MUL     fact
        MOV     fact,al
        RET

FIN:    MOV     fact,1
        RET
FACTO   ENDP

code    ends
        end     start
