
_init:

;CAN_Debugger.c,11 :: 		void init()
;CAN_Debugger.c,13 :: 		setAllPinAsDigital();
	PUSH	W10
	PUSH	W11
	PUSH	W12
	CALL	_setAllPinAsDigital
;CAN_Debugger.c,14 :: 		ethernetInit();
	CALL	_ethernetInit
;CAN_Debugger.c,15 :: 		setTimer(1, 0.5);
	MOV	#0, W11
	MOV	#16128, W12
	MOV.B	#1, W10
	CALL	_setTimer
;CAN_Debugger.c,17 :: 		delay_ms(200);
	MOV	#21, W8
	MOV	#22619, W7
L_init0:
	DEC	W7
	BRA NZ	L_init0
	DEC	W8
	BRA NZ	L_init0
;CAN_Debugger.c,18 :: 		}
L_end_init:
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of _init

_setPort:

;CAN_Debugger.c,20 :: 		void setPort()
;CAN_Debugger.c,22 :: 		TRISEbits.TRISE0 = 0;
	BCLR	TRISEbits, #0
;CAN_Debugger.c,23 :: 		}
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

;CAN_Debugger.c,25 :: 		void main()
;CAN_Debugger.c,27 :: 		init();
	PUSH	W10
	CALL	_init
;CAN_Debugger.c,28 :: 		setPort();
	CALL	_setPort
;CAN_Debugger.c,29 :: 		turnOnTimer(1);
	MOV.B	#1, W10
	CALL	_turnOnTimer
;CAN_Debugger.c,31 :: 		while(1)
L_main2:
;CAN_Debugger.c,33 :: 		SPI_Ethernet_doPacket();
	CALL	_SPI_Ethernet_doPacket
;CAN_Debugger.c,34 :: 		}
	GOTO	L_main2
;CAN_Debugger.c,36 :: 		}
L_end_main:
	POP	W10
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main

_timer1_interrupt:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;CAN_Debugger.c,38 :: 		onTimer1Interrupt
;CAN_Debugger.c,40 :: 		timer1Counter++;
	PUSH	W10
	MOV	#1, W1
	MOV	#lo_addr(_timer1Counter), W0
	ADD	W1, [W0], [W0]
;CAN_Debugger.c,45 :: 		clearTimer(1);
	MOV.B	#1, W10
	CALL	_clearTimer
;CAN_Debugger.c,46 :: 		}
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
