; ----------------------------------------------------------------------
; @author: Felipe Andrade Garcia Tommaselli (11800910)

; Lista 2
; Exercicio 2

; ----------------------------------------------------------------------

	ORG	0
	SJMP	PROG
; ----------------------------------------------------------------------

PROG:	MOV	30h, #0h
	MOV	R0, #0h
	MOV	R1, #0h
; ----------------------------------------------------------------------

LOOP_1:	MOV	DPTR, #TAB
	MOV	A, R0
	MOVC	A, @A+DPTR
	INC	R0

	MOVX	@R1, A
	INC	R1
	INC	R2
	CJNE	R2, #12h, LOOP_1
	CLR	C

; ----------------------------------------------------------------------

LOOP:	MOV	DPTR, #8000h
	MOVX	A, @DPTR

; ----------------------------------------------------------------------

	CJNE	A, #1h, BIT_3
	CLR	C
	ACALL	LEDS
	MOV	P0, #0FFh
	SJMP	LOOP
BIT_3:	CJNE	A, #3h, MSB
	CLR	C
	ACALL	EX2LED
	SJMP	LOOP
MSB:	CJNE	A, #80h, LOOP
	CLR	C
	ACALL	CONT
	CLR	C
	SJMP	LOOP
;---------------------------------------------------------

LEDS:	MOV	DPTR, #8000h
	MOV	A, #0FFh
	MOVX	@DPTR, A
	ACALL	DELAY
	DEC	A
	MOVX	@DPTR, A
LOOP1:	MOV	DPTR, #8000h
	MOVX	A, @DPTR
	CJNE	A, #1h, RETURN
KEEP:	CLR	C
	MOVX	A, @DPTR
	CPL	A
	MOV	R0, A
	RL	A
	ORL	A, R0
	CPL	A
	MOVX	@DPTR, A
	ACALL	DELAY
	JNB	P0.7, LEDS
	ACALL	DELAY
	SJMP	LOOP1
RETURN:	RET
; ----------------------------------------------------------------------

EX2LED:	MOV	R1, #0h

	MOV	DPTR, #8000h
LOOP_2:	MOVX	A, @DPTR
	CJNE	A, #3h, RETURN_1
	MOVX	A, @R1
	CPL	A
	MOVX	@DPTR, A
	INC	R1
	ACALL	DELAY
	CJNE	R1, #12h, LOOP_2
	SJMP	EX2LED
RETURN_1:RET
; ----------------------------------------------------------------------

CONT:	MOV	R0, #0FFh
	MOV	DPTR, #8000h
LOOP_3:	MOVX	A, @DPTR
	CJNE	A, #80h, RETURN_2
	MOV	A, R0
	MOVX	@DPTR, A
	DEC	R0
	ACALL	DELAY
	SJMP	LOOP_3
RETURN_2:

	MOV	P0, #0FFh
	RET
; ----------------------------------------------------------------------

DELAY:
	MOV	R3, #003h
	MOV	R2, #0D2h
	MOV	R1, #00Ch
	MOV	R0, #082h
	NOP
	DJNZ	R0, $
	DJNZ	R1, $-5
	DJNZ	R2, $-9
	DJNZ	R3, $-13
	MOV	R1, #006h
	MOV	R0, #0BAh
	NOP
	DJNZ	R0, $
	DJNZ	R1, $-5
	NOP
	NOP
	NOP
	RET
	
; ----------------------------------------------------------------------

TAB:	DB	0FFh, 0FEh, 0FDh, 0FBh, 0F7h, 0EFh, 0DFh, 0BFh, 7Fh, 00h, 01h, 02h, 04h, 08h, 10h, 20h, 40h, 80h

; ----------------------------------------------------------------------
	END