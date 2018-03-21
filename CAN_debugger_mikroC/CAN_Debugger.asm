
_init:

;CAN_Debugger.c,9 :: 		void init()
;CAN_Debugger.c,11 :: 		setAllPinAsDigital();
	PUSH	W10
	PUSH	W11
	PUSH	W12
	CALL	_setAllPinAsDigital
;CAN_Debugger.c,13 :: 		UART1_Init(BAUDRATE);
	MOV	#9600, W10
	MOV	#0, W11
	CALL	_UART1_Init
;CAN_Debugger.c,14 :: 		setTimer(1, 0.5);
	MOV	#0, W11
	MOV	#16128, W12
	MOV.B	#1, W10
	CALL	_setTimer
;CAN_Debugger.c,16 :: 		delay_ms(200);
	MOV	#21, W8
	MOV	#22619, W7
L_init0:
	DEC	W7
	BRA NZ	L_init0
	DEC	W8
	BRA NZ	L_init0
;CAN_Debugger.c,17 :: 		}
L_end_init:
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of _init

_setPort:

;CAN_Debugger.c,19 :: 		void setPort()
;CAN_Debugger.c,21 :: 		TRISEbits.TRISE0 = 0;
	BCLR	TRISEbits, #0
;CAN_Debugger.c,22 :: 		}
L_end_setPort:
	RETURN
; end of _setPort

_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;CAN_Debugger.c,24 :: 		void main()
;CAN_Debugger.c,26 :: 		init();
	PUSH	W10
	CALL	_init
;CAN_Debugger.c,27 :: 		setPort();
	CALL	_setPort
;CAN_Debugger.c,28 :: 		turnOnTimer(1);
	MOV.B	#1, W10
	CALL	_turnOnTimer
;CAN_Debugger.c,29 :: 		UART1_Write_Text("Acceso");
	MOV	#lo_addr(?lstr1_CAN_Debugger), W10
	CALL	_UART1_Write_Text
;CAN_Debugger.c,31 :: 		while(1)
L_main2:
;CAN_Debugger.c,37 :: 		}
	GOTO	L_main2
;CAN_Debugger.c,38 :: 		}
L_end_main:
	POP	W10
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main

_onUART1Ready:
	LNK	#2
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;CAN_Debugger.c,40 :: 		void onUART1Ready() iv IVT_ADDR_U1RXINTERRUPT ics ICS_AUTO
;CAN_Debugger.c,42 :: 		if(timer1Counter % 2 != 1){
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV	_timer1Counter, W0
	MOV	#2, W2
	REPEAT	#17
	DIV.S	W0, W2
	MOV	W1, W0
	CP	W0, #1
	BRA NZ	L__onUART1Ready13
	GOTO	L_onUART1Ready4
L__onUART1Ready13:
;CAN_Debugger.c,45 :: 		UART1_Read_Text(output, '\0', 255);
	MOV.B	#255, W12
	CLR	W11
	MOV	[W14+0], W10
	CALL	_UART1_Read_Text
;CAN_Debugger.c,47 :: 		PORTEbits.RE0 = strcmp(output, "Acceso") == 1 ? 0 : 0;
	MOV	#lo_addr(?lstr2_CAN_Debugger), W11
	MOV	[W14+0], W10
	CALL	_strcmp
	CP	W0, #1
	BRA Z	L__onUART1Ready14
	GOTO	L_onUART1Ready5
L__onUART1Ready14:
; ?FLOC___onUART1Ready?T9 start address is: 0 (W0)
	CLR	W0
; ?FLOC___onUART1Ready?T9 end address is: 0 (W0)
	GOTO	L_onUART1Ready6
L_onUART1Ready5:
; ?FLOC___onUART1Ready?T9 start address is: 0 (W0)
	CLR	W0
; ?FLOC___onUART1Ready?T9 end address is: 0 (W0)
L_onUART1Ready6:
; ?FLOC___onUART1Ready?T9 start address is: 0 (W0)
	BTSS	W0, #0
	BCLR	PORTEbits, #0
	BTSC	W0, #0
	BSET	PORTEbits, #0
; ?FLOC___onUART1Ready?T9 end address is: 0 (W0)
;CAN_Debugger.c,49 :: 		IFS0bits.U1RXIF = 0;
	BCLR	IFS0bits, #9
;CAN_Debugger.c,51 :: 		}
L_onUART1Ready4:
;CAN_Debugger.c,53 :: 		}
L_end_onUART1Ready:
	POP	W12
	POP	W11
	POP	W10
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	ULNK
	RETFIE
; end of _onUART1Ready

_timer1_interrupt:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;CAN_Debugger.c,55 :: 		onTimer1Interrupt
;CAN_Debugger.c,57 :: 		timer1Counter++;
	PUSH	W10
	MOV	#1, W1
	MOV	#lo_addr(_timer1Counter), W0
	ADD	W1, [W0], [W0]
;CAN_Debugger.c,58 :: 		if(timer1Counter % 2 == 0){
	MOV	_timer1Counter, W0
	MOV	#2, W2
	REPEAT	#17
	DIV.S	W0, W2
	MOV	W1, W0
	CP	W0, #0
	BRA Z	L__timer1_interrupt16
	GOTO	L_timer1_interrupt7
L__timer1_interrupt16:
;CAN_Debugger.c,59 :: 		UART1_Write_Text("Acceso");
	MOV	#lo_addr(?lstr3_CAN_Debugger), W10
	CALL	_UART1_Write_Text
;CAN_Debugger.c,60 :: 		PORTEbits.RE0 = 1;
	BSET	PORTEbits, #0
;CAN_Debugger.c,61 :: 		}
L_timer1_interrupt7:
;CAN_Debugger.c,62 :: 		}
L_end_timer1_interrupt:
	POP	W10
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _timer1_interrupt
