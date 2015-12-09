assume cs:code,ds:data

data segment
sine        db      0,11,22,33,43,54,63,72,81,90,97,104,109,115,119
            db      122,125,126,127,126,122,119,115,109,104,97,90,81
            db      72,63,54,43,33,22,11,0
PA          equ     20a0h
CR          equ     20a3h
data ends

code segment
START:      MOV     ax,data
            MOV     ds,ax

            MOV     al,80h
            MOV     dx,CR
            OUT     dx,al

RPT:        MOV     dx,PA
            LEA     si,sine
            MOV     cx,36d

NXT:        MOV     al,128d
            ADD     al,[si]
            OUT     dx,al
            INC     si
            LOOP    NXT
            MOV     cx,36d
            LEA     si,sine
NXT1:       MOV     al,128d
            SUB     al,[si]
            OUT     dx,al
            INC     si
            LOOP    NXT1

            MOV     ah,06h      ;waiting for i/o
            MOV     dl,0ffh     ;checking input
            INT     21h

            JZ      RPT
            MOV     ah,4ch
            INT     21h

code ends
        end START
