; ----------------------------------------------------------------------
; @author: Felipe Andrade Garcia Tommaselli (11800910)

; Lista 2
; Exercicio 1

; ----------------------------------------------------------------------
R0_PARA_DELAY	EQU		018H

SC		EQU		P3.6
VOLTAGEM	EQU		P1
DISPLAY		EQU		P2
DISPLAY_LouR	EQU		P3.7

DIGIT_DEZ	EQU		31H
DIGIT_UN	EQU		30H

		ORG		0000H
		SJMP		PROGRAMA

		ORG		0003H
		SJMP		INTERRUPCAO_X0

; ----------------------------------------------------------------------

PROGRAMA:	CLR		SC			
		MOV		VOLTAGEM,#0FFH		
		MOV		DISPLAY,#00H		
		CLR		DISPLAY_LouR		
		MOV		DIGIT_DEZ,#00H		
		MOV		DIGIT_UN,#00H		

		SETB		EX0			
		SETB		IT0			
		CLR		EA			

		ACALL		PULSO_SC		

LOOP:		ACALL		MOSTRA_DISPLAY		

		SJMP		LOOP			

; ----------------------------------------------------------------------

INTERRUPCAO_X0:	CLR		EA			

		MOV		R7,#00H			

		MOV		A,VOLTAGEM		
		MOV		B,#10H			
		DIV		AB			
		ACALL		CONVERT_BCD
CONVERT_BCD:	MOV		B,#0AH			
		DIV		AB			
		MOV		DIGIT_DEZ,A		
		MOV		DIGIT_UN,B		
		RET				

; ----------------------------------------------------------------------

MOSTRA_DISPLAY:	SETB		DISPLAY_LouR		
		MOV		DPTR,#DISPLAY_DIGITS	

		MOV		DISPLAY,#00H		
		CLR		DISPLAY_LouR		
		MOV		A,DIGIT_UN		
		MOVC		A,@A+DPTR		
		MOV		DISPLAY,A
		MOV		DISPLAY,#00H		
		SETB		DISPLAY_LouR		
		MOV		A,DIGIT_DEZ		
		MOVC		A,@A+DPTR		
		MOV		DISPLAY,A
		RET				

; ----------------------------------------------------------------------

PULSO_SC:	CLR		SC			
		SETB		SC			
		ACALL		DELAY			
		CLR		SC			
		SETB		EA			
		RET				

; ----------------------------------------------------------------------

DELAY:		MOV		R0, #R0_PARA_DELAY	
		DJNZ		R0, $			
		RET				

; ----------------------------------------------------------------------

DISPLAY_DIGITS:	DB		07EH,030H,06DH,079H,033H,05BH,05FH,070H,07FH,07BH

; ----------------------------------------------------------------------

		END