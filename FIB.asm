;FIB.asm
;Shoaib Ahmed
;06.09.2015
;Fibbonacci

assume cs:code,ds:data
data segment
fib     db      10 dup(?)
data ends

code segment
START:  MOV     ax,data
        MOV     ds,ax

        MOV     al,0;   (n-2)
        LEA     si,fib
        MOV     [si],al
        MOV     bl,1;   (n-1)
        INC     si
        MOV     [si],bl
        INC     si
        XOR     ch,ch
        MOV     cl,8
RPT:    ADD     al,bl
        MOV     [si],al
        INC     si
        XCHG    al,bl
        LOOP    RPT
        LEA     si,fib
        MOV     cx,10
PRINT:  MOV     al,[si]
        CALL    DISP
        MOV     dx,' '
        MOV     ah,2h
        INT     21h
        INC     si
        LOOP    PRINT
        MOV     ah,4ch
        INT     21h

DISP    PROC
        AAM
        ADD     ax,3030h
        MOV     dl,ah
        PUSH    ax
        MOV     ah,2
        INT     21h
        POP     ax
        MOV     dl,al
        MOV     ah,2
        INT     21h
        RET
DISP    ENDP

code    ends
        END     START
