assume cs:code,ds:data
data segment
PA      equ     44a0h   ;20a0h
PB      equ     44a1h   ;20a1h
PC      equ     44a2h   ;20a2h
CR      equ     44a3h   ;20a3h
msg     db      "No. Of 1s: "
res     db      ?,"$"
data ends

code segment
start:  MOV     ax,data
        MOV     ds,ax

        MOV     dx,cr       ;initializing 8155
        MOV     al,82h
        OUT     dx,al
        MOV     dx,PB
        IN      al,dx
        MOV     cx,8
        MOV     ah,0
BACK:   ROR     al,1
        JNC     NXT
        INC     ah
NXT:    LOOP    BACK
        MOV     bl,ah
        ADD     ah,30h
        MOV     res,ah
        MOV     ah,9
        LEA     dx,msg
        INT     21h

        MOV     al,00h
        ROR     bl,1
        JC      DISP
        MOV     al,0ffh
DISP:   MOV     dx,PA
        OUT     dx,al
        MOV     ah,4ch
        INT     21h
CODE    ENDS
        END     START
