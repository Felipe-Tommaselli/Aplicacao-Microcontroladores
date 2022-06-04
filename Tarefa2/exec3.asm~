; ----------------------------------------------------------------------
; @author: Felipe Andrade Garcia Tommaselli (11800910)

; Lista 2- Aula 4
; Exercicio 1

; Programa: controlar uma esteira transportadora:
; a) Acionar o motor DC no sentido Horário.
; b) Quando o produto passar pelo sensor, um sinal de Interrupção é enviado e a
; esteira é parada por 5 segundos para permitir a retirada do produto
; transportado.
; c) Inverter o sentido do motor DC (Anti-horário).
; d) Através de um mecanismo na esteira, uma nova interrupção é enviada pelo
; mesmo pino Int0 quando a esteira estiver re-posicionada para aceitar outro
; produto.
; e) Parar a esteira por 10 segundos e re-iniciar o processo.

; ----------------------------------------------------------------------


; P2.1: pino do motor
; P2.7: pino do motor
; P3.2: pino do sensor (INT0)

		ORG 0
		SJMP	INST_A

		ORG 0003h
		SJMP 	INTERRUPCAO

; ----------------------------------------------------------------------
; roda o motor no sentido horario até o sensor ser ativado
INST_A: 	MOV	P2,#00H; ; limpa os pinos
		; motor em sentido horário
		SETB 	P2.1 ; 1
		CLR 	P2.7 ; 0
		; setar os pinos de interupçao
		SETB	EA ; habilita todos os pinos
		SETB	EX0 ; seta o P3.2
		SETB 	IT0 ; sensível a borda de descida

		SJMP 	$ ; ESPERA INTERRUPÇÃO

; ----------------------------------------------------------------------

INTERRUPCAO:	CLR	EA ; desabilita interrupções

		; CONTROLE DE FLUXO!
		; verifica se o motor quando entrou na interrupçao estava em 
		; horário (P2.7 = 0) ou anti-horário (P2.7 = 1) 
		JB	P2.7, POSICIONADA; ;

		; para a esteira
		SETB 	P2.1 ; 1
		SETB 	P2.7 ; 1

		CALL	DELAY5; ; chama o delay de 5s

		; inverte o sentido para anti-horário
		CLR 	P2.1 ; 0
		SETB 	P2.7 ; 1

		SETB	EA; ; reabilita interrupções
		RETI

POSICIONADA:	; para a esteira
		SETB 	P2.1 ; 1
		SETB 	P2.7 ; 1

	
		CALL	DELAY5
		CALL 	DELAY5

		; motor em sentido horário
		SETB 	P2.1 ; 1
		CLR 	P2.7 ; 0

		SETB	EA; ; reabilita interrupções
		RETI


; ----------------------------------------------------------------------

;
DELAY5: 	MOV	R2,#255D	;DELAY DE 5 SEGUNDOS CONSIDERANDO CLOCK DE 12 MHz
LOOP1:		MOV	R1,#3D
LOOP:		MOV	R0,#3D
		DJNZ	R0,$
		DJNZ	R1,$ - 6
		DJNZ	R2,$ - 7
		RET


		END


