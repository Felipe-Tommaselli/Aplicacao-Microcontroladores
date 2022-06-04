; ****************************************************
; @author: Felipe Andrade Garcia Tommaselli (11800910)

; Lista 1- Aula 3
; Exercicio 2

; Programa: O código tem como objetivo pegar o valor
; de uma RAM externa na posição 1200h através do DPTR
; e passar para a posição 30h da RAM interna
; ****************************************************

		ORG 	0
		MOV	DPTR, #1200h  ; aponta DPTR para 1200h
		MOVX	A, @DPTR      ; joga no acc o valor que DPTR aponta
		MOV	30h, A        ; guarda o valor na posição 30h
		SJMP	$             ; fim lógico do programa
		END