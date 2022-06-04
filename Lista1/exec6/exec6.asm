; ----------------------------------------------------------------------
; @author: Felipe Andrade Garcia Tommaselli (11800910)

; Lista 1
; Exercicio 6

; ----------------------------------------------------------------------

		ORG	0000H
		SJMP	PROG
	
		ORG	0003H
		SJMP	MOVE

; ----------------------------------------------------------------------

PROG:		SETB	EX0
		SETB	EA
		CLR	P2.0 ; P2.0 como flag
		SETB	P1.0
		SETB	P1.1
		SETB	P1.2
		SETB	P1.3
		SJMP	$
	
MOVE:		CLR	EX0
		CLR	P1.1
		CLR	P1.3
		CALL	DELAY2
		JB	P2.0,VIRA_E
		SETB	P1.1  ; direta
		CLR	P1.3
		SETB	P2.0
		SJMP	VIRA_D
VIRA_E:		CLR	P1.1
		SETB	P1.3 ; esquerda
		CLR	P2.0
VIRA_D:		CALL	DELAY2
		SETB	P1.1
		SETB	P1.3
		SETB	EX0
		RETI

; ----------------------------------------------------------------------

DELAY2:		MOV	R2,#64H ; 2 segundos
LOOP1:		MOV	R1,#64H
LOOP:		MOV	R0,#64H
		DJNZ	R0,$
		DJNZ	R1,LOOP
		DJNZ	R2,LOOP1
		RET
		END
