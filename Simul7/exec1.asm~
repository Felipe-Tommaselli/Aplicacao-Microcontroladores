; ----------------------------------------------------------------------
; @author: Felipe Andrade Garcia Tommaselli (11800910)

; Simul 7
; Exercicio 1

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
		CLR	F0 ; limpa flag
		MOV	A, #00 	 ; inicio do contador
		MOV	R3, #00  ; valor inicial do msb
LOOP:		MOV	R0, A 	 ; contador salvo em R0
		ACALL	CONV2
		ACALL	DISPLAY7
		MOV	A, R0	 ; recupera valor do contador
		INC	A	 ; incrementa contador
		ACALL	VERIFICA
		CJNE	A, #0C8h, LOOP ; verifica se maior que 199 em bcd
		JMP	PROG 	 ; se maior que 199 volta a zero

; ----------------------------------------------------------------------
VERIFICA:	JB	F0, VERIFICA
		NOP
		RET
; ----------------------------------------------------------------------

CONV2:		CJNE	A, #64h, TESTE  ; verifica se o valor da contagem até 99 (63h)
TESTE:		JC	MENOR 		; se menor que 64h o bcd é de dois digitos e r3 = msb = 0
		SUBB	A, #64h		; se maior ou igual a 64h
		MOV	R3, #1		; r3 = msb = 1
		ACALL	CONVBCD
		RET
MENOR:		ACALL	CONVBCD
		RET

; ----------------------------------------------------------------------

CONVBCD:	MOV	B, #0Ah
		DIV	AB
		MOV	R2, A ; R2 = ISB
		MOV	R1, B ; R1 = LSB
		SWAP 	A
		ORL	A, R1 ; A = BCD 8421
		RET

; ----------------------------------------------------------------------

DISPLAY7:	MOV	DPTR, #DIGITO	; aponta para a tabela de 7 segmentos do LSB
		MOV	A, R1
		MOVC	A, @A+DPTR	; le o código de 7 segmentos do lsb
		MOV	P0, A		; mostra o lsb no primeiro display
		MOV	A, R2
		MOVC	A, @A+DPTR 	; le o código de 8 segmentos do ISB
		MOV	P2, A 		; mostra o isb no display intermediario
		MOV	A, R3
		MOVC	A, @A+DPTR 	; le o código de 7 segmentos do MSB
		MOV	P1,A		; mostra o msb no display da esquerda
		ACALL	DELAY
		RET
; ----------------------------------------------------------------------
DIGITO:		DB	3Fh, 06, 5Bh, 4Fh, 66h, 6Dh, 7Dh, 07, 7Fh, 6Fh
; ----------------------------------------------------------------------

DELAY:		MOV	R4, #0F9h
		NOP
		DJNZ	R4, $
		RET

		END