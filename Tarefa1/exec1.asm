; ****************************************************
; @author: Felipe Andrade Garcia Tommaselli (11800910)

; Lista 1- Aula 3
; Exercicio 1

; Programa: Simples soma de duas informações em duas
; posições conhecidas (30h e 31h) com valor  guardado
; na posição 32h, tal qual o código descrito abaixo.
; ****************************************************

		ORG 	0
		MOV	A, 30h ; passa do 30h para o acumulador
		ADD	A, 31h ; soma do 31h com o acumulador
		MOV	32h, A ; guarda a soma em 32h
		SJMP	$      ; fim lógico do programa
		END