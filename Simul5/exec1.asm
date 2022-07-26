; ----------------------------------------------------------------------
; @author: Felipe Andrade Garcia Tommaselli (11800910)

; Simul 5
; Exercicio 1

; ----------------------------------------------------------------------
		ORG	0
		SJMP	PROG

; ----------------------------------------------------------------------
		ORG	03h ; externa 0
		CLR 	EA
		; R5 = pino de "flag"
		MOV	R5, #01h ; se diferente de 0, a contagem continua
		RETI

; ----------------------------------------------------------------------
		ORG	13h ; externa 1
		CLR	EA
		MOV	R5, #00 ; se igual a 0, para a contagem
		CLR	EX1 ; só pode parar a contagem depois que ela estiver rodando
		SETB	EX0 ; permite reiniciar a contagem
		SETB	EA ; habilita interruções
		RETI
; ----------------------------------------------------------------------


PROG:		SETB	EX0 ; habilita EX0
		SETB	IT0 ; borda de descida
		SETB	EX1 ; habilita EX1
		SETB	IT1 ; borda de descida
		SETB	EA ;habilita interrupções

INI:		MOV	A, #00 ; zera o acumulador que carrega contagem

; controle de fluxo: espera se a interrupção ext0 ativou a flag
ESPERA:		CJNE	R5, #00, LOOP ; se tiver ativado, vai para o loop
		SJMP	ESPERA ; senão, repete a verificação

LOOP:		SETB	EX1 ; habilita parar a contagem
		CLR	EX0 ; só pode recomeçar depois que para
		SETB	EA

		MOV 	R0, A ; loop da contagem
        	ACALL	CONVBCD ; converte BCD
		ACALL 	MOSTRA_LED ; valor convertido acende os leds
		ACALL 	DELAY ; delay par visualizar
		MOV	A,R0 ; reutiliza o acumulador com o antigo valor da contagem
		INC	A ; prox valor
		CJNE	A,#064h,ESPERA ; verifica se já chegou no 99
		JMP 	INI ; reinicia tudo quando acaba a contagem

; ----------------------------------------------------------------------

; algoritmo de conversão BCD visto em aula
CONVBCD:	MOV	B, #0Ah
		DIV	AB
		MOV	R2, A
		MOV	R1, B
		SWAP	A
		ORL	A, R1
		RET

; ----------------------------------------------------------------------

; mostra valor convertido no led
MOSTRA_LED:	MOV	A, R2
		SWAP	A
		ORL	A, R1
		CPL	A ; led liga em 0 e apaga em 1
		MOV	P2, A
		RET

; ----------------------------------------------------------------------

; delay de 200 us
DELAY:		MOV	R4, #0C6h
		NOP
		DJNZ	R4, $
		RET


		END

