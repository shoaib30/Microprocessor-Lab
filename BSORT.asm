;BSORT.asm
;Shoaib Ahmed
;11.9.15
;Implementing Bubble Sort

assume cs:code,ds:data
data segment
x       db      5h,2h,3h,4h,1h
n       dw      (n-x)
data ends

code segment
start:  MOV     ax,data
        MOV     ds,ax

        MOV     bx,n
        DEC     bx

NEXT:   MOV     cx,bx
        MOV     ah,0
        LEA     si,x
NXTCMP: MOV     al,[si]
        CMP     al,[si+1]
        JBE     DONOT
        XCHG    al,[si+1]
        XCHG    [si],al
        MOV     ah,1

DONOT:  INC     si
        LOOP    NXTCMP

        CMP     ah,0
        JE      FINISH
        DEC     bx
        CMP     bx,0
        JNE     NEXT

DISP:   LEA     si,x
        MOV     cx,n
RPT:    MOV     bx,[si]
        ADD     bx,30h
        MOV     dx,bx
        MOV     ah,2h
        INT     21h
        MOV     dx,','
        MOV     ah,2h
        INT     21h
        INC     si
        LOOP    RPT

FINISH: MOV     ah,4ch
        INT     21h

code ends
    end start
