; ----------------------------------------------------------------------
; @author: Felipe Andrade Garcia Tommaselli (11800910)

; Simul 4
; Exercicio 1

; ----------------------------------------------------------------------

		ORG	0

; ----------------------------------------------------------------------

		MOV	TMOD, #00100000b ; timer 1 no modo 2
 		MOV	SCON, #01010000b ; modo 1 com o REN ativo
		MOV	TL1, #253
		MOV	TH1, #253
		MOV	PCON, #80h ; k = 2
		SETB	TR1 ; inicia o T1
LOOP1:		MOV	P2, #0FFh ; apagar os leds
LOOP:		ACALL	SERIAL
		CJNE	A, #47h, CONT ; testa se o caracter recebido é 'G'
		CLR	P2.0
		SJMP	LOOP
CONT:		CJNE	A, #59h, CONT1 ; testa se o caracter recebido é 'Y'
		CLR	P2.4
		SJMP	LOOP
CONT1:		CJNE	A, #52h, CONT2 ; testa se o caracter recebido é 'R'
		CLR	P2.7
		SJMP	LOOP
CONT2:		CJNE	A, #44h, LOOP ; testa se o caracter recebido é 'D'
		SJMP	LOOP1

; ----------------------------------------------------------------------

SERIAL:		JNB	RI, $ ; espera RI habilitar a recepção
		MOV	A, SBUF ; le o caracter
		CLR	RI ; prepara para outro caracter ser recebido
		RET

		END
