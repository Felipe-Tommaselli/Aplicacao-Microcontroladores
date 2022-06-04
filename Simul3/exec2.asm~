; ----------------------------------------------------------------------
; @author: Felipe Andrade Garcia Tommaselli (11800910)

; Aula 3 de Simulação
; Exercicio 2

; ----------------------------------------------------------------------
		ORG 	0
		SJMP	PROG
; ----------------------------------------------------------------------
		ORG 	0003h ; interrupção do INT0
		SJMP	EXT_0 ; chama a subrotina de interrupção EXT_0
; ----------------------------------------------------------------------
		ORG	1Bh ; interrupção do timer 1
		SJMP	CONT1 ; chama a subrotina de interrupção do timer 1
; ----------------------------------------------------------------------

PROG: 		; programa principal
		SETB	EA ; habilita interrupções
		SETB	EX0 ; seta interrupçao externa 0
		SETB	ET1 ; seta timer 1
		SETB	IT0 ; ex0 ativada com descida de borda

		MOV	P2, #0FFh ; apaga todos os leds

		; Timer 0: tudo zero
		; Timer 1:
			; Gate = 0, controle por software
			; C = 1, contador
			; M1 = 0 e M0 = 1, modo 1 de contagem
		MOV	TMOD, #50h
		SETB	TR1 ; habilita a contagem 
		MOV	A, #0 ; flag variando entre 0, 1 e 2

LOOP:		; loop
		MOV	TH1, #0FFh
		MOV	TL1, #0FBh ; carrega a contagem de 5 pulsos
		SJMP	$ ; espera 5 pulsos na porta P3.5
			  ; ou uma interrupção por borda na P3.2
; ----------------------------------------------------------------------

CONT1:		; Contagem 1
		; compara o valor do acumulador com 0, senão vai pra T10
		CJNE	A, #00, T10
		CLR	P2.0 ; acende o led P2.0
		MOV	TH1, #0FFh
		MOV	TL1, #0FBh ; conta mais 5 para chegar em 10
		INC	A ; incrementa o acumulador, como se mudasse a flag
		RETI
; ----------------------------------------------------------------------

T10:		; T10
		; compara se o acumulador é 1, ou seja, foram dados 10 pulsos
		; senão passa para T20
		CJNE	A, #01, T20
		CLR	P2.1 ; acende o led P2.1
		MOV	TH1, #0FFh
		MOV	TL1, #0F6h ; conta mais 1 0 pulsos
		INC	A ; incrementa o acumulador
		RETI
; ----------------------------------------------------------------------

T20:		; T20
		CLR 	P2.2 ; acende o led P2.2
		CLR	TR1 ; para a contagem de pulsos
		RETI
; ----------------------------------------------------------------------

EXT_0:		; sub rotina de interrupção externa 0 que reinicia a contagem
		MOV	P2, #0FFh ; apaga todos os leds
		MOV	TH1, #0FFH
		MOV	TL1, #0FBh ; puxa uma nova contagem de 5
		MOV	A, #00 ; reseta o valor do acumulador
		SETB	TR1 ; habilita a contagem de pulsos
		RETI

		END

