; ----------------------------------------------------------------------
; @author: Felipe Andrade Garcia Tommaselli (11800910)

; Aula 8 de Simulação

; ----------------------------------------------------------------------
	ORG	0
	SJMP	PROG
; ----------------------------------------------------------------------

PROG:
	RS	EQU	P3.4
	RW	EQU	P3.3
	ENAB	EQU	P3.2
	DAT	EQU	P2
	DQ	EQU	P3.0
	CLK	EQU	P3.1
	RST	EQU	P1.0
	ACALL	INIT_LCD
	ACALL	CLEAR_LCD
	MOV	A,#00
	ACALL	POS_LCD
	MOV	DPTR,#DADOS
; ----------------------------------------------------------------------
CONT_PRINT2:
	CLR	A
	MOVC	A,@A+DPTR
	CJNE	A,#00,CONT_PRINT
	SJMP	SAI
CONT_PRINT:
	ACALL	WRITE_TEXT
	INC	DPTR
	SJMP	CONT_PRINT2
; ----------------------------------------------------------------------
SAI:
	ACALL	CONF
; ----------------------------------------------------------------------
L1:
	ACALL	MEDE
	MOV	A,#40H
	ACALL	POS_LCD
	MOV	A,R1
	CJNE	A,#00,NEGATIVO
	MOV	30H,#'+'
	MOV	A,R0
	JB	ACC.0,PRINT_MEIO
	MOV	35H,#30H
L2:
	CLR	C
	RRC	A
L3:
	ACALL	CONV2
	MOV	A,30H
	ACALL	WRITE_TEXT
	MOV	A,31H
	ACALL	WRITE_TEXT
	MOV	A,32H
	ACALL	WRITE_TEXT
	MOV	A,33H
	ACALL	WRITE_TEXT
	MOV	A,#'.'
	ACALL	WRITE_TEXT
	MOV	A,35H
	ACALL	WRITE_TEXT
	MOV	A,#0DFH
	ACALL	WRITE_TEXT
	MOV	A,#'C'
	ACALL	WRITE_TEXT
	SJMP	L1
; ----------------------------------------------------------------------
PRINT_MEIO:
	MOV	35H,#35H
	SJMP	L2
PRINT_MEIO2:
	MOV	35H,#35H
	SJMP	L4
NEGATIVO:
	MOV	30H,#'_'
	MOV	A,R0
	JB	ACC.0,PRINT_MEIO2
	MOV	35H,#30H
L4:
	SETB	C
	RRC	A
	CPL	A
	ADD	A,#1
	SJMP	L3
; ----------------------------------------------------------------------
DADOS:
	DB	'TEMPERATURA',00
INIT_LCD:
	CLR	RW
	CLR	RS
	SETB	ENAB
; ----------------------------------------------------------------------
	MOV	DAT,#38H
	CLR	ENAB
; ----------------------------------------------------------------------
	SETB	ENAB
	MOV	DAT,#0EH
	CLR	ENAB
	RET
; ----------------------------------------------------------------------
CLEAR_LCD:
	CLR	RW
	CLR	RS
; ----------------------------------------------------------------------
	SETB	ENAB
	MOV	DAT,#01H
	CLR	ENAB
	RET
POS_LCD:
	CLR	RW
	CLR	RS
; ----------------------------------------------------------------------
	SETB	ENAB
	ADD	A,#80H
	MOV	DAT,A
	CLR	ENAB
	RET
; ----------------------------------------------------------------------
WRITE_TEXT:
	CLR	RW
	SETB	RS
	SETB	ENAB
	MOV	DAT,A
	CLR	ENAB
	RET
CONV2:
	CJNE	A,#64H,TESTE
; ----------------------------------------------------------------------
TESTE:
	JC	MENOR
	SUBB	A,#64H
	ACALL	CONVBCD
	MOV	R3,#1
	ACALL	ASCII_3
	RET
MENOR:
	ACALL	CONVBCD
	MOV	R3,#00
	ACALL	ASCII_3
	RET
CONVBCD:
	MOV	B,#0AH
	DIV	AB
	MOV	R2,A
	MOV	R1,B
	SWAP	A
	ORL	A,R1
	RET
; ----------------------------------------------------------------------
ASCII_3:
	MOV	A,R3
	ADD	A,#30H
	MOV	31H,A
	MOV	A,R2
	ADD	A,#30H
	MOV	32H,A
	MOV	A,R1
	ADD	A,#30H
	MOV	33H,A
	RET
CONF:
	MOV	A,#0AH
	ACALL	OUT_CMD
	MOV	A,#0EEH
	ACALL	OUT_CMD
	RET
; ----------------------------------------------------------------------
OUT_CMD:
	CLR	RST
	SETB	RST
	MOV	R7,#8
SERIAL:
	RRC	A
	MOV	DQ,C
	ACALL	PULSE
	DJNZ	R7,SERIAL
	RET
; ----------------------------------------------------------------------
MEDE:
	MOV	A,#0AAH	
	ACALL	OUT_CMD
	ACALL	IN_DATA	
	MOV	R0,A	
	MOV	20H.0,C	
	MOV	R1,20H	
	MOV	A,#0EEH	
	ACALL	OUT_CMD
	RET
; ----------------------------------------------------------------------
IN_DATA:
	CLR	A
	SETB	DQ
	SETB	RST
	MOV	R7,#9
; ----------------------------------------------------------------------
SERIAL2:
	SETB	CLK
	CLR	CLK
	MOV	C,DQ
	SETB	CLK
	RRC	A
	DJNZ	R7,SERIAL2
	RLC	A
	RET
; ----------------------------------------------------------------------
PULSE:
	SETB	CLK
	CLR	CLK
	SETB	CLK
	RET
; ----------------------------------------------------------------------
	END