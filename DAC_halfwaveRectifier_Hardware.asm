assume cd:code,ds:data

data segment
sine        db      0,11,22,33,43,54,63,72,104,109,115,119,122
            db      125,126,127,126,122,119,115,109,104,97,81,72
            db      63,54,43,33,22,11
PA          equ     22a0h
CR          equ     22a3h
data ends

code segment
START:      MOV     ax,data
            MOV     ds,ax

            MOV     al,80h
            MOV     dx,CR
            OUT     dx,al

RPT:        MOV     dx,PA
            LEA     si,sine

NXT:        MOV     al,[si]
            OUT     dx,al
            INC     si
            LOOP    NXT

            MOV     cx,36d      ;for getting the flat part of the half wave
            MOV     al,0
NXT2:       OUT     dx,al
            LOOP    NXT2

            MOV     ah,06h      ;waiting for i/o
            MOV     dl,0ffh     ;checking input
            INT     21h

            JZ      RPT
            MOV     ah,4ch
            INT     21h

code ends
        end START
