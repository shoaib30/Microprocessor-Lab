;Stepper motor hardware exp
;Shoaib Ahmed
;18.11.15
;Stepper_motor_Hardware.asm


assume cs:code,ds:data
data segment
PA      EQU     20a0h
CR      EQU     20a3h
data ends

code segment
START:  MOV     ax,data
        MOV     ds,ax

        MOV     al,80h
        MOV     dx,CR
        OUT     dx,al

        MOV     cx,50d      ;1 step is 1.8deg
        MOV     al,11h
        MOV     dx,PA

RPT:    OUT     dx,al
        CALL    DELAY
        ROR     al,1        ;ROL will rotate in Anticlockwise dir
        LOOP    RPT

        MOV     ah,4ch
        INT     21h

DELAY   PROC                ;defines the speed of rotation
        MOV     si,0ffh
l2:     MOV     di,0ffh
l1:     DEC     di
        JNZ     l1
        DEC     si
        JNZ     l2
        RET
DELAY   ENDP

code ends
        end START
