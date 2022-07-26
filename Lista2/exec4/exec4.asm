; ----------------------------------------------------------------------
; @author: Felipe Andrade Garcia Tommaselli (11800910)

; Lista 2
; Exercicio 4

; ----------------------------------------------------------------------
	ORG		0
	JMP		INICIA
	ORG		0003H
	JMP		EXT0
	ORG		031H
	JMP		EXT1


; ----------------------------------------------------------------------

INJETANDO	EQU		20H.0
MOTOR	EQU		P3.7

; ----------------------------------------------------------------------

INICIA:
	SETB		EX0
	SETB		EX1
	SETB		IT0
	MOV		TMOD,#6h
	SETB		TR0
	SETB		EA

; ----------------------------------------------------------------------

LOOP:
	JB		INJETANDO,INJETA
	SJMP		LOOP

; ----------------------------------------------------------------------

INJETA:
	SETB		MOTOR
LOOPINJETA:
	ACALL		ESCREVE
	JNB		INJETANDO,DESLIGA
	SJMP		LOOPINJETA
	
DESLIGA:
	CLR		MOTOR
	SJMP		LOOP

; ----------------------------------------------------------------------

ESCREVE:
	MOV		P2,#0h
	MOV		A,#0H
	ACALL		DISPLAY
	
	MOV		A,TL0
	ACALL		CONVBCD
	MOV		A,R1
	SETB		P2.0
	ACALL 		DISPLAY
	CLR		P2.0
	
	MOV		A,R2
	SETB		P2.1
	ACALL		DISPLAY
	CLR		P2.1
	
	MOV		A,TL0
	ACALL		CONVBCD
	MOV		A,R1
	SETB		P2.4
	ACALL		DISPLAY
	CLR		P2.4
	
	MOV		A,R2
	SETB		P2.5
	ACALL		DISPLAY
	CLR		P2.5

; ----------------------------------------------------------------------

CONVBCD:
	MOV		B,#0AH
	DIV		AB
	MOV		R2,A
	MOV		R1,B
	SWAP		A
	ORL		A,R1
	RET
	
DISPLAY:
	MOV		P2,#0H
	CJNE		A,#0H,DIG1
	MOV		P2,#7EH
	RET
DIG1:
	CJNE		A,#1H,DIG2
	MOV		P2,#30H
	RET
DIG2:
	CJNE		A,#2H,DIG3
	MOV		P2,#6DH
	RET
DIG3:
	CJNE		A,#3H,DIG4
	MOV		P2,#79H
	RET
DIG4:
	CJNE		A,#4H,DIG5
	MOV		P2,#33H
	RET
DIG5:
	CJNE		A,#5H,DIG6
	MOV		P2,#5BH
	RET
DIG6:
	CJNE		A,#6H,DIG7
	MOV		P2,#5FH
	RET
DIG7:
	CJNE		A,#7H,DIG8
	MOV		P2,#70H
	RET
DIG8:
	CJNE		A,#8H,DIG9
	MOV		P2,#7FH
	RET
DIG9:
	CJNE		A,#9H,DIG10
	MOV		P2,#7BH
	RET
DIG10:
	CJNE		A,#0AH,DIG11
	MOV		P2,#77H
	RET
DIG11:
	CJNE		A,#0BH,DIG12
	MOV		P2,#1FH
	RET
DIG12:
	CJNE		A,#0CH,DIG13
	MOV		P2,#4EH
	RET
DIG13:
	CJNE		A,#0DH,DIG14
	MOV		P2,#3DH
	RET
DIG14:
	CJNE		A,#0EH,DIG15
	MOV		P2,#4FH
	RET
DIG15:
	CJNE		A,#4H,DIGFIM
	MOV		P2,#47H
	RET
DIGFIM:
	RET

; ----------------------------------------------------------------------

EXT1:
	SETB		INJETANDO
	RETI

EXT0:
	CLR		INJETANDO
	RETI

	END
