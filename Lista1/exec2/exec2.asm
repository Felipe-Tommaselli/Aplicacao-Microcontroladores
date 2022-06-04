; ----------------------------------------------------------------------
; @author: Felipe Andrade Garcia Tommaselli (11800910)

; Lista 1
; Exercicio 2

; ----------------------------------------------------------------------

		ORG	0 ; SETANDO INÍCIO DO PROGRAMA
		SJMP	PROG

		ORG	03h ; INTERRUPÇÃO EX0
		SJMP	EXT_0

		ORG	13h ; INTERRUPÇÃO EX1
		SJMP	EXT_1

		ORG	1Bh ; INTERRUPÇÃO TIMER 1
		SJMP	TIMER_1
; ----------------------------------------------------------------------

PROG:		SETB	EA
		SETB	EX0 ; seta interrupçao externa 0
		SETB	EX1 ; externa 1
		SETB	ET1 ; seta timer 1
		SETB	IT0 ; ex0 ativada com descida
		SETB	IT1 ; ex1

		SETB	PX0 ; ex0 prioridade alta
		CLR	PX1 ; ex1 prioridade baixa
		CLR	PT1 ; t1 prioridade baixa
		SJMP	$

EXT_0:		MOV	DPTR,#4000h
		MOVX	A,@DPTR
		MOV	DPTR, #4200h
		MOVX	@DPTR, A
		RETI

EXT_1:		MOV	DPTR, #4200h
		MOVX	A, @DPTR
		MOV	P1, A
		RETI

TIMER_1:	MOV	A, P2
		MOV	DPTR,#4200H
		MOVX	@DPTR,A
		RETI


		END
