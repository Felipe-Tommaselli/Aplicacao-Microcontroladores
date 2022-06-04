; ----------------------------------------------------------------------
; @author: Felipe Andrade Garcia Tommaselli (11800910)

; Lista 1
; Exercicio 5

; ----------------------------------------------------------------------

		ORG	0h ; programa principal
		SJMP	PROG

		ORG	03h ; externa 0
		SJMP	EXT_0

		ORG	13h ; externa 1
		SJMP	EXT_1

; ----------------------------------------------------------------------


PROG:		SETB	EA
		SETB	EX0 ; habilita EX0
		SETB	IT0
		SETB 	PX0 ; alta prioridade
		SETB	EX1 ; habilita EX1
		SETB	IT1
		CLR	PX1 ; baixa prioridade

		SETB	ET0
		; timer 0 e timer 1, modo 1
		MOV	TMOD, #00010001b
		MOV	TH0, #0D8h ; 10 milisegundos
		MOV	TL0, #0F0h
		MOV	TH1, #015h ; 60 milisegundos
		MOV	TL1, #0A0h

		SETB	PT0 ; prioridade alta
		CLR	PT1 ; prioridade baixa

		SETB	TR0 ; dispara os dois timers
		SETB	TR1
		SJMP	$ ; segura o prog aguardando interrupções

EXT_0:		; troca os valores de 5000h da ram externa com P1
		MOV	R0, P1
		MOV	DPTR, #5000h
		MOVX	A, @DPTR
		MOV	P1, A
		MOV	A, R0
		MOVX	@DPTR, A ; trocados!
		RETI

EXT_1:		; passa o valor de 5000h externo para 7Fh interno
		MOV	DPTR, #5200h
		MOVX	A, @DPTR
		MOV	7Fh, A
		RETI

TIMER_0:	; passa o valor de 7Fh para 5000h externo
		MOV	A, 7Fh
		MOV	DPTR, #5200h
		MOVX	@DPTR, A
		RETI

TIMER_1:	; passa valor da externa 5200h para 5000h 
		MOV	DPTR, #5200h
		MOVX	A, @DPTR
		MOV	DPTR, #5000h
		MOVX	@DPTR, A
		RETI

		END