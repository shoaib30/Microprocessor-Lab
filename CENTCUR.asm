;shoaib ahmed
;30.9.15
;

assume cs:code,ds:data

data segment

data ends

code segment
START:  MOV     ah,0
        MOV     al,3    ;resolution of 80x25
        INT     10h     ;setting resolution (bios interrupt)
        MOV     ah,02   ;moving cursor to a particular col
        MOV     dl,40d  ;col number stored in dl
        MOV     dh,12d  ;row number stored in dh
        INT     10h
        ;bl reg - blink:bg:bg:bg:intensity:fg:fg:fg
        MOV     ah,9
        MOV     bl,8ch  ;using the above structure for bl
        MOV     cl,1    ;numbe of char to be displayed
        MOV     al,'X'
        INT     10h
        MOV     ah,7    ;holding the screen for input without echo
        INT     21h
        MOV     ah,4ch
        INT     21h

code    ends
        end start
