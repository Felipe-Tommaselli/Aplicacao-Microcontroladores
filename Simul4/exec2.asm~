; ----------------------------------------------------------------------
; @author: Felipe Andrade Garcia Tommaselli (11800910)

; Simul 4
; Exercicio 2

; ----------------------------------------------------------------------
	
		ORG	0
		SJMP	PROG

; ----------------------------------------------------------------------
	
		ORG	0023H
		SJMP	SERIAL
	
; ----------------------------------------------------------------------
PROG:		SETB	EA
		SETB	IE.4
		MOV	TMOD,#20H
		MOV	SCON,#50H
		MOV	TL1,#253D
		MOV	TH1,#253D
		MOV	PCON,#80H
		SETB	TR1
LOOP1:		MOV	P2,#0FFH
LOOP:		CJNE	A,#47H,CONT
		CLR	P2.0
		SJMP	LOOP
CONT:		CJNE	A,#59H,CONT1
		CLR	P2.4
		SJMP	LOOP
CONT1:		CJNE	A,#52H,CONT2
		CLR	P2.7
		SJMP	LOOP
CONT2:		CJNE	A,#44H,LOOP
		SJMP	LOOP1
; ----------------------------------------------------------------------
SERIAL:
		CLR	EA
		MOV	A,SBUF
		CLR	RI
		SETB	EA
		RETI
; ----------------------------------------------------------------------
		END
