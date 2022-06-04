; ****************************************************
; @author: Felipe Andrade Garcia Tommaselli (11800910)

; Lista 1- Aula 3
; Exercicio 3

; Programa: Código com o objetivo de por meio de valores
; guardados em um DB, comparando eles para indicar 
; o menor deles que sera guardado em 1200h da RAM ext
; ****************************************************

		ORG 	0

		MOV	DPTR, #VALOR
		CLR	A
		MOVC 	A, @A+DPTR
		MOV	30h, A
		MOV	A, #01H
		MOVC	A, @A+DPTR
		CJNE	A, 30H, TEST
		
TEST:		JC	MENOR
		MOV	A, 30h

MENOR:		MOV	DPTR, #1200h
		MOVX	@DPTR, A
		SJMP	$             ; fim lógico do programa

VALOR:		DB	3Ah, 0A3h
		
		END