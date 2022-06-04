; ----------------------------------------------------------------------
; @author: Felipe Andrade Garcia Tommaselli (11800910)

; Aula 3 de Simulação
; Exercicio 1

; Correções no tempo:
; Frquência de 10 kHz: Delay de 50 us no total!
; como os processos extras estvam tomando 9 us, coloquei 41 us na special
; calculador e a contagem fechou em 51, para "MOV TL0, #0D7h"

; Frquência de 20 kHz: Delay de 25 us no total!
; como os processos extras estvam tomando 10 us, coloquei 15 us na special
; calculador e a contagem fechou em 25 certinho, para "MOV TL0, #0F1h"
; ----------------------------------------------------------------------

		ORG 	0
		SJMP	PROG
; ----------------------------------------------------------------------
		ORG 	0003h ; interrupção do INT0
		CPL	20h.0 ; complementa o bit de flag 20h.0
			      ; troca de 10 kHz para 20 kHz ou vice versa
		RETI
; ----------------------------------------------------------------------
		ORG	0Bh ; interrupção do timer 0
		CPL	P2.0 ; complementa P2.0 (acende ou apaga o led)

		; controle de fluxo
		JNB	20h.0, F20k ; testa o valor do bit de flag 20h.0
		MOV	TH0, #0FFh ; frequencia de 10 kHz
		MOV	TL0, #0D7h ; conta 41 microsegundospara no total dar 50
		RETI

F20K:		MOV	TH0, #0FFh ; frequencia de 20 kHz
		MOV	TL0, #0F1h ; conta 15 microsegundos para no total dar 25
		RETI
; ----------------------------------------------------------------------

PROG: 		; programa principal
		SETB	EA ; habilita interrupções
		SETB	EX0 ; seta interrupçao externa 0
		SETB	ET0 ; seta timer 0
		SETB	IT0 ; ex0 ativada com descida de borda

		; Timer 1: tudo zero
		; Timer 0:
			; Gate = 0, controle por software
			; T\ = 0, timer
			; M1 = 0 e M0 = 1, modo 1 de temporizaçao
		MOV	TMOD, #01 ; 0000 0001
		SETB	P2.0 ; apaga o led
		SETB	20h.0 ; bit de flag (10 kHz ou 20 kHz)

LOOP:		; loop
		MOV	TH0, #0FFh ; frequencia de 10 kHz
		MOV	TL0, #0D7h ; conta 50 microsegundos
		SETB	TR0 ; inicia a contagem
		JB	20h.0, $ ; espera a interrupçao quando o timer estourar
				 ;(cada 50 microsegundos)
		MOV	TH0, #0FFh ; frequencia de 20 kHz
		MOV	TL0, #0F1h
		JNB	20h.0,$ ; espera a interrupçao quando o timer estourar
		SJMP	LOOP ; reinicia o loop

		END



