; ----------------------------------------------------------------------
; @author: Felipe Andrade Garcia Tommaselli (11800910)

; Lista 1
; Exercicio 1

; ----------------------------------------------------------------------

		ORG	0; SETANDO INÍCIO DO PROGRAMA
		SJMP	PROG

		ORG	1Bh ; INTERRUPÇÃO 
		INC	A
		; controle de fluxo
		; confere se ja foram as 100 rodadas
		CJNE	A, #100d,LOOP
FIM:		CLR 	EA ; fim do programa
		RETI

LOOP:		MOV	TH1, #03Ch ; conta 0.05 s
		MOV	TL1, #0B0H
		SETB	TR1
		RETI


PROG:		MOV	A, #00h ; zera o acc

		SETB	EA
		SETB	ET1
		; timer em modo 1 contando até 0,05 s
		MOV	TMOD, #00010000b
		MOV	TH1, #03Ch ; conta 0.05 s
		MOV	TL1, #0B0H
		SETB	TR1
		SJMP	$ ; aguarda o timer estourar

		END