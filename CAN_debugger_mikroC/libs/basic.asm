
_unsignedIntToString:

;basic.c,8 :: 		void unsignedIntToString(unsigned int number, char *text) {
;basic.c,9 :: 		emptyString(text);
	PUSH	W10
	MOV	W11, W10
	CALL	_emptyString
	POP	W10
;basic.c,10 :: 		sprintf(text, "%u", number);
	MOV	#lo_addr(?lstr_1_basic), W0
	PUSH	W10
	PUSH	W0
	PUSH	W11
	CALL	_sprintf
	SUB	#6, W15
;basic.c,11 :: 		}
L_end_unsignedIntToString:
	RETURN
; end of _unsignedIntToString

_signedIntToString:

;basic.c,13 :: 		void signedIntToString(int number, char *text) {
;basic.c,14 :: 		emptyString(text);
	PUSH	W10
	MOV	W11, W10
	CALL	_emptyString
	POP	W10
;basic.c,15 :: 		sprintf(text, "%d", number);
	MOV	#lo_addr(?lstr_2_basic), W0
	PUSH	W10
	PUSH	W0
	PUSH	W11
	CALL	_sprintf
	SUB	#6, W15
;basic.c,16 :: 		}
L_end_signedIntToString:
	RETURN
; end of _signedIntToString

_emptyString:

;basic.c,18 :: 		void emptyString(char *myString) {
;basic.c,19 :: 		myString[0] = '\0';
	CLR	W0
	MOV.B	W0, [W10]
;basic.c,23 :: 		}
L_end_emptyString:
	RETURN
; end of _emptyString

_getNumberDigitCount:

;basic.c,25 :: 		unsigned char getNumberDigitCount(unsigned char number) {
;basic.c,26 :: 		if (number >= 100) {
	MOV.B	#100, W0
	CP.B	W10, W0
	BRA GEU	L__getNumberDigitCount31
	GOTO	L_getNumberDigitCount0
L__getNumberDigitCount31:
;basic.c,27 :: 		return 3;
	MOV.B	#3, W0
	GOTO	L_end_getNumberDigitCount
;basic.c,28 :: 		} else if (number >= 10) {
L_getNumberDigitCount0:
	CP.B	W10, #10
	BRA GEU	L__getNumberDigitCount32
	GOTO	L_getNumberDigitCount2
L__getNumberDigitCount32:
;basic.c,29 :: 		return 2;
	MOV.B	#2, W0
	GOTO	L_end_getNumberDigitCount
;basic.c,30 :: 		} else {
L_getNumberDigitCount2:
;basic.c,31 :: 		return 1;
	MOV.B	#1, W0
;basic.c,33 :: 		}
L_end_getNumberDigitCount:
	RETURN
; end of _getNumberDigitCount

_asciiHexToInt:
	LNK	#12

;basic.c,35 :: 		int asciiHexToInt(char* string, int lenght)
;basic.c,38 :: 		int result=0;
	PUSH	W12
	PUSH	W13
	MOV	#0, W0
	MOV	W0, [W14+2]
;basic.c,39 :: 		for(i=0;i<lenght;i++)
	CLR	W0
	MOV	W0, [W14+0]
L_asciiHexToInt4:
	ADD	W14, #0, W0
	CP	W11, [W0]
	BRA GT	L__asciiHexToInt34
	GOTO	L_asciiHexToInt5
L__asciiHexToInt34:
;basic.c,41 :: 		if(string[i]<='9' && string[i]>='0')
	ADD	W14, #0, W0
	ADD	W10, [W0], W0
	MOV.B	[W0], W1
	MOV.B	#57, W0
	CP.B	W1, W0
	BRA LEU	L__asciiHexToInt35
	GOTO	L__asciiHexToInt22
L__asciiHexToInt35:
	ADD	W14, #0, W0
	ADD	W10, [W0], W0
	MOV.B	[W0], W1
	MOV.B	#48, W0
	CP.B	W1, W0
	BRA GEU	L__asciiHexToInt36
	GOTO	L__asciiHexToInt21
L__asciiHexToInt36:
L__asciiHexToInt20:
;basic.c,43 :: 		result+=(string[i]-'0')*pow(16,lenght-i-1);
	ADD	W14, #0, W0
	ADD	W10, [W0], W0
	ZE	[W0], W1
	MOV	#48, W0
	SUB	W1, W0, W0
	MOV	W0, [W14+8]
	ADD	W14, #0, W0
	SUB	W11, [W0], W0
	DEC	W0
	PUSH.D	W10
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV.D	W0, W12
	MOV	#0, W10
	MOV	#16768, W11
	CALL	_pow
	MOV	[W14+8], W2
	MOV	W0, [W14+8]
	MOV	W1, [W14+10]
	MOV	W2, W0
	CLR	W1
	CALL	__Long2Float
	MOV	[W14+8], W2
	MOV	[W14+10], W3
	CALL	__Mul_FP
	MOV	W0, [W14+8]
	MOV	W1, [W14+10]
	MOV	[W14+2], W0
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV	[W14+8], W2
	MOV	[W14+10], W3
	CALL	__AddSub_FP
	CALL	__Float2Longint
	POP.D	W10
	MOV	W0, [W14+2]
;basic.c,44 :: 		}
	GOTO	L_asciiHexToInt10
;basic.c,41 :: 		if(string[i]<='9' && string[i]>='0')
L__asciiHexToInt22:
L__asciiHexToInt21:
;basic.c,45 :: 		else if(string[i]<='f' && string[i]>='a')
	ADD	W14, #0, W0
	ADD	W10, [W0], W0
	MOV.B	[W0], W1
	MOV.B	#102, W0
	CP.B	W1, W0
	BRA LEU	L__asciiHexToInt37
	GOTO	L__asciiHexToInt24
L__asciiHexToInt37:
	ADD	W14, #0, W0
	ADD	W10, [W0], W0
	MOV.B	[W0], W1
	MOV.B	#97, W0
	CP.B	W1, W0
	BRA GEU	L__asciiHexToInt38
	GOTO	L__asciiHexToInt23
L__asciiHexToInt38:
L__asciiHexToInt19:
;basic.c,47 :: 		result+=(string[i]-'a'+10)*pow(16,lenght-i-1);
	ADD	W14, #0, W0
	ADD	W10, [W0], W0
	ZE	[W0], W1
	MOV	#97, W0
	SUB	W1, W0, W0
	ADD	W0, #10, W0
	MOV	W0, [W14+8]
	ADD	W14, #0, W0
	SUB	W11, [W0], W0
	DEC	W0
	PUSH.D	W10
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV.D	W0, W12
	MOV	#0, W10
	MOV	#16768, W11
	CALL	_pow
	MOV	[W14+8], W2
	MOV	W0, [W14+8]
	MOV	W1, [W14+10]
	MOV	W2, W0
	CLR	W1
	CALL	__Long2Float
	MOV	[W14+8], W2
	MOV	[W14+10], W3
	CALL	__Mul_FP
	MOV	W0, [W14+8]
	MOV	W1, [W14+10]
	MOV	[W14+2], W0
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV	[W14+8], W2
	MOV	[W14+10], W3
	CALL	__AddSub_FP
	CALL	__Float2Longint
	POP.D	W10
	MOV	W0, [W14+2]
;basic.c,48 :: 		}
	GOTO	L_asciiHexToInt14
;basic.c,45 :: 		else if(string[i]<='f' && string[i]>='a')
L__asciiHexToInt24:
L__asciiHexToInt23:
;basic.c,49 :: 		else if(string[i]<='F' && string[i]>='A')
	ADD	W14, #0, W0
	ADD	W10, [W0], W0
	MOV.B	[W0], W1
	MOV.B	#70, W0
	CP.B	W1, W0
	BRA LEU	L__asciiHexToInt39
	GOTO	L__asciiHexToInt26
L__asciiHexToInt39:
	ADD	W14, #0, W0
	ADD	W10, [W0], W0
	MOV.B	[W0], W1
	MOV.B	#65, W0
	CP.B	W1, W0
	BRA GEU	L__asciiHexToInt40
	GOTO	L__asciiHexToInt25
L__asciiHexToInt40:
L__asciiHexToInt18:
;basic.c,51 :: 		result+=(string[i]-'A'+10)*pow(16,lenght-i-1);
	ADD	W14, #0, W0
	ADD	W10, [W0], W0
	ZE	[W0], W1
	MOV	#65, W0
	SUB	W1, W0, W0
	ADD	W0, #10, W0
	MOV	W0, [W14+8]
	ADD	W14, #0, W0
	SUB	W11, [W0], W0
	DEC	W0
	PUSH.D	W10
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV.D	W0, W12
	MOV	#0, W10
	MOV	#16768, W11
	CALL	_pow
	MOV	[W14+8], W2
	MOV	W0, [W14+8]
	MOV	W1, [W14+10]
	MOV	W2, W0
	CLR	W1
	CALL	__Long2Float
	MOV	[W14+8], W2
	MOV	[W14+10], W3
	CALL	__Mul_FP
	MOV	W0, [W14+8]
	MOV	W1, [W14+10]
	MOV	[W14+2], W0
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV	[W14+8], W2
	MOV	[W14+10], W3
	CALL	__AddSub_FP
	CALL	__Float2Longint
	POP.D	W10
	MOV	W0, [W14+2]
;basic.c,49 :: 		else if(string[i]<='F' && string[i]>='A')
L__asciiHexToInt26:
L__asciiHexToInt25:
;basic.c,52 :: 		}
L_asciiHexToInt14:
L_asciiHexToInt10:
;basic.c,39 :: 		for(i=0;i<lenght;i++)
	MOV	[W14+0], W1
	ADD	W14, #0, W0
	ADD	W1, #1, [W0]
;basic.c,53 :: 		}
	GOTO	L_asciiHexToInt4
L_asciiHexToInt5:
;basic.c,54 :: 		return result;
	MOV	[W14+2], W0
;basic.c,55 :: 		}
;basic.c,54 :: 		return result;
;basic.c,55 :: 		}
L_end_asciiHexToInt:
	POP	W13
	POP	W12
	ULNK
	RETURN
; end of _asciiHexToInt
