Codigo SEGMENT

 Assume cs:codigo; ds:codigo; es:codigo; ss:codigo
 org 100H

Entrada: JMP Somacentena

   AUX DB 4   ;vetor de 4 bits
   
   msg1 db 'Digite um numero Numero: ','$' 
   msg2 db  0AH,0DH,'Digite um numero Numero: ','$'    
   msgt db  0AH, 0DH,'Soma: $'

   
   AUX1 DB 4   
   RES DB 4
   
Somacentena proc near

   ;Leitura da mensagem
   MOV DX, OFFSET msg1   ;movendo o valor do vetor para dx
   CALL PRINTMSG;
   
   
   MOV DX, OFFSET AUX    ;movendo o valor do vetor para dx

   CALL LER ;ler valor e colocar em aux
   ;CALL BARRAN
   
   ;Leitura da mensagem
   MOV DX, OFFSET msg2   ;movendo o valor do vetor para dx
   CALL PRINTMSG
   
   
   MOV DX, OFFSET AUX1   ;movendo valor de aux1 para dx

   CALL LER              ; ler valor e coloca em aux1
   
   MOV AL, AUX+3         ;coloca o valor de aux3 no registrador al
   MOV AH, AUX+2         ;coloca o valor de aux2 no registrador ah
   MOV BL, AL            ;move o valor al para bl / pois al tera que que ser desalocado
   MOV BH,AH             ;move o valor ah para bh / pois ah tera que que ser desalocado

   MOV AL,AUX1+3         ;coloca o valor de aux3 no registrador al
   MOV AH, AUX1+2        ;coloca o valor de aux2 no registrador ah
   MOV CL,AL             ;move o valor al para cl / pois al tera que que ser desalocado
   MOV CH,AH             ;move o valor ah para ch / pois ah tera que que ser desalocado
     
   CALL SOMA             ;chama soma
   
   
   
   MOV DX, OFFSET msgt
   CALL PRINTMSG 
   MOV DL, RES+2; mostrar Somacentena
   CALL PRINTCHAR
   MOV DL,RES+3; mostrar dezena
   CALL PRINTCHAR
   MOV DL, RES+4; mostrar unidade
   CALL PRINTCHAR
   INT 20H 
   
Somacentena ENDP
   
   
SOMA proc near
   ADD BL,CL   ;soma cl em bl
   MOV AH,0    ;zera ah para evitar erros de overflow
   MOV AL,BL   ;move bl pra al pois al sera requisitado como registrador padrao de ajuste
   AAA         ;ajuste para decimal - exclusivamente no registrador al
   
   MOV DX,AX    ;move o valor de ax para dx para realizar operacao 
   OR DX, 3030H ;converte para ascii
   MOV RES+4,DL ;peguei a parte baixa do valor convertido e coloquei no vetor reposta
   AAA          ;ajuste para decimal
   
   
   MOV BL,DH    ;valor temporario resultante da soma dos primeiros digitos ( fica 1 vai 1)
   
   
   ADD BH,CH    ;soma dos digitos da dezena
   MOV AH,0     ;zera o ah para evitar falhas de ajuste
   MOV AL,BH    ;colocando o resultante da soma em al, por o ajuste ocorre apenas em al
   AAA          ;ajuste em decimal
   MOV DX,AX    ;pega o valor do registrador inteiro ajustado e coloca em dx
   OR DX,3030H  ;operacao bit a bit para converter para ascii
   MOV RES+3,DL ;pega a resulta da unidade dessa soma e coloca no vetor
   
   MOV CH,DH    ; + 1 da soma das dezenas que vai virar a centena
   
   MOV AH,0     ; zerei o ah para futuros ajustes
   ADD BL,RES+3 ;soma a soma das dezenas com o +1 das unidades
    
   MOV AL,BL    ;move o resultado em bl para al para conversao em decimal 
   AAA          ;ajuste
   MOV DX,AX    ;move todo o registrador para conversao em ascii
   OR DX,3030H  ;conversao bit a bit para ascii
   MOV RES+3,DL ;pega a parte baixa e coloca no vetor posicao 3
   AAA          ;ajuste para decimal
   MOV RES+2,CH ;pega o restante da soma de dezena e coloca no vetor posicao 2
   AAA          ;converte para decimal
   RET
SOMA ENDP


LER proc near
   MOV AH, 0AH   ;comando de leitura do vetor
   INT 21h       ;interrupcao
   ret           ;retorna para a funcao inicial de chamada
LER endp

PRINTCHAR proc near
   mov AH, 02h ;02h = imprime char
   int 21h     ;interrupcao
   ret         ;retorna para a funcao inicial de chamada
PRINTCHAR endp

PRINTMSG proc near
   mov ah,09   ;09 =  comando para imprimir vetor de char
   int 21h     ;interrupcao
   ret         ;retorna pra funcao inicial de chamada
PRINTMSG endp
   
   
   Codigo ENDS
   END Entrada