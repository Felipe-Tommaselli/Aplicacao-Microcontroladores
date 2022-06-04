; ****************************************************
; @author: Felipe Andrade Garcia Tommaselli (11800910)

; Lista 1- Aula 3
; Exercicio 4

; Programa: Realiza um tratamento condicional da chave
; P1.0, dependendo do seu valor ativará a o led P3.0 ou
; o P3.1, o programa roda em um loop infinito
; ****************************************************


		ORG	0

		MOV	DPTR, #1200H

LOOP:		JB	P1.0,ESC
		MOV	A, #0FFH
		MOVX	@DPTR, A
		SETB	P3.0
		CLR	P3.1
		SJMP	LOOP

ESC:		MOV	A, #07FH
		MOVX	@DPTR,A
		SETB	P3.1
		CLR	P3.0
		SJMP	LOOP

		END