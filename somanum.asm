.MODEL SMALL
.DATA
	MSG1 DB 'Insira um num zero a dez: $'
	MSG2 DB 0AH,'Insira outro num: $'
	MSG3 DB 0ah,'A soma: $'	

Codigo SEGMENT
	Assume CS: Codigo;DS:Codigo; ES: Codigo; SS:Codigo
	Org 100H

Entrada: JMP Nomeprog

	Nomeprog PROC NEAR
		MOV AX, @Data
		MOV DS, AX
		LEA DX, MSG1
		CALL PrintarStr
		CALL InputKey
		MOV CL,AL
		LEA DX, MSG2
		MOV AH, 9
		INT 21H
		CALL InputKey
		MOV BL,AL
		ADD CL,BL
		MOV AL,CL
		MOV AH,0
		AAA
		ADD AX,3030H
		MOV BX,AX
		LEA DX, MSG3
		CALL PrintarStr
		MOV DL,BH
		CALL PrintarChar
		MOV DL,BL
		CALL PrintarChar
		MOV AH, 04CH
		INT 21H
	Nomeprog ENDP

	InputKey PROC NEAR
		MOV AH,01H
		INT 21H
		RET
	InputKey ENDP

	PrintarStr PROC NEAR
		MOV AH, 09
		INT 21H
		RET
	PrintarStr ENDP

	PrintarChar PROC NEAR
		MOV AH,02H
		INT 21H
		RET
	PrintarChar ENDP 
	
Codigo ENDS
	END Entrada
