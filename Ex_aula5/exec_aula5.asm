; ----------------------------------------------------------------------
; @author: Felipe Andrade Garcia Tommaselli (11800910)

; Tarefa Aula 5

; ----------------------------------------------------------------------
	ORG    0
	SJMP	Prog
; ----------------------------------------------------------------------
	ORG	000BH
	SJMP    Sub0
; ----------------------------------------------------------------------
	ORG    001BH
	SJMP	Sub1
; ----------------------------------------------------------------------
Prog:
	CLR	P1.0
	CLR	P1.1
	SETB    ET1
 	SETB    ET0
	MOV	TMOD,#11h
	MOV	TH1,#0FFh
	MOV	TL1,#0FEh
	MOV   	TH0,#0FFh
	MOV   	TL0,#0FDh
	SETB    EA
	SETB    TR1
	SETB    TR0
	SJMP    $
; ----------------------------------------------------------------------
Sub0:
	CLR	EA
	CPL	P1.0
	CLR 	TR1
	CLR	TR0
	MOV	TH0,#0FFH
	MOV	TL0,#0FDH
	SETB	EA
	SETB	TR1
	SETB	TR0
	RETI
; ----------------------------------------------------------------------
Sub1:
	CLR	EA
	CPL	P1.1
	CLR	TR1
	CLR	TR0
	MOV	TH1,#0FFH
	MOV	TL1,#0FEH
	SETB	EA
	SETB	TR1
	SETB	TR0
	RETI

	END
