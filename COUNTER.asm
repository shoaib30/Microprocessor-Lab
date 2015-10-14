;COUNTER.asm
;Shoaib Ahmed
;14.10.15
;counter in the center of the screen

assume cs:code,ds:data

data segment

data ends

code segment
START:  MOV     ah,0
        MOV     al,3    ;resolution of 80x25
        INT     10h     ;setting resolution (bios interrupt)
        INT     10h
        MOV     cx,100d
        MOV     bl,00
NXT:    MOV     al,bl
        MOV     ah,02   ;moving cursor to a particular col
        MOV     dl,40d  ;col number stored in dl
        MOV     dh,12d  ;row number stored in dh
        INT     10h
        CALL    DISP
        CALL    DELAY
        INC     bl
        LOOP    NXT
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
        end START
