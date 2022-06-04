; ----------------------------------------------------------------------
; @author: Felipe Andrade Garcia Tommaselli (11800910)

; Lista 1
; Exercicio 4

; ----------------------------------------------------------------------

		ORG	0 ; SETANDO INÍCIO DO PROGRAMA
		SJMP	PROG

; ----------------------------------------------------------------------

		ORG	03h ; INTERRUPÇÃO EX0
		SJMP	EXT_0

; ----------------------------------------------------------------------

		ORG	0Bh ; INTERRUPÇÃO T0
		INC	A
		; controle de fluxo
		; confere se ja foram as 10 rodadas (500 ms)
		CJNE	A, #10d,DELAY500
		SJMP	TIMER_0

		SJMP	TIMER_0

		ORG	13h ; INTERRUPÇÃO T1
		SJMP	TIMER_1


; ----------------------------------------------------------------------

PROG:		SETB	EX0 ; habilita interrupção 0
		SETB	IT0
		SETB	EA
		SETB	P2.7 ; 1
		SETB	P2.6 ; 1
		MOV	R0, #00d ; conta os 3 ciclos
LOOP:		CJNE	R0, #03d, LOOP ; senão fica em loop até dar os 3 ciclos
		SJMP	FIM ; encerra logicamente o programa


EXT_0:		CLR	EX0 ; externa 0
		CLR	P2.6 ; 0
		SETB 	P1.2 ; 1
		MOV	A, #00h ; 0
		SJMP	DELAY500 ; 10 delays de 50 ms, fechando os 500 ms
		RETI

TIMER_0:	SETB	P2.6 ; 1 ; timer 0
		CLR	P2.7 ; 0
		SETB	IT1 ; borda de descida
		SETB	EX1 ; habilita interrupção 1
		RETI

TIMER_1:	CLR	P2.6 ; 0
		SETB	P1.0 ; 1
		SJMP	DELAY500 ; 10 delays de 50 ms, totalizando os 500 ms
		INC	R0 ; contabiliza o fim do ciclo (até chegar em 3)
		RETI

; ----------------------------------------------------------------------


DELAY500:	SETB	ET0 ; delay de 50 ms
		MOV	TH0, #03Ch
		MOV	TL0, #0B0h
		MOV	TMOD, #00000001b
		SETB	TR0

; ----------------------------------------------------------------------

FIM:		CLR	EA ; fim lógico
		SJMP	$
		END

