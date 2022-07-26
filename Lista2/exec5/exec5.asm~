; ----------------------------------------------------------------------
; @author: Felipe Andrade Garcia Tommaselli (11800910)

; Lista 2
; Exercicio 5

; ----------------------------------------------------------------------

SERIAL:
	
	SETB		ES
	SETB		TR1			;EXTERNA 1
	MOV		TMOD,#25H
	MOV		SCON,#40H		;MODO 1 - 9600,N,8,1
	MOV		TH1,#0FDH	
	MOV		TL1,#0FDH
	
; ----------------------------------------------------------------------

ENVIAR:	MOV		R0,#30H
LOOP:	MOV		A,@R0
	CJNE		A,#0AH,VERIF

; ----------------------------------------------------------------------

VERIF:	JC		MENOR
	ADD		A,#07H
MENOR:	ADD		A,#30H
	MOV		SBUF,A
	INC		R0
	JNB 		TI,$
	CLR		 TI
	CJNE		R0,#38H,LOOP
	CLR		EX0
	CLR		EX1
	SETB		REN
	
; ----------------------------------------------------------------------

AGUARDA:	
	JNB 		RI,$
	MOV		 A, SBUF
	CLR 		RI
	CJNE		A,#3CH,AGUARDA
	CLR		REN
	RET

	END
