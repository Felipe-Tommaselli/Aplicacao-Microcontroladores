; ----------------------------------------------------------------------
; @author: Felipe Andrade Garcia Tommaselli (11800910)

; Simul 7
; Exercicio 2

; ----------------------------------------------------------------------

		ORG	0
		SJMP	PROG

		ORG	13h
		CPL	F0 ; flag de interrupção
		RETI
		; f0 = 1 interrupçao
		; f0 = 0 continua
; ----------------------------------------------------------------------

PROG:		SETB	EA
		SETB	EX1
		SETB	IT1
		CLR	F0
		MOV	P2, #00
		MOV	P1, #00
		MOV	R7, #80h
		MOV	31h, #01
		MOV	32h, #02
		MOV	33h, #03
		MOV	34h, #04
		MOV	DPTR, #DIGITO
LOOP:		MOV	R1, #31h
LOOP2:		MOV	A, @R1
		ANL	A, #0Fh
		MOVC	A, @A+DPTR
		MOV	P2, #00
		ACALL	VERIFICA
		ACALL	MOSTRA
		SJMP	LOOP2

; ----------------------------------------------------------------------
VERIFICA:	JB	F0, VERIFICA
		NOP
		RET
; ----------------------------------------------------------------------

MOSTRA:		MOV	P1, A
		MOV	A, R7
		RL	A
		JB	ACC.4, FIM
		MOV	P2, A
		MOV	R7, A
		INC	R1
		RET
; ----------------------------------------------------------------------

FIM:		MOV	R7, #80h
		MOV	R1, #31h
		RET

; ----------------------------------------------------------------------
DIGITO:		DB	3Fh, 06, 5Bh, 4Fh, 66h, 6Dh, 7Dh, 07, 7Fh, 6Fh
; ----------------------------------------------------------------------

		END