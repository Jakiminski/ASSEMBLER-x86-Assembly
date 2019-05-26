.MODEL SMALL

.DATA
	VAR DB 4
	NUM1 db 'Insira um num de dois digitos: ','$' 
   	NUM2 db  0AH,0DH,'Outro num de dois digitos: ','$'
   	TOT db  0AH, 0DH,'A soma: $' 
   	VAR1 DB 4   
   	RESULT DB 4

.CODE

SOMAR PROC
   	MOV AX, @DATA
   	MOV DS, AX
   
   	LEA DX, NUM1
   	CALL MOSTRASTRING;
   	LEA DX, VAR
   	CALL lertecla

   	MOV DX, OFFSET NUM2
   	CALL MOSTRASTRING
   	MOV DX, OFFSET VAR1
	CALL lertecla
   
   	MOV AL, VAR+3
   	MOV AH, VAR+2
   	MOV BL, AL
   	MOV BH,AH

   	MOV AL,VAR1+3
   	MOV AH, VAR1+2
   	MOV CL,AL
   	MOV CH,AH
   
   	CALL SOMA
   
   	MOV DX, OFFSET TOT
   	CALL MOSTRASTRING 
   	MOV DL, RESULT+2;Coloca para mostrar centena
   	CALL mostrarchar
   	MOV DL,RESULT+3;Coloca para mostrar dezena
   	CALL mostrarchar
   	MOV DL, RESULT+4;Coloca para mostrar unidade
   	CALL mostrarchar
	MOV AH, 4CH
   	INT 21H 

SOMAR ENDP

lertecla proc near
   	MOV AH, 0AH
   	INT 21H
   	RET
lertecla ENDP

mostrarchar proc near
   	MOV AH, 02H
   	INT 21h
   	RET
mostrarchar endp
   
MOSTRASTRING proc near
   	MOV AH,09
   	INT 21h 
   	RET
MOSTRASTRING endp 
   
SOMA proc near
   	ADD BL,CL
   	MOV AH,0
   	MOV AL,BL
   	AAA
   	MOV DX,AX
   	OR DX, 3030H
   	MOV RESULT+4,DL
   	AAA
   	MOV BL,DH
   	ADD BH,CH
   	MOV AH,0
   	MOV AL,BH
   	AAA
   	MOV DX,AX
   	OR DX,3030H
   	MOV RESULT+3,DL
   	MOV CH,DH
   	MOV AH,0
   	ADD BL,RESULT+3
   	MOV AL,BL
   	AAA
   	MOV DX,AX
   	OR DX,3030H
   	MOV RESULT+3,DL
   	AAA
   	MOV RESULT+2,CH
   	AAA
   	RET
SOMA ENDP

END SOMAR