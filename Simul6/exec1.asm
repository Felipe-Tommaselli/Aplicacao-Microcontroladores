; ----------------------------------------------------------------------
; @author: Felipe Andrade Garcia Tommaselli (11800910)

; Simul 6
; Exercicio 1

; ----------------------------------------------------------------------

		ORG	0
		SJMP	PROG

		ORG	1Bh
		SETB	F0 ; flag para reiniciar o programa
		RETI
; ----------------------------------------------------------------------

PROG:		MOV	A,  #00h
		MOV	R2, #00h     ; flag de contagem da senha
		MOV	P2, #0FFh
		CLR	F0
INIC:		MOV	P1, #0FFh
		MOV	R0, #7Fh
LOOP:		ACALL	VARRE
		MOV	A, P1
		ORL	A, #0F0h
		CJNE	A, #0FFh, TECLA
		SJMP	LOOP
TECLA:		MOV	R1, P1
		MOV	A, P1
		ACALL	SENHA	; checa a senha
		CPL	A       ; led ativa em 0
		MOV	P2, A
		SJMP	INIC

VARRE:		MOV	A, R0
		MOV	P1, A
		RR	A
		JNB	ACC.3, PULA_FIM
		MOV	R0, A
		RET

SENHA:			; switch com as oções
			CJNE	R2, #04h, CHECK_3; sequência 7AB3 digitada, conferir #
			SJMP	TECLA_GRADE
CHECK_3:		CJNE	R2, #03h, CHECK_B ; sequência 7AB digitada, conferir 3
			SJMP	TECLA_3
CHECK_B:		CJNE	R2, #02h, CHECK_A ; sequência 7A digitada, conferir B
			SJMP	TECLA_B
CHECK_A:		CJNE	R2, #01h, TECLA_7 ; sequência 7 digitada, conferir A
			SJMP	TECLA_A


TECLA_7:		CJNE	A, #11101011b, TECLA_ERRADA ; confere se a tecla é 7
			INC	R2
			RET
TECLA_A:		CJNE	A, #01111110b, TECLA_ERRADA ; confere se a tecla é A
			INC	R2
			RET
TECLA_B:		CJNE	A, #01111101b, TECLA_ERRADA ; confere se a tecla é B
			INC	R2
			RET
TECLA_3:		CJNE	A, #10111110b, TECLA_ERRADA ; confere se a tecla é 3
			INC	R2
			RET
TECLA_GRADE:		CJNE	A, #10110111b, SENHA_ERRADA ; confere se a tecla é #
			INC	R2
			ACALL	SENHA_CERTA_LED
			RET

TECLA_ERRADA:		RET
SENHA_ERRADA:		MOV	R2, #00h ; resetar a contagem
			SJMP	SENHA_ERRADA_LED
			RET


; ----------------------------------------------------------------------
PULA_PROG:		SJMP	PROG     ; jumper para instruções de salto de 8bits
PULA_FIM:		SJMP	FIM
; ----------------------------------------------------------------------

SENHA_CERTA_LED:	MOV	P2, #11111110B ; pisca 0
			ACALL 	DELAY
			MOV	P2, #11111101B ; pisca 1
			ACALL 	DELAY
			MOV	P2, #11111011B ; pisca 2
			ACALL 	DELAY
			MOV	P2, #11110111B ; pisca 3
			ACALL 	DELAY
			MOV	P2, #11101111B ; pisca 4
			ACALL 	DELAY
			MOV	P2, #11011111B ; pisca 5
			ACALL 	DELAY
			MOV	P2, #10111111B ; pisca 6
			ACALL 	DELAY
			MOV	P2, #01111111B ; pisca 7
			ACALL 	DELAY
			RET


SENHA_ERRADA_LED:	MOV	P2, #00h
			ACALL	DELAY
			JB	F0, PULA_PROG ; espera a interrupção permitir reiniciar o programa
			SJMP	SENHA_ERRADA_LED
; ----------------------------------------------------------------------
DELAY:			; START: Wait loop, time: 50 us
			; Clock: 12000.0 kHz (12 / MC)
			; Used registers: R7
				MOV	R7, #018h
				NOP
				DJNZ	R7, $
			; Rest: 0
			; END: Wait loop
; ----------------------------------------------------------------------
FIM:		MOV	R0, #7Fh
		RET

		END 
