; ----------------------------------------------------------------------
; @author: Felipe Andrade Garcia Tommaselli (11800910)

; Aula 2 de Simulação
; Exercicio 2

; Programa: Utilizando rotinas de atraso, escrever um programa em Assembly que gere duas ondas
; quadradas: uma com frequência de aproximadamente 10 kHz e outra com frequência de
; aproximadamente 20 kHz. Uma solicitação de interrupção externa 0 (Int0 - sensível a
; descida de borda) altera entre as duas frequências, enviando o sinal para a saída P2.2 o
; que piscará o Led na frequência determinada. O programa deve ficar em loop infinito
; alternando as frequências a cada solicitação de interrupção. Inserir uma chave para
; acionar a interrupção via Simple Keypad 

; ----------------------------------------------------------------------

		ORG 0
		SJMP	PROG

		ORG 0003h
		SJMP 	EXT_0

; ----------------------------------------------------------------------

PROG: 		; setar os pinos de interupçao
		SETB	EA ; habilita todos os pinos
		SETB	EX0 ; seta o P3.2
		SETB 	IT0 ; sensível a borda de descida

		CLR 	F0 ; flag de led ligado, 
			   ; F0 = 0: 10 kHZ
			   ; F0 = 1: 20 kHz

		; CONTROLE DE FLUXO!
FLUXO:		JB	F0, FREQ20 ;

; ----------------------------------------------------------------------


FREQ10:		; Onda quadrada de 10kHZ

		CPL	P2.2 ; troca o valor do led
		CALL	DELAY10; ; chama o delay
		JMP	FLUXO


FREQ20:		; Onda quadrada de 20kHZ

		CPL	P2.2 ; troca o valor do led
		CALL	DELAY20; ; chama o delay
		JMP	FLUXO


; ----------------------------------------------------------------------

EXT_0:		CLR	EA ; desabilita interrupções

		CPL	F0 ; troca de delay na subida de borda

		SETB	EA; ; reabilita interrupções
		RETI


; ----------------------------------------------------------------------

DELAY10: 	; DELAY DE 100 MICROSEGUNDOS (10 kHz)
		MOV	R0, #031h
		NOP
		DJNZ	R0, $
		RET

DELAY20: 	; DELAY DE 50 MICROSEGUNDOS (20 kHz)
		MOV	R0, #018h
		NOP
		DJNZ	R0, $
		RET

		END



