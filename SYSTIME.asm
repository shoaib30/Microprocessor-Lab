;SYSTIME.asm
;shoaib ahmed
;06.09.2015
;System time

assume cs:code

code segment
START:  MOV     ah,2ch
        INT     21h     ;ch:hrs,cl:mins
        MOV     al,ch
        CALL    DISP
        MOV     dl,':'
        MOV     ah,2
        INT     21h
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
code    ends
        END     START
