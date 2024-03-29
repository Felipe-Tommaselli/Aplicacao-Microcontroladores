; ----------------------------------------------------------------------
; @author: Felipe Andrade Garcia Tommaselli (11800910)

; Lista 2
; Exercicio 3

; ----------------------------------------------------------------------
	ORG		0
	JMP		INICIA
	ORG		0Bh
	LJMP		TIMER0

; ----------------------------------------------------------------------

	ENVIO		EQU		20H.0
	MOTOR		EQU		P3.5
	DB0		EQU		P2.0
	DB1		EQU		P2.1
	DB2		EQU		P2.2
	DB3		EQU		P2.3
	DB4		EQU		P2.4
	DB5		EQU		P2.5
	DB6		EQU		P2.6
	DB7		EQU		P2.7
	ENAB		EQU		P3.0
	RW		EQU		P3.1
	RS		EQU		P3.2

; ----------------------------------------------------------------------

INICIA:
	CLR		ENVIO
	SETB		ET0
	MOV		TMOD,#4H
	LCALL		WAIT_LCD
	LCALL		WAIT_LCD
	LCALL		INIT_LCD

; ----------------------------------------------------------------------

LOOP:
	ACALL		CHAVES
	MOV		R0,A
	ACALL		CHAVES
	MOV		R1,A
	ACALL		ENCODER
	SJMP		LOOP

; ----------------------------------------------------------------------

ENCODER:
	MOV		A,R0
	SWAP		A
	ORL		A,R1
	
	MOV		R0,A
	MOV		A,#25H
	SUBB		A,R0
	
	MOV		TH0,A
	SETB		EA
	SETB		TR0
	
	SETB		MOTOR
LOOPFIM:
	JB		ENVIO,ENVIALCD
	SJMP		LOOPFIM

ENVIALCD:
	LCALL		CLEAR_LCD
	MOV		A,#0H
	LCALL		POS_LCD
	MOV		A,#'F'
	LCALL		WRITE_TEXT
	MOV		A,#'E'
	LCALL		WRITE_TEXT
	MOV		A,#'R'
	LCALL		WRITE_TEXT
	MOV		A,#'R'
	LCALL		WRITE_TEXT
	MOV		A,#'A'
	LCALL		WRITE_TEXT
	MOV		A,#'M'
	LCALL		WRITE_TEXT
	MOV		A,#'E'
	LCALL		WRITE_TEXT
	MOV		A,#'N'
	LCALL		WRITE_TEXT
	MOV		A,#'T'
	LCALL		WRITE_TEXT
	MOV		A,#'A'
	LCALL		WRITE_TEXT
	MOV		A,#' '
	LCALL		WRITE_TEXT
	MOV		A,#'P'
	LCALL		WRITE_TEXT
	MOV		A,#'O'
	LCALL		WRITE_TEXT
	MOV		A,#'S'
	LCALL		WRITE_TEXT
	MOV		A,#'I'
	LCALL		WRITE_TEXT
	MOV		A,#'C'
	LCALL		WRITE_TEXT
	MOV		A,#'I'
	LCALL		WRITE_TEXT
	MOV		A,#'O'
	LCALL		WRITE_TEXT
	MOV		A,#'N'
	LCALL		WRITE_TEXT
	MOV		A,#'A'
	LCALL		WRITE_TEXT
	MOV		A,#'D'
	LCALL		WRITE_TEXT
	MOV		A,#'A'
	LCALL		WRITE_TEXT
	
	CLR		MOTOR
	JMP		LOOP	

; ----------------------------------------------------------------------

INIT_LCD:
	CLR		RW
	SETB		ENAB
	CLR		RS
	MOV		A, #38H
	ACALL		ENVIA
	CLR		ENAB
	LCALL		WAIT_LCD
	SETB		ENAB
	CLR		RS
	MOV		A,#0EH
	ACALL		ENVIA
	CLR		ENAB
	LCALL		WAIT_LCD

	SETB		ENAB
	CLR		RS
	MOV		A,#06H
	ACALL		ENVIA
	CLR		ENAB
	LCALL		WAIT_LCD
	RET
	
CLEAR_LCD:
	CLR		RW
	SETB		ENAB
	CLR		RS
	MOV		A,#01H
	ACALL		ENVIA
	CLR		ENAB
	LCALL		WAIT_LCD
	RET

POS_LCD:
	CLR		RW
	SETB		ENAB
	CLR		RS
	ADD		A,#80H
	ACALL		ENVIA
	CLR		ENAB
	LCALL		WAIT_LCD
	RET
	
WRITE_TEXT:
	CLR		RW
	SETB		ENAB
	SETB		RS
	ACALL		ENVIA
	CLR		ENAB
	LCALL		WAIT_LCD
	RET

WAIT_LCD:
	MOV		R7,#122
LP:	MOV		R6,#06
	DJNZ		R6,$
	DJNZ		R7,LP
	RET

ENVIA:	MOV		R5, A
	ANL		A, #0FH
	MOV		P2, A
	MOV		A, R5
	ANL		A, #0F0H
	ANL		P0, #0FH
	ORL		P0, A
	SETB		P2.6
	SETB		P2.7
	RET

	
TIMER0:
	CLR		EA
	SETB		ENVIO
	RETI
	
CHAVES:
	MOV		P1, #0FFH
LOOP1:		
	CLR		P1.4
	JNB		P1.0, ZERO
	JNB		P1.1, TRES
	JNB		P1.2, SEIS

	MOV		P2, #0FFH
LOOP2:		
	CLR		P2.5
	JNB		P1.0, UM
	JNB		P1.1, QUATRO
	JNB		P1.2, SETE
	JNB		P1.3, NOVE

	MOV		P2, #0FFH
LOOP3:		
	CLR		P1.6
	JNB		P1.0, DOIS
	JNB		P1.1, CINCO
	JNB		P1.2, OITO
	
	MOV		P2, #0FFH
	JB		20H.2,RETORNA
	SJMP		CHAVES
RETORNA:
	CLR		20H.2
	RET

ZERO:		
	MOV		A, #00H
	SETB		20H.2
	SJMP		LOOP1
UM:	
	MOV		A, #01H
	SETB		20H.2
	SJMP		LOOP2
DOIS:
	MOV		A, #02H
	SETB		20H.2
	SJMP		LOOP3
TRES:	
	MOV		A, #03H
	SETB		20H.2
	SJMP		LOOP1
QUATRO:		
	MOV		A,#04H
	SETB		20H.2
	SJMP		LOOP2
CINCO:		
	MOV		A,#05H
	SETB		20H.2
	SJMP		LOOP3
SEIS:			
	MOV		A,#06H
	SETB		20H.2
	SJMP		LOOP1
SETE:
	MOV		A,#07H
	SETB		20H.2
	SJMP		LOOP2
OITO:
	MOV		A,#08H
	SETB		20H.2
	SJMP		LOOP3
NOVE:
	MOV		A,#09H
	SETB		20H.2
	SJMP		LOOP2
	
	END
