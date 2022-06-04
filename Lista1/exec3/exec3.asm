; ----------------------------------------------------------------------
; @author: Felipe Andrade Garcia Tommaselli (11800910)

; Lista 1
; Exercicio 3

; ----------------------------------------------------------------------

		ORG	0h ; SETANDO INÍCIO DO PROGRAMA
		SJMP	PROG

		ORG	03h ; INTERRUPÇÃO EX0
		SJMP	EXT_0

		ORG	13h ; INTERRUPÇÃO EX1
		SJMP	EXT_0

PROG:		SETB	EX0
		SETB	EX1
		SETB	IT0
		SETB	IT1
		SETB	EA

		SETB	P1.1 ; encher o tanque
		CLR	P1.0
		SJMP	$

EXT_0:		CPL	P1.0 ; troca de encher para esvaziar
		CPL	P1.1
		RETI

		END