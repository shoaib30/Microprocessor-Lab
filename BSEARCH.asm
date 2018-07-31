;bsearch.asm
;Shoaib Ahmed
;11.9.15
;implementing binary search

assume cs:code,ds:data

data segment
a       db      10h,20h,30h,40h,50h,60h,70h
n       db      (n-a)
key     db      20h
msg1    db      0ah,0dh,"key not found$"
msg2    db      0ah,0dh,"Key found at position "
pos     db      ?,"$"
data ends

code segment
START:  MOV     ax,data
        MOV     ds,ax
        MOV     al,0
        MOV     dl,n
        DEC     dl

AGAIN:  MOV     cl,al
        CMP     al,dl
        JA      FAIL
        ADD     al,dl
        SHR     al,1
        MOV     ah,0
        MOV     si,ax
        MOV     bl,[si]
        CMP     bl,key
        JAE     LOC1
        INC     al
        JMP     AGAIN

LOC1:   JE      SUCS
        DEC     al
        MOV     dl,al
        MOV     al,cl
        JMP     AGAIN

SUCS:   ADD     al,30h
        MOV     pos,al
        LEA     dx,msg2
        JMP     DISP

FAIL:   MOV     dx,offset msg1

DISP:   MOV     ah,9h
        INT     21h

        MOV     ah,4ch
        INT     21h

code ends
    end start
