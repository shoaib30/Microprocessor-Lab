;FILEMAN.asm
;Shoaib Ahmed
;14.10.15
;Open a file and display its contents

assume cs:code,ds:data

data    segment
fname   db      "testf2.txt"
buff    db      100 dup(?),"$"
data    ends

code    segment
START:  MOV     ax,data
        MOV     ds,ax
        MOV     ah,3dh
        LEA     dx,fname    ;pointer to the file name
        MOV     al,00       ;read only attribute
        INT     21h         ;On finding pointer to file in AX register, if not found error in AL

        MOV     bx,ax
        MOV     ah,3fh      ;reading content from file
        MOV     cx,100d
        LEA     dx,buff     ;storing characters inbuffer
        INT     21h

        MOV     ah,3eh      ;close file
        INT     21h

        LEA     dx,buff
        MOV     ah,9h
        INT     21h
        MOV     ah,4ch
        INT     21h
code    ends
        end     START
