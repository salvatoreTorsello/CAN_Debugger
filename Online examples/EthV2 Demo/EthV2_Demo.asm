
_mkMarquee:
	LNK	#18

;EthV2_Demo.c,325 :: 		void    mkMarquee(unsigned char l)
;EthV2_Demo.c,330 :: 		if((*marquee == 0) || (marquee == 0))
	PUSH	W11
	PUSH	W12
	MOV	_marquee, W0
	MOV.B	[W0], W0
	CP.B	W0, #0
	BRA NZ	L__mkMarquee137
	GOTO	L__mkMarquee135
L__mkMarquee137:
	MOV	_marquee, W0
	CP	W0, #0
	BRA NZ	L__mkMarquee138
	GOTO	L__mkMarquee134
L__mkMarquee138:
	GOTO	L_mkMarquee2
L__mkMarquee135:
L__mkMarquee134:
;EthV2_Demo.c,332 :: 		marquee = bufInfo;
	MOV	#lo_addr(_bufInfo), W0
	MOV	W0, _marquee
;EthV2_Demo.c,333 :: 		}
L_mkMarquee2:
;EthV2_Demo.c,334 :: 		if((len=strlen(marquee)) < 16) {
	PUSH	W10
	MOV	_marquee, W10
	CALL	_strlen
	POP	W10
; len start address is: 8 (W4)
	MOV.B	W0, W4
	CP.B	W0, #16
	BRA LTU	L__mkMarquee139
	GOTO	L_mkMarquee3
L__mkMarquee139:
;EthV2_Demo.c,335 :: 		memcpy(marqeeBuff, marquee, len);
	ADD	W14, #0, W0
	PUSH	W10
	ZE	W4, W12
	MOV	_marquee, W11
	MOV	W0, W10
	CALL	_memcpy
;EthV2_Demo.c,336 :: 		memcpy(marqeeBuff+len, bufInfo, 16-len);
	ZE	W4, W0
	SUBR	W0, #16, W2
	ADD	W14, #0, W1
	ZE	W4, W0
; len end address is: 8 (W4)
	ADD	W1, W0, W0
	MOV	W2, W12
	MOV	#lo_addr(_bufInfo), W11
	MOV	W0, W10
	CALL	_memcpy
	POP	W10
;EthV2_Demo.c,337 :: 		}
	GOTO	L_mkMarquee4
L_mkMarquee3:
;EthV2_Demo.c,339 :: 		memcpy(marqeeBuff, marquee, 16);
	ADD	W14, #0, W0
	PUSH	W10
	MOV	#16, W12
	MOV	_marquee, W11
	MOV	W0, W10
	CALL	_memcpy
	POP	W10
L_mkMarquee4:
;EthV2_Demo.c,340 :: 		marqeeBuff[16] = 0;
	ADD	W14, #0, W0
	ADD	W0, #16, W1
	CLR	W0
	MOV.B	W0, [W1]
;EthV2_Demo.c,342 :: 		SPI_Set_Active(SPI3_Read, SPI3_Write);
	PUSH	W10
	MOV	#lo_addr(_SPI3_Write), W11
	MOV	#lo_addr(_SPI3_Read), W10
	CALL	_SPI_Set_Active
	POP	W10
;EthV2_Demo.c,343 :: 		SPI_Lcd_Out(l, 1, marqeeBuff);
	ADD	W14, #0, W0
	MOV	W0, W12
	MOV.B	#1, W11
	CALL	_SPI_Lcd_Out
;EthV2_Demo.c,344 :: 		}
L_end_mkMarquee:
	POP	W12
	POP	W11
	ULNK
	RETURN
; end of _mkMarquee

_int2str:
	LNK	#8

;EthV2_Demo.c,398 :: 		void    int2str(long l, unsigned char *s)
;EthV2_Demo.c,402 :: 		if(l == 0)
	CP	W10, #0
	CPB	W11, #0
	BRA Z	L__int2str141
	GOTO	L_int2str5
L__int2str141:
;EthV2_Demo.c,404 :: 		s[0] = '0';
	MOV.B	#48, W0
	MOV.B	W0, [W12]
;EthV2_Demo.c,405 :: 		s[1] = 0;
	ADD	W12, #1, W1
	CLR	W0
	MOV.B	W0, [W1]
;EthV2_Demo.c,406 :: 		}
	GOTO	L_int2str6
L_int2str5:
;EthV2_Demo.c,409 :: 		if(l < 0)
	CP	W10, #0
	CPB	W11, #0
	BRA LT	L__int2str142
	GOTO	L_int2str7
L__int2str142:
;EthV2_Demo.c,411 :: 		l *= -1;
	MOV.D	W10, W0
	MOV	#65535, W2
	MOV	#65535, W3
	CALL	__Multiply_32x32
	MOV.D	W0, W10
;EthV2_Demo.c,412 :: 		n = 1;
	MOV.B	#1, W0
	MOV.B	W0, [W14+2]
;EthV2_Demo.c,413 :: 		}
	GOTO	L_int2str8
L_int2str7:
;EthV2_Demo.c,416 :: 		n = 0;
	CLR	W0
	MOV.B	W0, [W14+2]
;EthV2_Demo.c,417 :: 		}
L_int2str8:
;EthV2_Demo.c,418 :: 		s[0] = 0;
	CLR	W0
	MOV.B	W0, [W12]
;EthV2_Demo.c,419 :: 		i = 0;
	CLR	W0
	MOV.B	W0, [W14+0]
;EthV2_Demo.c,420 :: 		while(l > 0)
L_int2str9:
	CP	W10, #0
	CPB	W11, #0
	BRA GT	L__int2str143
	GOTO	L_int2str10
L__int2str143:
;EthV2_Demo.c,422 :: 		for(j = i + 1; j > 0; j--)
	MOV.B	[W14+0], W1
	ADD	W14, #1, W0
	ADD.B	W1, #1, [W0]
L_int2str11:
	MOV.B	[W14+1], W0
	CP.B	W0, #0
	BRA GTU	L__int2str144
	GOTO	L_int2str12
L__int2str144:
;EthV2_Demo.c,424 :: 		s[j] = s[j - 1];
	ADD	W14, #1, W0
	ZE	[W0], W0
	ADD	W12, W0, W1
	ADD	W14, #1, W0
	ZE	[W0], W0
	DEC	W0
	ADD	W12, W0, W0
	MOV.B	[W0], [W1]
;EthV2_Demo.c,422 :: 		for(j = i + 1; j > 0; j--)
	MOV.B	#1, W1
	ADD	W14, #1, W0
	SUBR.B	W1, [W0], [W0]
;EthV2_Demo.c,425 :: 		}
	GOTO	L_int2str11
L_int2str12:
;EthV2_Demo.c,426 :: 		s[0] = l % 10;
	MOV	W12, W0
	MOV	W0, [W14+6]
	PUSH	W12
	PUSH.D	W10
	MOV	#10, W2
	MOV	#0, W3
	MOV.D	W10, W0
	SETM	W4
	CALL	__Modulus_32x32
	POP.D	W10
	POP	W12
	MOV	[W14+6], W2
	MOV.B	W0, [W2]
;EthV2_Demo.c,427 :: 		s[0] += '0';
	ZE	[W12], W1
	MOV	#48, W0
	ADD	W1, W0, W0
	MOV.B	W0, [W12]
;EthV2_Demo.c,428 :: 		i++;
	MOV.B	[W14+0], W1
	ADD	W14, #0, W0
	ADD.B	W1, #1, [W0]
;EthV2_Demo.c,429 :: 		l /= 10;
	PUSH	W12
	PUSH.D	W10
	MOV	#10, W2
	MOV	#0, W3
	MOV.D	W10, W0
	SETM	W4
	CALL	__Divide_32x32
	POP.D	W10
	POP	W12
	MOV.D	W0, W10
;EthV2_Demo.c,430 :: 		}
	GOTO	L_int2str9
L_int2str10:
;EthV2_Demo.c,431 :: 		if(n)
	ADD	W14, #2, W0
	CP0.B	[W0]
	BRA NZ	L__int2str145
	GOTO	L_int2str14
L__int2str145:
;EthV2_Demo.c,433 :: 		for(j = i + 1; j > 0; j--)
	MOV.B	[W14+0], W1
	ADD	W14, #1, W0
	ADD.B	W1, #1, [W0]
L_int2str15:
	MOV.B	[W14+1], W0
	CP.B	W0, #0
	BRA GTU	L__int2str146
	GOTO	L_int2str16
L__int2str146:
;EthV2_Demo.c,435 :: 		s[j] = s[j - 1];
	ADD	W14, #1, W0
	ZE	[W0], W0
	ADD	W12, W0, W1
	ADD	W14, #1, W0
	ZE	[W0], W0
	DEC	W0
	ADD	W12, W0, W0
	MOV.B	[W0], [W1]
;EthV2_Demo.c,433 :: 		for(j = i + 1; j > 0; j--)
	MOV.B	[W14+1], W1
	ADD	W14, #1, W0
	SUB.B	W1, #1, [W0]
;EthV2_Demo.c,436 :: 		}
	GOTO	L_int2str15
L_int2str16:
;EthV2_Demo.c,437 :: 		s[0] = '-';
	MOV.B	#45, W0
	MOV.B	W0, [W12]
;EthV2_Demo.c,438 :: 		}
L_int2str14:
;EthV2_Demo.c,439 :: 		}
L_int2str6:
;EthV2_Demo.c,440 :: 		}
L_end_int2str:
	ULNK
	RETURN
; end of _int2str

_ip2str:
	LNK	#6

;EthV2_Demo.c,445 :: 		void    ip2str(unsigned char *s, unsigned char *ip)
;EthV2_Demo.c,450 :: 		*s = 0;
	PUSH	W12
	CLR	W0
	MOV.B	W0, [W10]
;EthV2_Demo.c,451 :: 		for(i = 0; i < 4; i++)
	CLR	W0
	MOV.B	W0, [W14+0]
L_ip2str18:
	MOV.B	[W14+0], W0
	CP.B	W0, #4
	BRA LTU	L__ip2str148
	GOTO	L_ip2str19
L__ip2str148:
;EthV2_Demo.c,453 :: 		int2str(ip[i], buf);
	ADD	W14, #1, W1
	ADD	W14, #0, W0
	ZE	[W0], W0
	ADD	W11, W0, W0
	PUSH.D	W10
	MOV	W1, W12
	ZE	[W0], W10
	CLR	W11
	CALL	_int2str
	POP.D	W10
;EthV2_Demo.c,454 :: 		strcat(s, buf);
	ADD	W14, #1, W0
	PUSH	W11
	MOV	W0, W11
	CALL	_strcat
	POP	W11
;EthV2_Demo.c,455 :: 		if(i != 3)
	MOV.B	[W14+0], W0
	CP.B	W0, #3
	BRA NZ	L__ip2str149
	GOTO	L_ip2str21
L__ip2str149:
;EthV2_Demo.c,456 :: 		strcat(s, ".");
	PUSH	W11
	MOV	#lo_addr(?lstr34_EthV2_Demo), W11
	CALL	_strcat
	POP	W11
L_ip2str21:
;EthV2_Demo.c,451 :: 		for(i = 0; i < 4; i++)
	MOV.B	[W14+0], W1
	ADD	W14, #0, W0
	ADD.B	W1, #1, [W0]
;EthV2_Demo.c,457 :: 		}
	GOTO	L_ip2str18
L_ip2str19:
;EthV2_Demo.c,458 :: 		}
L_end_ip2str:
	POP	W12
	ULNK
	RETURN
; end of _ip2str

_ts2str:
	LNK	#6

;EthV2_Demo.c,464 :: 		void    ts2str(unsigned char *s, TimeStruct *t, unsigned char m)
;EthV2_Demo.c,471 :: 		if(m & TS2STR_DATE)
	PUSH	W10
	PUSH	W11
	PUSH	W12
	BTSS	W12, #0
	GOTO	L_ts2str22
;EthV2_Demo.c,473 :: 		strcpy(s, wday[t->wd]);        // week day
	ADD	W11, #4, W0
	MOV.B	[W0], W0
	ZE	W0, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_wday), W0
	ADD	W0, W1, W0
	PUSH	W11
	MOV	[W0], W11
	CALL	_strcpy
;EthV2_Demo.c,474 :: 		strcat(s, " ");
	MOV	#lo_addr(?lstr35_EthV2_Demo), W11
	CALL	_strcat
	POP	W11
;EthV2_Demo.c,475 :: 		ByteToStr(t->md, tmp);         // day num
	ADD	W14, #0, W1
	ADD	W11, #3, W0
	PUSH.D	W10
	MOV	W1, W11
	MOV.B	[W0], W10
	CALL	_ByteToStr
	POP.D	W10
;EthV2_Demo.c,476 :: 		strcat(s, tmp + 1);
	ADD	W14, #0, W0
	INC	W0
	PUSH	W11
	MOV	W0, W11
	CALL	_strcat
;EthV2_Demo.c,477 :: 		strcat(s, " ");
	MOV	#lo_addr(?lstr36_EthV2_Demo), W11
	CALL	_strcat
	POP	W11
;EthV2_Demo.c,478 :: 		strcat(s, mon[t->mo]);        // month
	ADD	W11, #5, W0
	MOV.B	[W0], W0
	ZE	W0, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_mon), W0
	ADD	W0, W1, W0
	PUSH	W11
	MOV	[W0], W11
	CALL	_strcat
;EthV2_Demo.c,479 :: 		strcat(s, " ");
	MOV	#lo_addr(?lstr37_EthV2_Demo), W11
	CALL	_strcat
	POP	W11
;EthV2_Demo.c,480 :: 		WordToStr(t->yy, tmp);         // year
	ADD	W14, #0, W1
	ADD	W11, #6, W0
	PUSH.D	W10
	MOV	W1, W11
	MOV	[W0], W10
	CALL	_WordToStr
	POP.D	W10
;EthV2_Demo.c,481 :: 		strcat(s, tmp + 1);
	ADD	W14, #0, W0
	INC	W0
	PUSH	W11
	MOV	W0, W11
	CALL	_strcat
;EthV2_Demo.c,482 :: 		strcat(s, " ");
	MOV	#lo_addr(?lstr38_EthV2_Demo), W11
	CALL	_strcat
	POP	W11
;EthV2_Demo.c,483 :: 		}
	GOTO	L_ts2str23
L_ts2str22:
;EthV2_Demo.c,486 :: 		*s = 0;
	CLR	W0
	MOV.B	W0, [W10]
;EthV2_Demo.c,487 :: 		}
L_ts2str23:
;EthV2_Demo.c,492 :: 		if(m & TS2STR_TIME)
	BTSS	W12, #1
	GOTO	L_ts2str24
;EthV2_Demo.c,494 :: 		ByteToStr(t->hh, tmp);         // hour
	ADD	W14, #0, W1
	ADD	W11, #2, W0
	PUSH.D	W10
	MOV	W1, W11
	MOV.B	[W0], W10
	CALL	_ByteToStr
	POP.D	W10
;EthV2_Demo.c,495 :: 		strcat(s, tmp + 1);
	ADD	W14, #0, W0
	INC	W0
	PUSH	W11
	MOV	W0, W11
	CALL	_strcat
;EthV2_Demo.c,496 :: 		strcat(s, ":");
	MOV	#lo_addr(?lstr39_EthV2_Demo), W11
	CALL	_strcat
	POP	W11
;EthV2_Demo.c,497 :: 		ByteToStr(t->mn, tmp);         // minute
	ADD	W14, #0, W1
	ADD	W11, #1, W0
	PUSH.D	W10
	MOV	W1, W11
	MOV.B	[W0], W10
	CALL	_ByteToStr
	POP.D	W10
;EthV2_Demo.c,498 :: 		if(*(tmp + 1) == ' ')
	ADD	W14, #0, W0
	INC	W0
	MOV.B	[W0], W1
	MOV.B	#32, W0
	CP.B	W1, W0
	BRA Z	L__ts2str151
	GOTO	L_ts2str25
L__ts2str151:
;EthV2_Demo.c,500 :: 		*(tmp + 1) = '0';
	ADD	W14, #0, W0
	ADD	W0, #1, W1
	MOV.B	#48, W0
	MOV.B	W0, [W1]
;EthV2_Demo.c,501 :: 		}
L_ts2str25:
;EthV2_Demo.c,502 :: 		strcat(s, tmp + 1);
	ADD	W14, #0, W0
	INC	W0
	PUSH	W11
	MOV	W0, W11
	CALL	_strcat
;EthV2_Demo.c,503 :: 		strcat(s, ":");
	MOV	#lo_addr(?lstr40_EthV2_Demo), W11
	CALL	_strcat
	POP	W11
;EthV2_Demo.c,504 :: 		ByteToStr(t->ss, tmp);         // second
	ADD	W14, #0, W1
	MOV.B	[W11], W0
	PUSH	W10
	MOV	W1, W11
	MOV.B	W0, W10
	CALL	_ByteToStr
	POP	W10
;EthV2_Demo.c,505 :: 		if(*(tmp + 1) == ' ')
	ADD	W14, #0, W0
	INC	W0
	MOV.B	[W0], W1
	MOV.B	#32, W0
	CP.B	W1, W0
	BRA Z	L__ts2str152
	GOTO	L_ts2str26
L__ts2str152:
;EthV2_Demo.c,507 :: 		*(tmp + 1) = '0';
	ADD	W14, #0, W0
	ADD	W0, #1, W1
	MOV.B	#48, W0
	MOV.B	W0, [W1]
;EthV2_Demo.c,508 :: 		}
L_ts2str26:
;EthV2_Demo.c,509 :: 		strcat(s, tmp + 1);
	ADD	W14, #0, W0
	INC	W0
	MOV	W0, W11
	CALL	_strcat
;EthV2_Demo.c,510 :: 		}
L_ts2str24:
;EthV2_Demo.c,515 :: 		if(m & TS2STR_TZ)
	BTSS	W12, #2
	GOTO	L_ts2str27
;EthV2_Demo.c,517 :: 		strcat(s, " GMT");
	MOV	#lo_addr(?lstr41_EthV2_Demo), W11
	CALL	_strcat
;EthV2_Demo.c,518 :: 		if(conf.tz > 0)
	MOV	#lo_addr(_conf+2), W0
	MOV.B	[W0], W0
	CP.B	W0, #0
	BRA GT	L__ts2str153
	GOTO	L_ts2str28
L__ts2str153:
;EthV2_Demo.c,520 :: 		strcat(s, "+");
	MOV	#lo_addr(?lstr42_EthV2_Demo), W11
	CALL	_strcat
;EthV2_Demo.c,521 :: 		}
L_ts2str28:
;EthV2_Demo.c,522 :: 		int2str(conf.tz, s + strlen(s));
	CALL	_strlen
	ADD	W10, W0, W1
	MOV	#lo_addr(_conf+2), W0
	MOV	W1, W12
	SE	[W0], W10
	ASR	W10, #15, W11
	CALL	_int2str
;EthV2_Demo.c,523 :: 		}
L_ts2str27:
;EthV2_Demo.c,524 :: 		}
L_end_ts2str:
	POP	W12
	POP	W11
	POP	W10
	ULNK
	RETURN
; end of _ts2str

_nibble2hex:

;EthV2_Demo.c,529 :: 		unsigned char nibble2hex(unsigned char n)
;EthV2_Demo.c,531 :: 		n &= 0x0f;
	ZE	W10, W0
	AND	W0, #15, W0
	MOV.B	W0, W10
;EthV2_Demo.c,532 :: 		if(n >= 0x0a)
	CP.B	W0, #10
	BRA GEU	L__nibble2hex155
	GOTO	L_nibble2hex29
L__nibble2hex155:
;EthV2_Demo.c,534 :: 		return(n + '7');
	ZE	W10, W1
	MOV	#55, W0
	ADD	W1, W0, W0
	GOTO	L_end_nibble2hex
;EthV2_Demo.c,535 :: 		}
L_nibble2hex29:
;EthV2_Demo.c,536 :: 		return(n + '0');
	ZE	W10, W1
	MOV	#48, W0
	ADD	W1, W0, W0
;EthV2_Demo.c,537 :: 		}
L_end_nibble2hex:
	RETURN
; end of _nibble2hex

_byte2hex:

;EthV2_Demo.c,542 :: 		void    byte2hex(unsigned char *s, unsigned char v)
;EthV2_Demo.c,544 :: 		*s++ = nibble2hex(v >> 4);
	ZE	W11, W0
	LSR	W0, #4, W0
	PUSH	W10
	MOV.B	W0, W10
	CALL	_nibble2hex
	POP	W10
	MOV.B	W0, [W10]
	ADD	W10, #1, W0
	MOV	W0, W10
;EthV2_Demo.c,545 :: 		*s++ = nibble2hex(v);
	PUSH	W10
	MOV.B	W11, W10
	CALL	_nibble2hex
	POP	W10
	MOV.B	W0, [W10]
	ADD	W10, #1, W0
	MOV	W0, W10
;EthV2_Demo.c,546 :: 		*s = '.';
	MOV.B	#46, W0
	MOV.B	W0, [W10]
;EthV2_Demo.c,547 :: 		}
L_end_byte2hex:
	RETURN
; end of _byte2hex

_mkLCDselect:
	LNK	#4

;EthV2_Demo.c,552 :: 		unsigned int    mkLCDselect(unsigned char l, unsigned char m)
;EthV2_Demo.c,557 :: 		len = putConstString("<select onChange=\\\"document.location.href = '/admin/");
	PUSH	W10
	PUSH.D	W10
	MOV	#lo_addr(?lstr_43_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	W0, [W14+2]
;EthV2_Demo.c,558 :: 		SPI_Set_Active(SPI1_Read, SPI1_Write);
	MOV	#lo_addr(_SPI1_Write), W11
	MOV	#lo_addr(_SPI1_Read), W10
	CALL	_SPI_Set_Active
	POP.D	W10
;EthV2_Demo.c,559 :: 		SPI_Ethernet_putByte('0' + l); len++;
	MOV	#48, W1
	ZE	W10, W0
	ADD	W1, W0, W0
	PUSH	W11
	MOV.B	W0, W10
	CALL	_SPI_Ethernet_putByte
	MOV	[W14+2], W1
	ADD	W14, #2, W0
	ADD	W1, #1, [W0]
;EthV2_Demo.c,560 :: 		len += putConstString("/' + this.selectedIndex\\\">");
	MOV	#lo_addr(?lstr_44_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	POP	W11
	ADD	W14, #2, W2
	ADD	W14, #2, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,561 :: 		for(i = 0; i < 4; i++)
	CLR	W0
	MOV.B	W0, [W14+0]
L_mkLCDselect30:
	MOV.B	[W14+0], W0
	CP.B	W0, #4
	BRA LTU	L__mkLCDselect158
	GOTO	L_mkLCDselect31
L__mkLCDselect158:
;EthV2_Demo.c,563 :: 		len += putConstString("<option ");
	PUSH.D	W10
	MOV	#lo_addr(?lstr_45_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	POP.D	W10
	ADD	W14, #2, W2
	ADD	W14, #2, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,564 :: 		if(i == m)
	ADD	W14, #0, W0
	CP.B	W11, [W0]
	BRA Z	L__mkLCDselect159
	GOTO	L_mkLCDselect33
L__mkLCDselect159:
;EthV2_Demo.c,566 :: 		len += putConstString(" selected");
	PUSH.D	W10
	MOV	#lo_addr(?lstr_46_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	POP.D	W10
	ADD	W14, #2, W2
	ADD	W14, #2, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,567 :: 		}
L_mkLCDselect33:
;EthV2_Demo.c,568 :: 		len += putConstString(">");
	PUSH.D	W10
	MOV	#lo_addr(?lstr_47_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	ADD	W14, #2, W2
	ADD	W14, #2, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,569 :: 		len += putConstString(LCDoption[i]);
	ADD	W14, #0, W0
	ZE	[W0], W0
	SL	W0, #1, W1
	MOV	#lo_addr(_LCDoption), W0
	ADD	W0, W1, W0
	MOV	[W0], W10
	CALL	_SPI_Ethernet_putConstString
	POP.D	W10
	ADD	W14, #2, W2
	ADD	W14, #2, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,561 :: 		for(i = 0; i < 4; i++)
	MOV.B	[W14+0], W1
	ADD	W14, #0, W0
	ADD.B	W1, #1, [W0]
;EthV2_Demo.c,570 :: 		}
	GOTO	L_mkLCDselect30
L_mkLCDselect31:
;EthV2_Demo.c,571 :: 		len += putConstString("</select>\";");
	PUSH.D	W10
	MOV	#lo_addr(?lstr_48_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	POP.D	W10
	ADD	W14, #2, W1
	ADD	W0, [W1], W0
;EthV2_Demo.c,572 :: 		return(len);
;EthV2_Demo.c,573 :: 		}
;EthV2_Demo.c,572 :: 		return(len);
;EthV2_Demo.c,573 :: 		}
L_end_mkLCDselect:
	POP	W10
	ULNK
	RETURN
; end of _mkLCDselect

_mkLCDLine:

;EthV2_Demo.c,578 :: 		void mkLCDLine(unsigned char l, unsigned char m)
;EthV2_Demo.c,580 :: 		switch(m)
	PUSH	W11
	PUSH	W12
	GOTO	L_mkLCDLine34
;EthV2_Demo.c,582 :: 		case 0:
L_mkLCDLine36:
;EthV2_Demo.c,584 :: 		memset(bufInfo, 0, sizeof(bufInfo));
	PUSH	W10
	MOV	#200, W12
	CLR	W11
	MOV	#lo_addr(_bufInfo), W10
	CALL	_memset
	POP	W10
;EthV2_Demo.c,585 :: 		if(lastSync)
	MOV	#lo_addr(_lastSync), W1
	MOV	[W1++], W0
	IOR	W0, [W1--], W0
	BRA NZ	L__mkLCDLine161
	GOTO	L_mkLCDLine37
L__mkLCDLine161:
;EthV2_Demo.c,588 :: 		strcpy(bufInfo, "Today is ");
	PUSH	W10
	MOV	#lo_addr(?lstr49_EthV2_Demo), W11
	MOV	#lo_addr(_bufInfo), W10
	CALL	_strcpy
;EthV2_Demo.c,589 :: 		ts2str(bufInfo + strlen(bufInfo), &ts, TS2STR_DATE);
	MOV	#lo_addr(_bufInfo), W10
	CALL	_strlen
	MOV	#lo_addr(_bufInfo), W1
	ADD	W1, W0, W0
	MOV.B	#1, W12
	MOV	#lo_addr(_ts), W11
	MOV	W0, W10
	CALL	_ts2str
;EthV2_Demo.c,590 :: 		strcat(bufInfo, ". Please visit www.micro-examples.com for more details about the Ethernal Clock. You can browse ");
	MOV	#lo_addr(?lstr50_EthV2_Demo), W11
	MOV	#lo_addr(_bufInfo), W10
	CALL	_strcat
;EthV2_Demo.c,591 :: 		ip2str(bufInfo + strlen(bufInfo), ipAddr);
	MOV	#lo_addr(_bufInfo), W10
	CALL	_strlen
	MOV	#lo_addr(_bufInfo), W1
	ADD	W1, W0, W0
	MOV	#lo_addr(_ipAddr), W11
	MOV	W0, W10
	CALL	_ip2str
;EthV2_Demo.c,592 :: 		strcat(bufInfo, " to set the clock preferences.    ");
	MOV	#lo_addr(?lstr51_EthV2_Demo), W11
	MOV	#lo_addr(_bufInfo), W10
	CALL	_strcat
	POP	W10
;EthV2_Demo.c,593 :: 		}
	GOTO	L_mkLCDLine38
L_mkLCDLine37:
;EthV2_Demo.c,597 :: 		strcpy(bufInfo, "The SNTP server did not respond, please browse ");
	PUSH	W10
	MOV	#lo_addr(?lstr52_EthV2_Demo), W11
	MOV	#lo_addr(_bufInfo), W10
	CALL	_strcpy
;EthV2_Demo.c,598 :: 		ip2str(bufInfo + strlen(bufInfo), ipAddr);
	MOV	#lo_addr(_bufInfo), W10
	CALL	_strlen
	MOV	#lo_addr(_bufInfo), W1
	ADD	W1, W0, W0
	MOV	#lo_addr(_ipAddr), W11
	MOV	W0, W10
	CALL	_ip2str
;EthV2_Demo.c,599 :: 		strcat(bufInfo, " to check clock settings.    ");
	MOV	#lo_addr(?lstr53_EthV2_Demo), W11
	MOV	#lo_addr(_bufInfo), W10
	CALL	_strcat
	POP	W10
;EthV2_Demo.c,600 :: 		}
L_mkLCDLine38:
;EthV2_Demo.c,601 :: 		mkMarquee(l);           // display marquee
	CALL	_mkMarquee
;EthV2_Demo.c,602 :: 		break;
	GOTO	L_mkLCDLine35
;EthV2_Demo.c,603 :: 		case 1:
L_mkLCDLine39:
;EthV2_Demo.c,605 :: 		if(lastSync)
	MOV	#lo_addr(_lastSync), W1
	MOV	[W1++], W0
	IOR	W0, [W1--], W0
	BRA NZ	L__mkLCDLine162
	GOTO	L_mkLCDLine40
L__mkLCDLine162:
;EthV2_Demo.c,607 :: 		ts2str(bufInfo, &ts, TS2STR_DATE);
	PUSH	W10
	MOV.B	#1, W12
	MOV	#lo_addr(_ts), W11
	MOV	#lo_addr(_bufInfo), W10
	CALL	_ts2str
	POP	W10
;EthV2_Demo.c,608 :: 		}
	GOTO	L_mkLCDLine41
L_mkLCDLine40:
;EthV2_Demo.c,611 :: 		strcpy(bufInfo, "Date Not Ready !");
	PUSH	W10
	MOV	#lo_addr(?lstr54_EthV2_Demo), W11
	MOV	#lo_addr(_bufInfo), W10
	CALL	_strcpy
	POP	W10
;EthV2_Demo.c,612 :: 		}
L_mkLCDLine41:
;EthV2_Demo.c,613 :: 		SPI_Set_Active(SPI3_Read, SPI3_Write);
	PUSH	W10
	MOV	#lo_addr(_SPI3_Write), W11
	MOV	#lo_addr(_SPI3_Read), W10
	CALL	_SPI_Set_Active
	POP	W10
;EthV2_Demo.c,614 :: 		SPI_Lcd_Out(l, 1, bufInfo);
	MOV	#lo_addr(_bufInfo), W12
	MOV.B	#1, W11
	CALL	_SPI_Lcd_Out
;EthV2_Demo.c,615 :: 		break;
	GOTO	L_mkLCDLine35
;EthV2_Demo.c,616 :: 		case 2:
L_mkLCDLine42:
;EthV2_Demo.c,618 :: 		if(lastSync)
	MOV	#lo_addr(_lastSync), W1
	MOV	[W1++], W0
	IOR	W0, [W1--], W0
	BRA NZ	L__mkLCDLine163
	GOTO	L_mkLCDLine43
L__mkLCDLine163:
;EthV2_Demo.c,620 :: 		ts2str(bufInfo, &ts, TS2STR_TIME);
	PUSH	W10
	MOV.B	#2, W12
	MOV	#lo_addr(_ts), W11
	MOV	#lo_addr(_bufInfo), W10
	CALL	_ts2str
;EthV2_Demo.c,621 :: 		SPI_Set_Active(SPI3_Read, SPI3_Write);
	MOV	#lo_addr(_SPI3_Write), W11
	MOV	#lo_addr(_SPI3_Read), W10
	CALL	_SPI_Set_Active
	POP	W10
;EthV2_Demo.c,622 :: 		SPI_Lcd_Out(l, 4, bufInfo);
	MOV	#lo_addr(_bufInfo), W12
	MOV.B	#4, W11
	CALL	_SPI_Lcd_Out
;EthV2_Demo.c,623 :: 		}
	GOTO	L_mkLCDLine44
L_mkLCDLine43:
;EthV2_Demo.c,626 :: 		strcpy(bufInfo, "Time Not Ready !");
	PUSH	W10
	MOV	#lo_addr(?lstr55_EthV2_Demo), W11
	MOV	#lo_addr(_bufInfo), W10
	CALL	_strcpy
;EthV2_Demo.c,627 :: 		SPI_Set_Active(SPI3_Read, SPI3_Write);
	MOV	#lo_addr(_SPI3_Write), W11
	MOV	#lo_addr(_SPI3_Read), W10
	CALL	_SPI_Set_Active
	POP	W10
;EthV2_Demo.c,628 :: 		SPI_Lcd_Out(l, 1, bufInfo);
	MOV	#lo_addr(_bufInfo), W12
	MOV.B	#1, W11
	CALL	_SPI_Lcd_Out
;EthV2_Demo.c,629 :: 		}
L_mkLCDLine44:
;EthV2_Demo.c,630 :: 		break;
	GOTO	L_mkLCDLine35
;EthV2_Demo.c,631 :: 		}
L_mkLCDLine34:
	CP.B	W11, #0
	BRA NZ	L__mkLCDLine164
	GOTO	L_mkLCDLine36
L__mkLCDLine164:
	CP.B	W11, #1
	BRA NZ	L__mkLCDLine165
	GOTO	L_mkLCDLine39
L__mkLCDLine165:
	CP.B	W11, #2
	BRA NZ	L__mkLCDLine166
	GOTO	L_mkLCDLine42
L__mkLCDLine166:
L_mkLCDLine35:
;EthV2_Demo.c,632 :: 		}
L_end_mkLCDLine:
	POP	W12
	POP	W11
	RETURN
; end of _mkLCDLine

_mkSNTPrequest:
	LNK	#52

;EthV2_Demo.c,637 :: 		void    mkSNTPrequest()
;EthV2_Demo.c,642 :: 		SPI_Set_Active(SPI1_Read, SPI1_Write);
	PUSH	W10
	PUSH	W11
	PUSH	W12
	PUSH	W13
	MOV	#lo_addr(_SPI1_Write), W11
	MOV	#lo_addr(_SPI1_Read), W10
	CALL	_SPI_Set_Active
;EthV2_Demo.c,643 :: 		if (sntpSync)
	MOV	#lo_addr(_sntpSync), W0
	CP0.B	[W0]
	BRA NZ	L__mkSNTPrequest168
	GOTO	L_mkSNTPrequest45
L__mkSNTPrequest168:
;EthV2_Demo.c,644 :: 		if (SPI_Ethernet_UserTimerSec >= sntpTimer)
	MOV	_SPI_Ethernet_UserTimerSec, W1
	MOV	_SPI_Ethernet_UserTimerSec+2, W2
	MOV	#lo_addr(_sntpTimer), W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA GEU	L__mkSNTPrequest169
	GOTO	L_mkSNTPrequest46
L__mkSNTPrequest169:
;EthV2_Demo.c,645 :: 		if (!lastSync) {
	MOV	#lo_addr(_lastSync), W1
	MOV	[W1++], W0
	IOR	W0, [W1--], W0
	BRA Z	L__mkSNTPrequest170
	GOTO	L_mkSNTPrequest47
L__mkSNTPrequest170:
;EthV2_Demo.c,646 :: 		sntpSync = 0;
	MOV	#lo_addr(_sntpSync), W1
	CLR	W0
	MOV.B	W0, [W1]
;EthV2_Demo.c,647 :: 		if (!memcmp(conf.sntpIP, "\0\0\0\0", 4))
	MOV	#4, W12
	MOV	#lo_addr(?lstr56_EthV2_Demo), W11
	MOV	#lo_addr(_conf+3), W10
	CALL	_memcmp
	CP0	W0
	BRA Z	L__mkSNTPrequest171
	GOTO	L_mkSNTPrequest48
L__mkSNTPrequest171:
;EthV2_Demo.c,648 :: 		reloadDNS = 1 ; // force to solve DNS
	MOV	#lo_addr(_reloadDNS), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
L_mkSNTPrequest48:
;EthV2_Demo.c,649 :: 		}
L_mkSNTPrequest47:
L_mkSNTPrequest46:
L_mkSNTPrequest45:
;EthV2_Demo.c,651 :: 		if(reloadDNS)   // is SNTP ip address to be reloaded from DNS ?
	MOV	#lo_addr(_reloadDNS), W0
	CP0.B	[W0]
	BRA NZ	L__mkSNTPrequest172
	GOTO	L_mkSNTPrequest49
L__mkSNTPrequest172:
;EthV2_Demo.c,653 :: 		SPI_Set_Active(SPI3_Read, SPI3_Write);
	MOV	#lo_addr(_SPI3_Write), W11
	MOV	#lo_addr(_SPI3_Read), W10
	CALL	_SPI_Set_Active
;EthV2_Demo.c,655 :: 		SPI_Lcd_Out(2, 1, "Connecting...   ");
	MOV	#lo_addr(?lstr57_EthV2_Demo), W12
	MOV.B	#1, W11
	MOV.B	#2, W10
	CALL	_SPI_Lcd_Out
;EthV2_Demo.c,657 :: 		if(isalpha(*conf.sntpServer))   // doest host name start with an alphabetic character ?
	MOV	#lo_addr(_conf+7), W0
	MOV.B	[W0], W10
	CALL	_isalpha
	CP0	W0
	BRA NZ	L__mkSNTPrequest173
	GOTO	L_mkSNTPrequest50
L__mkSNTPrequest173:
;EthV2_Demo.c,660 :: 		memset(conf.sntpIP, 0, 4);
	MOV	#4, W12
	CLR	W11
	MOV	#lo_addr(_conf+3), W10
	CALL	_memset
;EthV2_Demo.c,661 :: 		SPI_Set_Active(SPI1_Read, SPI1_Write);
	MOV	#lo_addr(_SPI1_Write), W11
	MOV	#lo_addr(_SPI1_Read), W10
	CALL	_SPI_Set_Active
;EthV2_Demo.c,662 :: 		if(remoteIpAddr = SPI_Ethernet_dnsResolve(conf.sntpServer, 5))
	MOV.B	#5, W11
	MOV	#lo_addr(_conf+7), W10
	CALL	_SPI_Ethernet_dnsResolve
; remoteIpAddr start address is: 2 (W1)
	MOV	W0, W1
	CP0	W0
	BRA NZ	L__mkSNTPrequest174
	GOTO	L_mkSNTPrequest51
L__mkSNTPrequest174:
;EthV2_Demo.c,665 :: 		memcpy(conf.sntpIP, remoteIpAddr, 4);
	MOV	#4, W12
	MOV	W1, W11
; remoteIpAddr end address is: 2 (W1)
	MOV	#lo_addr(_conf+3), W10
	CALL	_memcpy
;EthV2_Demo.c,666 :: 		}
L_mkSNTPrequest51:
;EthV2_Demo.c,667 :: 		}
	GOTO	L_mkSNTPrequest52
L_mkSNTPrequest50:
;EthV2_Demo.c,671 :: 		unsigned char *ptr = conf.sntpServer;
; ptr start address is: 12 (W6)
	MOV	#lo_addr(_conf+7), W6
;EthV2_Demo.c,673 :: 		conf.sntpIP[0] = atoi(ptr);
	MOV	W6, W10
	CALL	_atoi
	MOV	#lo_addr(_conf+3), W1
	MOV.B	W0, [W1]
;EthV2_Demo.c,674 :: 		ptr = strchr(ptr, '.') + 1;
	MOV.B	#46, W11
	MOV	W6, W10
; ptr end address is: 12 (W6)
	CALL	_strchr
	INC	W0
; ptr start address is: 12 (W6)
	MOV	W0, W6
;EthV2_Demo.c,675 :: 		conf.sntpIP[1] = atoi(ptr);
	MOV	W0, W10
	CALL	_atoi
	MOV	#lo_addr(_conf+4), W1
	MOV.B	W0, [W1]
;EthV2_Demo.c,676 :: 		ptr = strchr(ptr, '.') + 1;
	MOV.B	#46, W11
	MOV	W6, W10
; ptr end address is: 12 (W6)
	CALL	_strchr
	INC	W0
; ptr start address is: 12 (W6)
	MOV	W0, W6
;EthV2_Demo.c,677 :: 		conf.sntpIP[2] = atoi(ptr);
	MOV	W0, W10
	CALL	_atoi
	MOV	#lo_addr(_conf+5), W1
	MOV.B	W0, [W1]
;EthV2_Demo.c,678 :: 		ptr = strchr(ptr, '.') + 1;
	MOV.B	#46, W11
	MOV	W6, W10
; ptr end address is: 12 (W6)
	CALL	_strchr
	INC	W0
;EthV2_Demo.c,679 :: 		conf.sntpIP[3] = atoi(ptr);
	MOV	W0, W10
	CALL	_atoi
	MOV	#lo_addr(_conf+6), W1
	MOV.B	W0, [W1]
;EthV2_Demo.c,680 :: 		}
L_mkSNTPrequest52:
;EthV2_Demo.c,682 :: 		reloadDNS = 0;         // no further call to DNS
	MOV	#lo_addr(_reloadDNS), W1
	CLR	W0
	MOV.B	W0, [W1]
;EthV2_Demo.c,684 :: 		sntpSync = 0;          // clock is not sync for now
	MOV	#lo_addr(_sntpSync), W1
	CLR	W0
	MOV.B	W0, [W1]
;EthV2_Demo.c,685 :: 		}
L_mkSNTPrequest49:
;EthV2_Demo.c,687 :: 		if(sntpSync)                    // is clock already synchronized from sntp ?
	MOV	#lo_addr(_sntpSync), W0
	CP0.B	[W0]
	BRA NZ	L__mkSNTPrequest175
	GOTO	L_mkSNTPrequest53
L__mkSNTPrequest175:
;EthV2_Demo.c,689 :: 		return;                // yes, no need to request time
	GOTO	L_end_mkSNTPrequest
;EthV2_Demo.c,690 :: 		}
L_mkSNTPrequest53:
;EthV2_Demo.c,695 :: 		memset(sntpPkt, 0, 48);        // clear sntp packet
	ADD	W14, #0, W0
	MOV	W0, [W14+50]
	MOV	#48, W12
	CLR	W11
	MOV	W0, W10
	CALL	_memset
;EthV2_Demo.c,698 :: 		sntpPkt[0] = 0b00011001;       // LI = 0; VN = 3; MODE = 1
	ADD	W14, #0, W1
	MOV.B	#25, W0
	MOV.B	W0, [W1]
;EthV2_Demo.c,703 :: 		sntpPkt[2] = 0x0a;             // 1024 sec (arbitrary value)
	MOV	[W14+50], W2
	ADD	W2, #2, W1
	MOV.B	#10, W0
	MOV.B	W0, [W1]
;EthV2_Demo.c,706 :: 		sntpPkt[3] = 0xfa;             // 0.015625 sec (arbitrary value)
	ADD	W2, #3, W1
	MOV.B	#250, W0
	MOV.B	W0, [W1]
;EthV2_Demo.c,709 :: 		sntpPkt[6] = 0x44;
	ADD	W2, #6, W1
	MOV.B	#68, W0
	MOV.B	W0, [W1]
;EthV2_Demo.c,712 :: 		sntpPkt[9] = 0x10;
	ADD	W2, #9, W1
	MOV.B	#16, W0
	MOV.B	W0, [W1]
;EthV2_Demo.c,724 :: 		SPI_Set_Active(SPI1_Read, SPI1_Write);
	MOV	#lo_addr(_SPI1_Write), W11
	MOV	#lo_addr(_SPI1_Read), W10
	CALL	_SPI_Set_Active
;EthV2_Demo.c,725 :: 		SPI_Ethernet_sendUDP(conf.sntpIP, 123, 123, sntpPkt, 48); // transmit UDP packet
	ADD	W14, #0, W0
	MOV	W0, W13
	MOV	#123, W12
	MOV	#123, W11
	MOV	#lo_addr(_conf+3), W10
	MOV	#48, W0
	PUSH	W0
	CALL	_SPI_Ethernet_sendUDP
	SUB	#2, W15
;EthV2_Demo.c,727 :: 		sntpSync = 1;  // done
	MOV	#lo_addr(_sntpSync), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;EthV2_Demo.c,728 :: 		lastSync = 0;
	CLR	W0
	CLR	W1
	MOV	W0, _lastSync
	MOV	W1, _lastSync+2
;EthV2_Demo.c,729 :: 		SPI_Set_Active(SPI1_Read, SPI1_Write);
	MOV	#lo_addr(_SPI1_Write), W11
	MOV	#lo_addr(_SPI1_Read), W10
	CALL	_SPI_Set_Active
;EthV2_Demo.c,730 :: 		sntpTimer = SPI_Ethernet_UserTimerSec + 5;
	MOV	_SPI_Ethernet_UserTimerSec, W1
	MOV	_SPI_Ethernet_UserTimerSec+2, W2
	MOV	#lo_addr(_sntpTimer), W0
	ADD	W1, #5, [W0++]
	ADDC	W2, #0, [W0--]
;EthV2_Demo.c,731 :: 		}
L_end_mkSNTPrequest:
	POP	W13
	POP	W12
	POP	W11
	POP	W10
	ULNK
	RETURN
; end of _mkSNTPrequest

_SPI_Ethernet_UserTCP:
	LNK	#216

;EthV2_Demo.c,736 :: 		unsigned int    SPI_Ethernet_UserTCP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthPktFlags *flags)
	PUSH	W10
	PUSH	W11
	PUSH	W12
; flags start address is: 0 (W0)
	MOV	[W14-8], W0
; flags end address is: 0 (W0)
	MOV	W13, [W14+206]
;EthV2_Demo.c,741 :: 		unsigned int    len = 0;
	MOV	#0, W0
	MOV	W0, [W14+204]
;EthV2_Demo.c,750 :: 		if(localPort != 80)                     // I listen only to web request on port 80
	MOV	#80, W0
	CP	W12, W0
	BRA NZ	L__SPI_Ethernet_UserTCP177
	GOTO	L_SPI_Ethernet_UserTCP54
L__SPI_Ethernet_UserTCP177:
;EthV2_Demo.c,752 :: 		return(0);                     // return without reply
	CLR	W0
	GOTO	L_end_SPI_Ethernet_UserTCP
;EthV2_Demo.c,753 :: 		}
L_SPI_Ethernet_UserTCP54:
;EthV2_Demo.c,758 :: 		SPI_Set_Active(SPI1_Read, SPI1_Write);
	PUSH	W10
	MOV	#lo_addr(_SPI1_Write), W11
	MOV	#lo_addr(_SPI1_Read), W10
	CALL	_SPI_Set_Active
;EthV2_Demo.c,759 :: 		if(HTTP_getRequest(getRequest, &reqLength, HTTP_REQUEST_SIZE) == 0)
	MOV	#206, W1
	ADD	W14, W1, W1
	MOV	#72, W0
	ADD	W14, W0, W0
	MOV	#128, W12
	MOV	W1, W11
	MOV	W0, W10
	CALL	_HTTP_getRequest
	POP	W10
	CP.B	W0, #0
	BRA Z	L__SPI_Ethernet_UserTCP178
	GOTO	L_SPI_Ethernet_UserTCP55
L__SPI_Ethernet_UserTCP178:
;EthV2_Demo.c,761 :: 		return(0);                     // no reply if no GET request
	CLR	W0
	GOTO	L_end_SPI_Ethernet_UserTCP
;EthV2_Demo.c,762 :: 		}
L_SPI_Ethernet_UserTCP55:
;EthV2_Demo.c,767 :: 		SPI_Set_Active(SPI1_Read, SPI1_Write);
	PUSH	W10
	MOV	#lo_addr(_SPI1_Write), W11
	MOV	#lo_addr(_SPI1_Read), W10
	CALL	_SPI_Set_Active
;EthV2_Demo.c,768 :: 		admin = HTTP_basicRealm(reqLength, PRIVATE_LOGINPASSWD); // admin is set if login+password matches, cleared otherwise
	MOV	#lo_addr(?lstr58_EthV2_Demo), W11
	MOV	[W14+206], W10
	CALL	_HTTP_basicRealm
; admin start address is: 4 (W2)
	MOV.B	W0, W2
;EthV2_Demo.c,770 :: 		if(memcmp(getRequest, path_private, sizeof(path_private) - 1) == 0)   // is path under private section ?
	MOV	#72, W0
	ADD	W14, W0, W0
	MOV	#6, W12
	MOV	#lo_addr(_path_private), W11
	MOV	W0, W10
	CALL	_memcmp
	POP	W10
	CP	W0, #0
	BRA Z	L__SPI_Ethernet_UserTCP179
	GOTO	L_SPI_Ethernet_UserTCP56
L__SPI_Ethernet_UserTCP179:
;EthV2_Demo.c,778 :: 		if(admin == 0)
	CP.B	W2, #0
	BRA Z	L__SPI_Ethernet_UserTCP180
	GOTO	L_SPI_Ethernet_UserTCP57
L__SPI_Ethernet_UserTCP180:
; admin end address is: 4 (W2)
;EthV2_Demo.c,780 :: 		SPI_Set_Active(SPI1_Read, SPI1_Write);
	MOV	#lo_addr(_SPI1_Write), W11
	MOV	#lo_addr(_SPI1_Read), W10
	CALL	_SPI_Set_Active
;EthV2_Demo.c,782 :: 		len = HTTP_accessDenied(ZONE_NAME, MSG_DENIED);
	MOV	#lo_addr(?lstr_60_EthV2_Demo), W11
	MOV	#lo_addr(?lstr_59_EthV2_Demo), W10
	CALL	_HTTP_accessDenied
	MOV	W0, [W14+204]
;EthV2_Demo.c,783 :: 		}
	GOTO	L_SPI_Ethernet_UserTCP58
L_SPI_Ethernet_UserTCP57:
;EthV2_Demo.c,787 :: 		if(getRequest[sizeof(path_private)] == 's')
	MOV	#72, W0
	ADD	W14, W0, W0
	ADD	W0, #7, W0
	MOV.B	[W0], W1
	MOV.B	#115, W0
	CP.B	W1, W0
	BRA Z	L__SPI_Ethernet_UserTCP181
	GOTO	L_SPI_Ethernet_UserTCP59
L__SPI_Ethernet_UserTCP181:
;EthV2_Demo.c,790 :: 		len = putConstString(httpHeader);              // HTTP header
	MOV	#lo_addr(_httpHeader), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	W0, [W14+204]
;EthV2_Demo.c,791 :: 		len += putConstString(httpMimeTypeScript);     // with script MIME type
	MOV	#lo_addr(_httpMimeTypeScript), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,794 :: 		len += putConstString("var LCD1=\"");
	MOV	#lo_addr(?lstr_61_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,795 :: 		len += mkLCDselect(1, conf.lcdL1);
	MOV	#lo_addr(_conf), W0
	MOV.B	[W0], W11
	MOV.B	#1, W10
	CALL	_mkLCDselect
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,798 :: 		len += putConstString("var LCD2=\"");
	MOV	#lo_addr(?lstr_62_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,799 :: 		len += mkLCDselect(2, conf.lcdL2);
	MOV	#lo_addr(_conf+1), W0
	MOV.B	[W0], W11
	MOV.B	#2, W10
	CALL	_mkLCDselect
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,802 :: 		len += putConstString("var SERVER=\"");
	MOV	#lo_addr(?lstr_63_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,803 :: 		len += putConstString("<input onChange=\\\"document.location.href = '/admin/n/' + this.value\\\" value=\\\"");
	MOV	#lo_addr(?lstr_64_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,804 :: 		len += putString(conf.sntpServer);
	MOV	#lo_addr(_conf+7), W10
	CALL	_SPI_Ethernet_putString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,805 :: 		len += putConstString("\\\">\";");
	MOV	#lo_addr(?lstr_65_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,808 :: 		len += putConstString("var TZ=\"");
	MOV	#lo_addr(?lstr_66_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,809 :: 		len += putConstString("<select onChange=\\\"document.location.href = '/admin/t/' + this.selectedIndex\\\">");
	MOV	#lo_addr(?lstr_67_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,810 :: 		for(i = -11; i < 12; i++)
	MOV	#65525, W0
	MOV	W0, [W14+202]
L_SPI_Ethernet_UserTCP60:
	MOV	[W14+202], W0
	CP	W0, #12
	BRA LT	L__SPI_Ethernet_UserTCP182
	GOTO	L_SPI_Ethernet_UserTCP61
L__SPI_Ethernet_UserTCP182:
;EthV2_Demo.c,812 :: 		len += putConstString("<option ");
	PUSH.D	W12
	PUSH.D	W10
	MOV	#lo_addr(?lstr_68_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	POP.D	W10
	POP.D	W12
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,813 :: 		if(i == conf.tz)
	MOV	#lo_addr(_conf+2), W0
	SE	[W0], W1
	MOV	#202, W0
	ADD	W14, W0, W0
	CP	W1, [W0]
	BRA Z	L__SPI_Ethernet_UserTCP183
	GOTO	L_SPI_Ethernet_UserTCP63
L__SPI_Ethernet_UserTCP183:
;EthV2_Demo.c,815 :: 		len += putConstString(" selected");
	PUSH.D	W12
	PUSH.D	W10
	MOV	#lo_addr(?lstr_69_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	POP.D	W10
	POP.D	W12
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,816 :: 		}
L_SPI_Ethernet_UserTCP63:
;EthV2_Demo.c,817 :: 		len += putConstString(">");
	PUSH.D	W12
	PUSH.D	W10
	MOV	#lo_addr(?lstr_70_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,818 :: 		int2str(i, dyna);
	ADD	W14, #8, W0
	MOV	W0, W12
	MOV	[W14+202], W10
	ASR	W10, #15, W11
	CALL	_int2str
;EthV2_Demo.c,819 :: 		len += putString(dyna);
	ADD	W14, #8, W0
	MOV	W0, W10
	CALL	_SPI_Ethernet_putString
	POP.D	W10
	POP.D	W12
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,810 :: 		for(i = -11; i < 12; i++)
	MOV	[W14+202], W1
	MOV	#202, W0
	ADD	W14, W0, W0
	ADD	W1, #1, [W0]
;EthV2_Demo.c,820 :: 		}
	GOTO	L_SPI_Ethernet_UserTCP60
L_SPI_Ethernet_UserTCP61:
;EthV2_Demo.c,821 :: 		len += putConstString("</select>\";");
	PUSH.D	W12
	PUSH.D	W10
	MOV	#lo_addr(?lstr_71_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	POP.D	W10
	POP.D	W12
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,822 :: 		}
	GOTO	L_SPI_Ethernet_UserTCP64
L_SPI_Ethernet_UserTCP59:
;EthV2_Demo.c,826 :: 		switch(getRequest[sizeof(path_private)])
	MOV	#72, W0
	ADD	W14, W0, W0
	ADD	W0, #7, W0
	MOV	W0, [W14+212]
	GOTO	L_SPI_Ethernet_UserTCP65
;EthV2_Demo.c,828 :: 		case '1' :
L_SPI_Ethernet_UserTCP67:
;EthV2_Demo.c,829 :: 		SPI_Set_Active(SPI3_Read, SPI3_Write);
	MOV	#lo_addr(_SPI3_Write), W11
	MOV	#lo_addr(_SPI3_Read), W10
	CALL	_SPI_Set_Active
;EthV2_Demo.c,831 :: 		SPI_Lcd_Cmd(_LCD_CLEAR);
	MOV.B	#1, W10
	CALL	_SPI_Lcd_Cmd
;EthV2_Demo.c,832 :: 		conf.lcdL1 = getRequest[sizeof(path_private) + 2] - '0';
	MOV	#72, W0
	ADD	W14, W0, W0
	ADD	W0, #9, W0
	ZE	[W0], W1
	MOV	#48, W0
	SUB	W1, W0, W1
	MOV	#lo_addr(_conf), W0
	MOV.B	W1, [W0]
;EthV2_Demo.c,833 :: 		break;
	GOTO	L_SPI_Ethernet_UserTCP66
;EthV2_Demo.c,834 :: 		case '2':
L_SPI_Ethernet_UserTCP68:
;EthV2_Demo.c,835 :: 		SPI_Set_Active(SPI3_Read, SPI3_Write);
	MOV	#lo_addr(_SPI3_Write), W11
	MOV	#lo_addr(_SPI3_Read), W10
	CALL	_SPI_Set_Active
;EthV2_Demo.c,837 :: 		SPI_Lcd_Cmd(_LCD_CLEAR);
	MOV.B	#1, W10
	CALL	_SPI_Lcd_Cmd
;EthV2_Demo.c,838 :: 		conf.lcdL2 = getRequest[sizeof(path_private) + 2] - '0';
	MOV	#72, W0
	ADD	W14, W0, W0
	ADD	W0, #9, W0
	ZE	[W0], W1
	MOV	#48, W0
	SUB	W1, W0, W1
	MOV	#lo_addr(_conf+1), W0
	MOV.B	W1, [W0]
;EthV2_Demo.c,839 :: 		break;
	GOTO	L_SPI_Ethernet_UserTCP66
;EthV2_Demo.c,840 :: 		case 'r':
L_SPI_Ethernet_UserTCP69:
;EthV2_Demo.c,842 :: 		sntpSync = 0;
	MOV	#lo_addr(_sntpSync), W1
	CLR	W0
	MOV.B	W0, [W1]
;EthV2_Demo.c,843 :: 		if (!memcmp(conf.sntpIP, "\0\0\0\0", 4))
	MOV	#4, W12
	MOV	#lo_addr(?lstr72_EthV2_Demo), W11
	MOV	#lo_addr(_conf+3), W10
	CALL	_memcmp
	CP0	W0
	BRA Z	L__SPI_Ethernet_UserTCP184
	GOTO	L_SPI_Ethernet_UserTCP70
L__SPI_Ethernet_UserTCP184:
;EthV2_Demo.c,844 :: 		reloadDNS = 1 ; // force to solve DNS
	MOV	#lo_addr(_reloadDNS), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
L_SPI_Ethernet_UserTCP70:
;EthV2_Demo.c,845 :: 		break;
	GOTO	L_SPI_Ethernet_UserTCP66
;EthV2_Demo.c,846 :: 		case 'n':
L_SPI_Ethernet_UserTCP71:
;EthV2_Demo.c,851 :: 		src = &getRequest[sizeof(path_private) + 2];
	MOV	#72, W0
	ADD	W14, W0, W0
; src start address is: 2 (W1)
	ADD	W0, #9, W1
;EthV2_Demo.c,852 :: 		dst = conf.sntpServer;
; dst start address is: 8 (W4)
	MOV	#lo_addr(_conf+7), W4
;EthV2_Demo.c,853 :: 		for(i = 0; i < 128; i++)
; i start address is: 4 (W2)
	CLR	W2
; i end address is: 4 (W2)
; dst end address is: 8 (W4)
; src end address is: 2 (W1)
L_SPI_Ethernet_UserTCP72:
; i start address is: 4 (W2)
; dst start address is: 8 (W4)
; src start address is: 2 (W1)
	MOV.B	#128, W0
	CP.B	W2, W0
	BRA LTU	L__SPI_Ethernet_UserTCP185
	GOTO	L_SPI_Ethernet_UserTCP73
L__SPI_Ethernet_UserTCP185:
;EthV2_Demo.c,855 :: 		*dst = *src++;
	MOV.B	[W1], [W4]
; src start address is: 6 (W3)
	ADD	W1, #1, W3
; src end address is: 2 (W1)
;EthV2_Demo.c,856 :: 		if(*dst == ' ')
	MOV.B	[W4], W1
	MOV.B	#32, W0
	CP.B	W1, W0
	BRA Z	L__SPI_Ethernet_UserTCP186
	GOTO	L_SPI_Ethernet_UserTCP75
L__SPI_Ethernet_UserTCP186:
; i end address is: 4 (W2)
; src end address is: 6 (W3)
;EthV2_Demo.c,858 :: 		*dst = 0;
	CLR	W0
	MOV.B	W0, [W4]
; dst end address is: 8 (W4)
;EthV2_Demo.c,859 :: 		break;
	GOTO	L_SPI_Ethernet_UserTCP73
;EthV2_Demo.c,860 :: 		}
L_SPI_Ethernet_UserTCP75:
;EthV2_Demo.c,861 :: 		dst++;
; dst start address is: 10 (W5)
; src start address is: 6 (W3)
; dst start address is: 8 (W4)
; i start address is: 4 (W2)
	ADD	W4, #1, W5
; dst end address is: 8 (W4)
;EthV2_Demo.c,853 :: 		for(i = 0; i < 128; i++)
; i start address is: 0 (W0)
	ADD.B	W2, #1, W0
; i end address is: 4 (W2)
;EthV2_Demo.c,862 :: 		}
	MOV	W3, W1
; src end address is: 6 (W3)
; dst end address is: 10 (W5)
; i end address is: 0 (W0)
	MOV	W5, W4
	MOV.B	W0, W2
	GOTO	L_SPI_Ethernet_UserTCP72
L_SPI_Ethernet_UserTCP73:
;EthV2_Demo.c,863 :: 		reloadDNS = 1; // force to solve DNS
	MOV	#lo_addr(_reloadDNS), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;EthV2_Demo.c,865 :: 		break;
	GOTO	L_SPI_Ethernet_UserTCP66
;EthV2_Demo.c,866 :: 		case 't':
L_SPI_Ethernet_UserTCP76:
;EthV2_Demo.c,868 :: 		conf.tz = atoi(&getRequest[sizeof(path_private) + 2]);
	MOV	#72, W0
	ADD	W14, W0, W0
	ADD	W0, #9, W0
	MOV	W0, W10
	CALL	_atoi
	MOV	#lo_addr(_conf+2), W1
	MOV.B	W0, [W1]
;EthV2_Demo.c,869 :: 		conf.tz -= 11;
	SE	W0, W0
	SUB	W0, #11, W1
	MOV	#lo_addr(_conf+2), W0
	MOV.B	W1, [W0]
;EthV2_Demo.c,870 :: 		break;
	GOTO	L_SPI_Ethernet_UserTCP66
;EthV2_Demo.c,871 :: 		}
L_SPI_Ethernet_UserTCP65:
	MOV	[W14+212], W2
	MOV.B	[W2], W1
	MOV.B	#49, W0
	CP.B	W1, W0
	BRA NZ	L__SPI_Ethernet_UserTCP187
	GOTO	L_SPI_Ethernet_UserTCP67
L__SPI_Ethernet_UserTCP187:
	MOV.B	[W2], W1
	MOV.B	#50, W0
	CP.B	W1, W0
	BRA NZ	L__SPI_Ethernet_UserTCP188
	GOTO	L_SPI_Ethernet_UserTCP68
L__SPI_Ethernet_UserTCP188:
	MOV.B	[W2], W1
	MOV.B	#114, W0
	CP.B	W1, W0
	BRA NZ	L__SPI_Ethernet_UserTCP189
	GOTO	L_SPI_Ethernet_UserTCP69
L__SPI_Ethernet_UserTCP189:
	MOV.B	[W2], W1
	MOV.B	#110, W0
	CP.B	W1, W0
	BRA NZ	L__SPI_Ethernet_UserTCP190
	GOTO	L_SPI_Ethernet_UserTCP71
L__SPI_Ethernet_UserTCP190:
	MOV.B	[W2], W1
	MOV.B	#116, W0
	CP.B	W1, W0
	BRA NZ	L__SPI_Ethernet_UserTCP191
	GOTO	L_SPI_Ethernet_UserTCP76
L__SPI_Ethernet_UserTCP191:
L_SPI_Ethernet_UserTCP66:
;EthV2_Demo.c,874 :: 		len += putConstString(HTMLheader);
	MOV	_HTMLheader, W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,875 :: 		len += putConstString(HTMLadmin);
	MOV	_HTMLadmin, W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,876 :: 		len += putConstString(HTMLfooter);
	MOV	_HTMLfooter, W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,877 :: 		}
L_SPI_Ethernet_UserTCP64:
;EthV2_Demo.c,878 :: 		}
L_SPI_Ethernet_UserTCP58:
;EthV2_Demo.c,879 :: 		}
	GOTO	L_SPI_Ethernet_UserTCP77
L_SPI_Ethernet_UserTCP56:
;EthV2_Demo.c,880 :: 		else switch(getRequest[1])
	MOV	#72, W0
	ADD	W14, W0, W0
	INC	W0
	MOV	W0, [W14+214]
	GOTO	L_SPI_Ethernet_UserTCP78
;EthV2_Demo.c,883 :: 		case 's':
L_SPI_Ethernet_UserTCP80:
;EthV2_Demo.c,885 :: 		if(lastSync == 0)
	MOV	_lastSync, W0
	MOV	_lastSync+2, W1
	CP	W0, #0
	CPB	W1, #0
	BRA Z	L__SPI_Ethernet_UserTCP192
	GOTO	L_SPI_Ethernet_UserTCP81
L__SPI_Ethernet_UserTCP192:
;EthV2_Demo.c,887 :: 		len = putConstString(CSSred);          // not sync
	MOV	_CSSred, W10
	CALL	_SPI_Ethernet_putConstString
	MOV	W0, [W14+204]
;EthV2_Demo.c,888 :: 		}
	GOTO	L_SPI_Ethernet_UserTCP82
L_SPI_Ethernet_UserTCP81:
;EthV2_Demo.c,891 :: 		len = putConstString(CSSgreen);        // sync
	MOV	_CSSgreen, W10
	CALL	_SPI_Ethernet_putConstString
	MOV	W0, [W14+204]
;EthV2_Demo.c,892 :: 		}
L_SPI_Ethernet_UserTCP82:
;EthV2_Demo.c,893 :: 		break;
	GOTO	L_SPI_Ethernet_UserTCP79
;EthV2_Demo.c,894 :: 		case 'a':
L_SPI_Ethernet_UserTCP83:
;EthV2_Demo.c,896 :: 		len = putConstString(httpHeader);
	MOV	#lo_addr(_httpHeader), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	W0, [W14+204]
;EthV2_Demo.c,897 :: 		len += putConstString(httpMimeTypeScript);
	MOV	#lo_addr(_httpMimeTypeScript), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,900 :: 		ts2str(dyna, &ts, TS2STR_ALL | TS2STR_TZ);
	ADD	W14, #8, W0
	MOV.B	#7, W12
	MOV	#lo_addr(_ts), W11
	MOV	W0, W10
	CALL	_ts2str
;EthV2_Demo.c,901 :: 		len += putConstString("var NOW=\"");
	MOV	#lo_addr(?lstr_73_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,902 :: 		len += putString(dyna);
	ADD	W14, #8, W0
	MOV	W0, W10
	CALL	_SPI_Ethernet_putString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,903 :: 		len += putConstString("\";");
	MOV	#lo_addr(?lstr_74_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,906 :: 		int2str(epoch, dyna);
	ADD	W14, #8, W0
	MOV	W0, W12
	MOV	_epoch, W10
	MOV	_epoch+2, W11
	CALL	_int2str
;EthV2_Demo.c,907 :: 		len += putConstString("var EPOCH=");
	MOV	#lo_addr(?lstr_75_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,908 :: 		len += putString(dyna);
	ADD	W14, #8, W0
	MOV	W0, W10
	CALL	_SPI_Ethernet_putString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,909 :: 		len += putConstString(";");
	MOV	#lo_addr(?lstr_76_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,912 :: 		if(lastSync == 0)
	MOV	_lastSync, W0
	MOV	_lastSync+2, W1
	CP	W0, #0
	CPB	W1, #0
	BRA Z	L__SPI_Ethernet_UserTCP193
	GOTO	L_SPI_Ethernet_UserTCP84
L__SPI_Ethernet_UserTCP193:
;EthV2_Demo.c,914 :: 		strcpy(dyna, "???");
	ADD	W14, #8, W0
	MOV	#lo_addr(?lstr77_EthV2_Demo), W11
	MOV	W0, W10
	CALL	_strcpy
;EthV2_Demo.c,915 :: 		}
	GOTO	L_SPI_Ethernet_UserTCP85
L_SPI_Ethernet_UserTCP84:
;EthV2_Demo.c,918 :: 		Time_epochToDate(lastSync + conf.tz * 3600, &ls);
	MOV	#lo_addr(_conf+2), W0
	SE	[W0], W1
	MOV	#3600, W0
	MUL.SS	W1, W0, W0
	MOV	W0, W4
	ASR	W4, #15, W5
	MOV	#lo_addr(_lastSync), W2
	ADD	W4, [W2++], W0
	ADDC	W5, [W2--], W1
	MOV	#lo_addr(_ls), W12
	MOV.D	W0, W10
	CALL	_Time_epochToDate
;EthV2_Demo.c,919 :: 		ts2str(dyna, &ls, TS2STR_ALL | TS2STR_TZ);
	ADD	W14, #8, W0
	MOV.B	#7, W12
	MOV	#lo_addr(_ls), W11
	MOV	W0, W10
	CALL	_ts2str
;EthV2_Demo.c,920 :: 		}
L_SPI_Ethernet_UserTCP85:
;EthV2_Demo.c,921 :: 		len += putConstString("var LAST=\"");
	MOV	#lo_addr(?lstr_78_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,922 :: 		len += putString(dyna);
	ADD	W14, #8, W0
	MOV	W0, W10
	CALL	_SPI_Ethernet_putString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,923 :: 		len += putConstString("\";");
	MOV	#lo_addr(?lstr_79_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,925 :: 		break;
	GOTO	L_SPI_Ethernet_UserTCP79
;EthV2_Demo.c,927 :: 		case 'b':
L_SPI_Ethernet_UserTCP86:
;EthV2_Demo.c,929 :: 		len = putConstString(httpHeader);
	MOV	#lo_addr(_httpHeader), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	W0, [W14+204]
;EthV2_Demo.c,930 :: 		len += putConstString(httpMimeTypeScript);
	MOV	#lo_addr(_httpMimeTypeScript), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,933 :: 		ip2str(dyna, conf.sntpIP);
	ADD	W14, #8, W0
	MOV	#lo_addr(_conf+3), W11
	MOV	W0, W10
	CALL	_ip2str
;EthV2_Demo.c,934 :: 		len += putConstString("var SNTP=\"");
	MOV	#lo_addr(?lstr_80_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,935 :: 		len += putString(conf.sntpServer);
	MOV	#lo_addr(_conf+7), W10
	CALL	_SPI_Ethernet_putString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,936 :: 		len += putConstString(" (");
	MOV	#lo_addr(?lstr_81_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,937 :: 		len += putString(dyna);
	ADD	W14, #8, W0
	MOV	W0, W10
	CALL	_SPI_Ethernet_putString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,938 :: 		len += putConstString(")");
	MOV	#lo_addr(?lstr_82_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,939 :: 		len += putConstString("\";");
	MOV	#lo_addr(?lstr_83_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,942 :: 		if(serverStratum == 0)
	MOV	#lo_addr(_serverStratum), W0
	MOV.B	[W0], W0
	CP.B	W0, #0
	BRA Z	L__SPI_Ethernet_UserTCP194
	GOTO	L_SPI_Ethernet_UserTCP87
L__SPI_Ethernet_UserTCP194:
;EthV2_Demo.c,944 :: 		strcpy(dyna, "Unspecified");
	ADD	W14, #8, W0
	MOV	#lo_addr(?lstr84_EthV2_Demo), W11
	MOV	W0, W10
	CALL	_strcpy
;EthV2_Demo.c,945 :: 		}
	GOTO	L_SPI_Ethernet_UserTCP88
L_SPI_Ethernet_UserTCP87:
;EthV2_Demo.c,946 :: 		else if(serverStratum == 1)
	MOV	#lo_addr(_serverStratum), W0
	MOV.B	[W0], W0
	CP.B	W0, #1
	BRA Z	L__SPI_Ethernet_UserTCP195
	GOTO	L_SPI_Ethernet_UserTCP89
L__SPI_Ethernet_UserTCP195:
;EthV2_Demo.c,948 :: 		strcpy(dyna, "1 (primary)");
	ADD	W14, #8, W0
	MOV	#lo_addr(?lstr85_EthV2_Demo), W11
	MOV	W0, W10
	CALL	_strcpy
;EthV2_Demo.c,949 :: 		}
	GOTO	L_SPI_Ethernet_UserTCP90
L_SPI_Ethernet_UserTCP89:
;EthV2_Demo.c,950 :: 		else if(serverStratum < 16)
	MOV	#lo_addr(_serverStratum), W0
	MOV.B	[W0], W0
	CP.B	W0, #16
	BRA LTU	L__SPI_Ethernet_UserTCP196
	GOTO	L_SPI_Ethernet_UserTCP91
L__SPI_Ethernet_UserTCP196:
;EthV2_Demo.c,952 :: 		int2str(serverStratum, dyna);
	ADD	W14, #8, W1
	MOV	#lo_addr(_serverStratum), W0
	MOV	W1, W12
	ZE	[W0], W10
	CLR	W11
	CALL	_int2str
;EthV2_Demo.c,953 :: 		strcat(dyna, "(secondary)");
	ADD	W14, #8, W0
	MOV	#lo_addr(?lstr86_EthV2_Demo), W11
	MOV	W0, W10
	CALL	_strcat
;EthV2_Demo.c,954 :: 		}
	GOTO	L_SPI_Ethernet_UserTCP92
L_SPI_Ethernet_UserTCP91:
;EthV2_Demo.c,957 :: 		int2str(serverStratum, dyna);
	ADD	W14, #8, W1
	MOV	#lo_addr(_serverStratum), W0
	MOV	W1, W12
	ZE	[W0], W10
	CLR	W11
	CALL	_int2str
;EthV2_Demo.c,958 :: 		strcat(dyna, " (reserved)");
	ADD	W14, #8, W0
	MOV	#lo_addr(?lstr87_EthV2_Demo), W11
	MOV	W0, W10
	CALL	_strcat
;EthV2_Demo.c,959 :: 		}
L_SPI_Ethernet_UserTCP92:
L_SPI_Ethernet_UserTCP90:
L_SPI_Ethernet_UserTCP88:
;EthV2_Demo.c,960 :: 		len += putConstString("var STRATUM=\"");
	MOV	#lo_addr(?lstr_88_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,961 :: 		len += putString(dyna);
	ADD	W14, #8, W0
	MOV	W0, W10
	CALL	_SPI_Ethernet_putString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,962 :: 		len += putConstString("\";");
	MOV	#lo_addr(?lstr_89_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,965 :: 		switch(serverFlags & 0b11000000)
	MOV	#lo_addr(_serverFlags), W0
	ZE	[W0], W1
	MOV	#192, W0
	AND	W1, W0, W0
	MOV	W0, [W14+212]
	GOTO	L_SPI_Ethernet_UserTCP93
;EthV2_Demo.c,967 :: 		case 0b00000000: strcpy(dyna, "No warning"); break;
L_SPI_Ethernet_UserTCP95:
	ADD	W14, #8, W0
	MOV	#lo_addr(?lstr90_EthV2_Demo), W11
	MOV	W0, W10
	CALL	_strcpy
	GOTO	L_SPI_Ethernet_UserTCP94
;EthV2_Demo.c,968 :: 		case 0b01000000: strcpy(dyna, "Last minute has 61 seconds"); break;
L_SPI_Ethernet_UserTCP96:
	ADD	W14, #8, W0
	MOV	#lo_addr(?lstr91_EthV2_Demo), W11
	MOV	W0, W10
	CALL	_strcpy
	GOTO	L_SPI_Ethernet_UserTCP94
;EthV2_Demo.c,969 :: 		case 0b10000000: strcpy(dyna, "Last minute has 59 seconds"); break;
L_SPI_Ethernet_UserTCP97:
	ADD	W14, #8, W0
	MOV	#lo_addr(?lstr92_EthV2_Demo), W11
	MOV	W0, W10
	CALL	_strcpy
	GOTO	L_SPI_Ethernet_UserTCP94
;EthV2_Demo.c,970 :: 		case 0b11000000: strcpy(dyna, "SNTP server not synchronized"); break;
L_SPI_Ethernet_UserTCP98:
	ADD	W14, #8, W0
	MOV	#lo_addr(?lstr93_EthV2_Demo), W11
	MOV	W0, W10
	CALL	_strcpy
	GOTO	L_SPI_Ethernet_UserTCP94
;EthV2_Demo.c,971 :: 		}
L_SPI_Ethernet_UserTCP93:
	MOV	[W14+212], W1
	CP	W1, #0
	BRA NZ	L__SPI_Ethernet_UserTCP197
	GOTO	L_SPI_Ethernet_UserTCP95
L__SPI_Ethernet_UserTCP197:
	MOV	#64, W0
	CP	W1, W0
	BRA NZ	L__SPI_Ethernet_UserTCP198
	GOTO	L_SPI_Ethernet_UserTCP96
L__SPI_Ethernet_UserTCP198:
	MOV	#128, W0
	CP	W1, W0
	BRA NZ	L__SPI_Ethernet_UserTCP199
	GOTO	L_SPI_Ethernet_UserTCP97
L__SPI_Ethernet_UserTCP199:
	MOV	#192, W0
	CP	W1, W0
	BRA NZ	L__SPI_Ethernet_UserTCP200
	GOTO	L_SPI_Ethernet_UserTCP98
L__SPI_Ethernet_UserTCP200:
L_SPI_Ethernet_UserTCP94:
;EthV2_Demo.c,972 :: 		len += putConstString("var LEAP=\"");
	MOV	#lo_addr(?lstr_94_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,973 :: 		len += putString(dyna);
	ADD	W14, #8, W0
	MOV	W0, W10
	CALL	_SPI_Ethernet_putString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,974 :: 		len += putConstString("\";");
	MOV	#lo_addr(?lstr_95_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,976 :: 		int2str(serverPrecision, dyna);
	ADD	W14, #8, W1
	MOV	#lo_addr(_serverPrecision), W0
	MOV	W1, W12
	ZE	[W0], W10
	CLR	W11
	CALL	_int2str
;EthV2_Demo.c,977 :: 		len += putConstString("var PRECISION=\"");
	MOV	#lo_addr(?lstr_96_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,978 :: 		len += putString(dyna);
	ADD	W14, #8, W0
	MOV	W0, W10
	CALL	_SPI_Ethernet_putString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,979 :: 		len += putConstString("\";");
	MOV	#lo_addr(?lstr_97_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,981 :: 		switch(serverFlags & 0b00111000)
	MOV	#lo_addr(_serverFlags), W0
	ZE	[W0], W1
	MOV	#56, W0
	AND	W1, W0, W0
	MOV	W0, [W14+212]
	GOTO	L_SPI_Ethernet_UserTCP99
;EthV2_Demo.c,983 :: 		case 0b00011000: strcpy(dyna, "IPv4 only"); break;
L_SPI_Ethernet_UserTCP101:
	ADD	W14, #8, W0
	MOV	#lo_addr(?lstr98_EthV2_Demo), W11
	MOV	W0, W10
	CALL	_strcpy
	GOTO	L_SPI_Ethernet_UserTCP100
;EthV2_Demo.c,984 :: 		case 0b00110000: strcpy(dyna, "IPv4, IPv6 and OSI"); break;
L_SPI_Ethernet_UserTCP102:
	ADD	W14, #8, W0
	MOV	#lo_addr(?lstr99_EthV2_Demo), W11
	MOV	W0, W10
	CALL	_strcpy
	GOTO	L_SPI_Ethernet_UserTCP100
;EthV2_Demo.c,985 :: 		default: strcpy(dyna, "Undefined"); break;
L_SPI_Ethernet_UserTCP103:
	ADD	W14, #8, W0
	MOV	#lo_addr(?lstr100_EthV2_Demo), W11
	MOV	W0, W10
	CALL	_strcpy
	GOTO	L_SPI_Ethernet_UserTCP100
;EthV2_Demo.c,986 :: 		}
L_SPI_Ethernet_UserTCP99:
	MOV	[W14+212], W1
	CP	W1, #24
	BRA NZ	L__SPI_Ethernet_UserTCP201
	GOTO	L_SPI_Ethernet_UserTCP101
L__SPI_Ethernet_UserTCP201:
	MOV	#48, W0
	CP	W1, W0
	BRA NZ	L__SPI_Ethernet_UserTCP202
	GOTO	L_SPI_Ethernet_UserTCP102
L__SPI_Ethernet_UserTCP202:
	GOTO	L_SPI_Ethernet_UserTCP103
L_SPI_Ethernet_UserTCP100:
;EthV2_Demo.c,987 :: 		len += putConstString("var VN=\"");
	MOV	#lo_addr(?lstr_101_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,988 :: 		len += putString(dyna);
	ADD	W14, #8, W0
	MOV	W0, W10
	CALL	_SPI_Ethernet_putString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,989 :: 		len += putConstString("\";");
	MOV	#lo_addr(?lstr_102_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,991 :: 		switch(serverFlags & 0b00000111)
	MOV	#lo_addr(_serverFlags), W0
	ZE	[W0], W0
	AND	W0, #7, W0
	MOV	W0, [W14+212]
	GOTO	L_SPI_Ethernet_UserTCP104
;EthV2_Demo.c,993 :: 		case 0b00000000: strcpy(dyna, "Reserved"); break;
L_SPI_Ethernet_UserTCP106:
	ADD	W14, #8, W0
	MOV	#lo_addr(?lstr103_EthV2_Demo), W11
	MOV	W0, W10
	CALL	_strcpy
	GOTO	L_SPI_Ethernet_UserTCP105
;EthV2_Demo.c,994 :: 		case 0b00000001: strcpy(dyna, "Symmetric active"); break;
L_SPI_Ethernet_UserTCP107:
	ADD	W14, #8, W0
	MOV	#lo_addr(?lstr104_EthV2_Demo), W11
	MOV	W0, W10
	CALL	_strcpy
	GOTO	L_SPI_Ethernet_UserTCP105
;EthV2_Demo.c,995 :: 		case 0b00000010: strcpy(dyna, "Symmetric passive"); break;
L_SPI_Ethernet_UserTCP108:
	ADD	W14, #8, W0
	MOV	#lo_addr(?lstr105_EthV2_Demo), W11
	MOV	W0, W10
	CALL	_strcpy
	GOTO	L_SPI_Ethernet_UserTCP105
;EthV2_Demo.c,996 :: 		case 0b00000011: strcpy(dyna, "Client"); break;
L_SPI_Ethernet_UserTCP109:
	ADD	W14, #8, W0
	MOV	#lo_addr(?lstr106_EthV2_Demo), W11
	MOV	W0, W10
	CALL	_strcpy
	GOTO	L_SPI_Ethernet_UserTCP105
;EthV2_Demo.c,997 :: 		case 0b00000100: strcpy(dyna, "Server"); break;
L_SPI_Ethernet_UserTCP110:
	ADD	W14, #8, W0
	MOV	#lo_addr(?lstr107_EthV2_Demo), W11
	MOV	W0, W10
	CALL	_strcpy
	GOTO	L_SPI_Ethernet_UserTCP105
;EthV2_Demo.c,998 :: 		case 0b00000101: strcpy(dyna, "Broadcast"); break;
L_SPI_Ethernet_UserTCP111:
	ADD	W14, #8, W0
	MOV	#lo_addr(?lstr108_EthV2_Demo), W11
	MOV	W0, W10
	CALL	_strcpy
	GOTO	L_SPI_Ethernet_UserTCP105
;EthV2_Demo.c,999 :: 		case 0b00000110: strcpy(dyna, "Reserved for NTP control message"); break;
L_SPI_Ethernet_UserTCP112:
	ADD	W14, #8, W0
	MOV	#lo_addr(?lstr109_EthV2_Demo), W11
	MOV	W0, W10
	CALL	_strcpy
	GOTO	L_SPI_Ethernet_UserTCP105
;EthV2_Demo.c,1000 :: 		case 0b00000111: strcpy(dyna, "Reserved for private use"); break;
L_SPI_Ethernet_UserTCP113:
	ADD	W14, #8, W0
	MOV	#lo_addr(?lstr110_EthV2_Demo), W11
	MOV	W0, W10
	CALL	_strcpy
	GOTO	L_SPI_Ethernet_UserTCP105
;EthV2_Demo.c,1001 :: 		}
L_SPI_Ethernet_UserTCP104:
	MOV	[W14+212], W0
	CP	W0, #0
	BRA NZ	L__SPI_Ethernet_UserTCP203
	GOTO	L_SPI_Ethernet_UserTCP106
L__SPI_Ethernet_UserTCP203:
	CP	W0, #1
	BRA NZ	L__SPI_Ethernet_UserTCP204
	GOTO	L_SPI_Ethernet_UserTCP107
L__SPI_Ethernet_UserTCP204:
	CP	W0, #2
	BRA NZ	L__SPI_Ethernet_UserTCP205
	GOTO	L_SPI_Ethernet_UserTCP108
L__SPI_Ethernet_UserTCP205:
	CP	W0, #3
	BRA NZ	L__SPI_Ethernet_UserTCP206
	GOTO	L_SPI_Ethernet_UserTCP109
L__SPI_Ethernet_UserTCP206:
	CP	W0, #4
	BRA NZ	L__SPI_Ethernet_UserTCP207
	GOTO	L_SPI_Ethernet_UserTCP110
L__SPI_Ethernet_UserTCP207:
	CP	W0, #5
	BRA NZ	L__SPI_Ethernet_UserTCP208
	GOTO	L_SPI_Ethernet_UserTCP111
L__SPI_Ethernet_UserTCP208:
	CP	W0, #6
	BRA NZ	L__SPI_Ethernet_UserTCP209
	GOTO	L_SPI_Ethernet_UserTCP112
L__SPI_Ethernet_UserTCP209:
	CP	W0, #7
	BRA NZ	L__SPI_Ethernet_UserTCP210
	GOTO	L_SPI_Ethernet_UserTCP113
L__SPI_Ethernet_UserTCP210:
L_SPI_Ethernet_UserTCP105:
;EthV2_Demo.c,1002 :: 		len += putConstString("var MODE=\"");
	MOV	#lo_addr(?lstr_111_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,1003 :: 		len += putString(dyna);
	ADD	W14, #8, W0
	MOV	W0, W10
	CALL	_SPI_Ethernet_putString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,1004 :: 		len += putConstString("\";");
	MOV	#lo_addr(?lstr_112_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,1006 :: 		break;
	GOTO	L_SPI_Ethernet_UserTCP79
;EthV2_Demo.c,1008 :: 		case 'c':
L_SPI_Ethernet_UserTCP114:
;EthV2_Demo.c,1010 :: 		len = putConstString(httpHeader);              // HTTP header
	PUSH	W10
	MOV	#lo_addr(_httpHeader), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	W0, [W14+204]
;EthV2_Demo.c,1011 :: 		len += putConstString(httpMimeTypeScript);     // with text MIME type
	MOV	#lo_addr(_httpMimeTypeScript), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,1014 :: 		ip2str(dyna, ipAddr);
	ADD	W14, #8, W0
	MOV	#lo_addr(_ipAddr), W11
	MOV	W0, W10
	CALL	_ip2str
;EthV2_Demo.c,1015 :: 		len += putConstString("var IP=\"");
	MOV	#lo_addr(?lstr_113_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,1016 :: 		len += putString(dyna);
	ADD	W14, #8, W0
	MOV	W0, W10
	CALL	_SPI_Ethernet_putString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,1017 :: 		len += putConstString("\";");
	MOV	#lo_addr(?lstr_114_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,1019 :: 		byte2hex(dyna, macAddr[0]);
	ADD	W14, #8, W1
	MOV	#lo_addr(_macAddr), W0
	MOV.B	[W0], W11
	MOV	W1, W10
	CALL	_byte2hex
;EthV2_Demo.c,1020 :: 		byte2hex(dyna + 3, macAddr[1]);
	ADD	W14, #8, W0
	ADD	W0, #3, W1
	MOV	#lo_addr(_macAddr+1), W0
	MOV.B	[W0], W11
	MOV	W1, W10
	CALL	_byte2hex
;EthV2_Demo.c,1021 :: 		byte2hex(dyna + 6, macAddr[2]);
	ADD	W14, #8, W0
	ADD	W0, #6, W1
	MOV	#lo_addr(_macAddr+2), W0
	MOV.B	[W0], W11
	MOV	W1, W10
	CALL	_byte2hex
;EthV2_Demo.c,1022 :: 		byte2hex(dyna + 9, macAddr[3]);
	ADD	W14, #8, W0
	ADD	W0, #9, W1
	MOV	#lo_addr(_macAddr+3), W0
	MOV.B	[W0], W11
	MOV	W1, W10
	CALL	_byte2hex
;EthV2_Demo.c,1023 :: 		byte2hex(dyna + 12, macAddr[4]);
	ADD	W14, #8, W0
	ADD	W0, #12, W1
	MOV	#lo_addr(_macAddr+4), W0
	MOV.B	[W0], W11
	MOV	W1, W10
	CALL	_byte2hex
;EthV2_Demo.c,1024 :: 		byte2hex(dyna + 15, macAddr[5]);
	ADD	W14, #8, W0
	ADD	W0, #15, W1
	MOV	#lo_addr(_macAddr+5), W0
	MOV.B	[W0], W11
	MOV	W1, W10
	CALL	_byte2hex
;EthV2_Demo.c,1025 :: 		*(dyna + 17) = 0;
	ADD	W14, #8, W0
	ADD	W0, #17, W1
	CLR	W0
	MOV.B	W0, [W1]
;EthV2_Demo.c,1026 :: 		len += putConstString("var MAC=\"");
	MOV	#lo_addr(?lstr_115_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,1027 :: 		len += putString(dyna);
	ADD	W14, #8, W0
	MOV	W0, W10
	CALL	_SPI_Ethernet_putString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,1028 :: 		len += putConstString("\";");
	MOV	#lo_addr(?lstr_116_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	POP	W10
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,1031 :: 		ip2str(dyna, remoteHost);
	ADD	W14, #8, W0
	MOV	W10, W11
	MOV	W0, W10
	CALL	_ip2str
;EthV2_Demo.c,1032 :: 		len += putConstString("var CLIENT=\"");
	MOV	#lo_addr(?lstr_117_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,1033 :: 		len += putString(dyna);
	ADD	W14, #8, W0
	MOV	W0, W10
	CALL	_SPI_Ethernet_putString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,1034 :: 		len += putConstString("\";");
	MOV	#lo_addr(?lstr_118_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,1037 :: 		ip2str(dyna, gwIpAddr);
	ADD	W14, #8, W0
	MOV	#lo_addr(_gwIpAddr), W11
	MOV	W0, W10
	CALL	_ip2str
;EthV2_Demo.c,1038 :: 		len += putConstString("var GW=\"");
	MOV	#lo_addr(?lstr_119_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,1039 :: 		len += putString(dyna);
	ADD	W14, #8, W0
	MOV	W0, W10
	CALL	_SPI_Ethernet_putString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,1040 :: 		len += putConstString("\";");
	MOV	#lo_addr(?lstr_120_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,1043 :: 		ip2str(dyna, ipMask);
	ADD	W14, #8, W0
	MOV	#lo_addr(_ipMask), W11
	MOV	W0, W10
	CALL	_ip2str
;EthV2_Demo.c,1044 :: 		len += putConstString("var MASK=\"");
	MOV	#lo_addr(?lstr_121_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,1045 :: 		len += putString(dyna);
	ADD	W14, #8, W0
	MOV	W0, W10
	CALL	_SPI_Ethernet_putString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,1046 :: 		len += putConstString("\";");
	MOV	#lo_addr(?lstr_122_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,1049 :: 		ip2str(dyna, dnsIpAddr);
	ADD	W14, #8, W0
	MOV	#lo_addr(_dnsIpAddr), W11
	MOV	W0, W10
	CALL	_ip2str
;EthV2_Demo.c,1050 :: 		len += putConstString("var DNS=\"");
	MOV	#lo_addr(?lstr_123_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,1051 :: 		len += putString(dyna);
	ADD	W14, #8, W0
	MOV	W0, W10
	CALL	_SPI_Ethernet_putString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,1052 :: 		len += putConstString("\";");
	MOV	#lo_addr(?lstr_124_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,1054 :: 		break;
	GOTO	L_SPI_Ethernet_UserTCP79
;EthV2_Demo.c,1056 :: 		case 'd':
L_SPI_Ethernet_UserTCP115:
;EthV2_Demo.c,1061 :: 		len = putConstString(httpHeader);              // HTTP header
	MOV	#lo_addr(_httpHeader), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	W0, [W14+204]
;EthV2_Demo.c,1062 :: 		len += putConstString(httpMimeTypeScript);     // with text MIME type
	MOV	#lo_addr(_httpMimeTypeScript), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,1064 :: 		len += putConstString("var SYSTEM=\"ENC28J60\";");
	MOV	#lo_addr(?lstr_125_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,1066 :: 		int2str(Clock_kHz(), dyna);
	ADD	W14, #8, W0
	MOV	W0, W12
	MOV	#14464, W10
	MOV	#1, W11
	CALL	_int2str
;EthV2_Demo.c,1067 :: 		len += putConstString("var CLK=\"");
	MOV	#lo_addr(?lstr_126_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,1068 :: 		len += putString(dyna);
	ADD	W14, #8, W0
	MOV	W0, W10
	CALL	_SPI_Ethernet_putString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,1069 :: 		len += putConstString("\";");
	MOV	#lo_addr(?lstr_127_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,1072 :: 		int2str(httpCounter, dyna);
	ADD	W14, #8, W0
	MOV	W0, W12
	MOV	_httpCounter, W10
	CLR	W11
	CALL	_int2str
;EthV2_Demo.c,1073 :: 		len += putConstString("var REQ=");
	MOV	#lo_addr(?lstr_128_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,1074 :: 		len += putString(dyna);
	ADD	W14, #8, W0
	MOV	W0, W10
	CALL	_SPI_Ethernet_putString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,1075 :: 		len += putConstString(";");
	MOV	#lo_addr(?lstr_129_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,1077 :: 		SPI_Set_Active(SPI1_Read, SPI1_Write);
	MOV	#lo_addr(_SPI1_Write), W11
	MOV	#lo_addr(_SPI1_Read), W10
	CALL	_SPI_Set_Active
;EthV2_Demo.c,1078 :: 		Time_epochToDate(epoch - SPI_Ethernet_UserTimerSec + conf.tz * 3600, &t);
	ADD	W14, #0, W5
	MOV	_epoch, W1
	MOV	_epoch+2, W2
	MOV	#lo_addr(_SPI_Ethernet_UserTimerSec), W0
	SUB	W1, [W0++], W3
	SUBB	W2, [W0--], W4
	MOV	#lo_addr(_conf+2), W0
	SE	[W0], W1
	MOV	#3600, W0
	MUL.SS	W1, W0, W0
	ASR	W0, #15, W1
	ADD	W3, W0, W0
	ADDC	W4, W1, W1
	MOV	W5, W12
	MOV.D	W0, W10
	CALL	_Time_epochToDate
;EthV2_Demo.c,1079 :: 		ts2str(dyna, &t, TS2STR_ALL | TS2STR_TZ);
	ADD	W14, #0, W1
	ADD	W14, #8, W0
	MOV.B	#7, W12
	MOV	W1, W11
	MOV	W0, W10
	CALL	_ts2str
;EthV2_Demo.c,1080 :: 		len += putConstString("var UP=\"");
	MOV	#lo_addr(?lstr_130_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,1081 :: 		len += putString(dyna);
	ADD	W14, #8, W0
	MOV	W0, W10
	CALL	_SPI_Ethernet_putString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,1082 :: 		len += putConstString("\";");
	MOV	#lo_addr(?lstr_131_EthV2_Demo), W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,1085 :: 		break;
	GOTO	L_SPI_Ethernet_UserTCP79
;EthV2_Demo.c,1088 :: 		case '4':
L_SPI_Ethernet_UserTCP116:
;EthV2_Demo.c,1090 :: 		len += putConstString(HTMLheader);
	MOV	_HTMLheader, W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,1091 :: 		len += putConstString(HTMLsystem);
	MOV	_HTMLsystem, W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,1092 :: 		len += putConstString(HTMLfooter);
	MOV	_HTMLfooter, W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,1093 :: 		break;
	GOTO	L_SPI_Ethernet_UserTCP79
;EthV2_Demo.c,1095 :: 		case '3':
L_SPI_Ethernet_UserTCP117:
;EthV2_Demo.c,1097 :: 		len += putConstString(HTMLheader);
	MOV	_HTMLheader, W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,1098 :: 		len += putConstString(HTMLnetwork);
	MOV	_HTMLnetwork, W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,1099 :: 		len += putConstString(HTMLfooter);
	MOV	_HTMLfooter, W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,1100 :: 		break;
	GOTO	L_SPI_Ethernet_UserTCP79
;EthV2_Demo.c,1102 :: 		case '2':
L_SPI_Ethernet_UserTCP118:
;EthV2_Demo.c,1104 :: 		len += putConstString(HTMLheader);
	MOV	_HTMLheader, W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,1105 :: 		len += putConstString(HTMLsntp);
	MOV	_HTMLsntp, W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,1106 :: 		len += putConstString(HTMLfooter);
	MOV	_HTMLfooter, W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,1107 :: 		break;
	GOTO	L_SPI_Ethernet_UserTCP79
;EthV2_Demo.c,1109 :: 		case '1':
L_SPI_Ethernet_UserTCP119:
;EthV2_Demo.c,1110 :: 		default:
L_SPI_Ethernet_UserTCP120:
;EthV2_Demo.c,1112 :: 		len += putConstString(HTMLheader);
	MOV	_HTMLheader, W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,1113 :: 		len += putConstString(HTMLtime);
	MOV	_HTMLtime, W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,1114 :: 		len += putConstString(HTMLfooter);
	MOV	_HTMLfooter, W10
	CALL	_SPI_Ethernet_putConstString
	MOV	#204, W2
	ADD	W14, W2, W2
	MOV	#204, W1
	ADD	W14, W1, W1
	ADD	W0, [W2], [W1]
;EthV2_Demo.c,1115 :: 		}
	GOTO	L_SPI_Ethernet_UserTCP79
L_SPI_Ethernet_UserTCP78:
	MOV	[W14+214], W2
	MOV.B	[W2], W1
	MOV.B	#115, W0
	CP.B	W1, W0
	BRA NZ	L__SPI_Ethernet_UserTCP211
	GOTO	L_SPI_Ethernet_UserTCP80
L__SPI_Ethernet_UserTCP211:
	MOV.B	[W2], W1
	MOV.B	#97, W0
	CP.B	W1, W0
	BRA NZ	L__SPI_Ethernet_UserTCP212
	GOTO	L_SPI_Ethernet_UserTCP83
L__SPI_Ethernet_UserTCP212:
	MOV.B	[W2], W1
	MOV.B	#98, W0
	CP.B	W1, W0
	BRA NZ	L__SPI_Ethernet_UserTCP213
	GOTO	L_SPI_Ethernet_UserTCP86
L__SPI_Ethernet_UserTCP213:
	MOV.B	[W2], W1
	MOV.B	#99, W0
	CP.B	W1, W0
	BRA NZ	L__SPI_Ethernet_UserTCP214
	GOTO	L_SPI_Ethernet_UserTCP114
L__SPI_Ethernet_UserTCP214:
	MOV.B	[W2], W1
	MOV.B	#100, W0
	CP.B	W1, W0
	BRA NZ	L__SPI_Ethernet_UserTCP215
	GOTO	L_SPI_Ethernet_UserTCP115
L__SPI_Ethernet_UserTCP215:
	MOV.B	[W2], W1
	MOV.B	#52, W0
	CP.B	W1, W0
	BRA NZ	L__SPI_Ethernet_UserTCP216
	GOTO	L_SPI_Ethernet_UserTCP116
L__SPI_Ethernet_UserTCP216:
	MOV.B	[W2], W1
	MOV.B	#51, W0
	CP.B	W1, W0
	BRA NZ	L__SPI_Ethernet_UserTCP217
	GOTO	L_SPI_Ethernet_UserTCP117
L__SPI_Ethernet_UserTCP217:
	MOV.B	[W2], W1
	MOV.B	#50, W0
	CP.B	W1, W0
	BRA NZ	L__SPI_Ethernet_UserTCP218
	GOTO	L_SPI_Ethernet_UserTCP118
L__SPI_Ethernet_UserTCP218:
	MOV.B	[W2], W1
	MOV.B	#49, W0
	CP.B	W1, W0
	BRA NZ	L__SPI_Ethernet_UserTCP219
	GOTO	L_SPI_Ethernet_UserTCP119
L__SPI_Ethernet_UserTCP219:
	GOTO	L_SPI_Ethernet_UserTCP120
L_SPI_Ethernet_UserTCP79:
L_SPI_Ethernet_UserTCP77:
;EthV2_Demo.c,1117 :: 		httpCounter++;                             // one more request done
	MOV	#1, W1
	MOV	#lo_addr(_httpCounter), W0
	ADD	W1, [W0], [W0]
;EthV2_Demo.c,1119 :: 		return(len);                               // return to the library with the number of bytes to transmit
	MOV	[W14+204], W0
;EthV2_Demo.c,1120 :: 		}
;EthV2_Demo.c,1119 :: 		return(len);                               // return to the library with the number of bytes to transmit
;EthV2_Demo.c,1120 :: 		}
L_end_SPI_Ethernet_UserTCP:
	POP	W12
	POP	W11
	POP	W10
	ULNK
	RETURN
; end of _SPI_Ethernet_UserTCP

_SPI_Ethernet_UserUDP:
	LNK	#6

;EthV2_Demo.c,1125 :: 		unsigned int    SPI_Ethernet_UserUDP(unsigned char *remoteHost, unsigned int remotePort, unsigned int destPort, unsigned int reqLength, TEthPktFlags *flags)
	PUSH	W10
	PUSH	W11
; flags start address is: 0 (W0)
	MOV	[W14-8], W0
; flags end address is: 0 (W0)
;EthV2_Demo.c,1129 :: 		if(destPort == 123)             // check SNTP port number
	MOV	#123, W0
	CP	W12, W0
	BRA Z	L__SPI_Ethernet_UserUDP221
	GOTO	L_SPI_Ethernet_UserUDP121
L__SPI_Ethernet_UserUDP221:
;EthV2_Demo.c,1133 :: 		serverFlags = SPI_Ethernet_getByte();
	CALL	_SPI_Ethernet_getByte
	MOV	#lo_addr(_serverFlags), W1
	MOV.B	W0, [W1]
;EthV2_Demo.c,1134 :: 		serverStratum = SPI_Ethernet_getByte();
	CALL	_SPI_Ethernet_getByte
	MOV	#lo_addr(_serverStratum), W1
	MOV.B	W0, [W1]
;EthV2_Demo.c,1135 :: 		SPI_Set_Active(SPI1_Read, SPI1_Write);
	MOV	#lo_addr(_SPI1_Write), W11
	MOV	#lo_addr(_SPI1_Read), W10
	CALL	_SPI_Set_Active
;EthV2_Demo.c,1136 :: 		SPI_Ethernet_getByte();        // skip poll
	CALL	_SPI_Ethernet_getByte
;EthV2_Demo.c,1137 :: 		serverPrecision = SPI_Ethernet_getByte();
	CALL	_SPI_Ethernet_getByte
	MOV	#lo_addr(_serverPrecision), W1
	MOV.B	W0, [W1]
;EthV2_Demo.c,1139 :: 		for(i = 0; i < 36; i++)
; i start address is: 2 (W1)
	CLR	W1
; i end address is: 2 (W1)
L_SPI_Ethernet_UserUDP122:
; i start address is: 2 (W1)
	MOV.B	#36, W0
	CP.B	W1, W0
	BRA LTU	L__SPI_Ethernet_UserUDP222
	GOTO	L_SPI_Ethernet_UserUDP123
L__SPI_Ethernet_UserUDP222:
;EthV2_Demo.c,1141 :: 		SPI_Set_Active(SPI1_Read, SPI1_Write);
	PUSH.D	W10
	MOV	#lo_addr(_SPI1_Write), W11
	MOV	#lo_addr(_SPI1_Read), W10
	CALL	_SPI_Set_Active
	POP.D	W10
;EthV2_Demo.c,1142 :: 		SPI_Ethernet_getByte(); // skip all unused fileds
	PUSH	W1
	PUSH.D	W12
	PUSH.D	W10
	CALL	_SPI_Ethernet_getByte
	POP.D	W10
	POP.D	W12
	POP	W1
;EthV2_Demo.c,1139 :: 		for(i = 0; i < 36; i++)
	INC.B	W1
;EthV2_Demo.c,1143 :: 		}
; i end address is: 2 (W1)
	GOTO	L_SPI_Ethernet_UserUDP122
L_SPI_Ethernet_UserUDP123:
;EthV2_Demo.c,1146 :: 		SPI_Set_Active(SPI1_Read, SPI1_Write);
	PUSH.D	W10
	MOV	#lo_addr(_SPI1_Write), W11
	MOV	#lo_addr(_SPI1_Read), W10
	CALL	_SPI_Set_Active
	POP.D	W10
;EthV2_Demo.c,1147 :: 		Highest(tts) = SPI_Ethernet_getByte();
	ADD	W14, #0, W0
	ADD	W0, #3, W0
	MOV	W0, [W14+4]
	PUSH.D	W12
	PUSH.D	W10
	CALL	_SPI_Ethernet_getByte
	POP.D	W10
	POP.D	W12
	MOV	[W14+4], W1
	MOV.B	W0, [W1]
;EthV2_Demo.c,1148 :: 		SPI_Set_Active(SPI1_Read, SPI1_Write);
	PUSH.D	W10
	MOV	#lo_addr(_SPI1_Write), W11
	MOV	#lo_addr(_SPI1_Read), W10
	CALL	_SPI_Set_Active
	POP.D	W10
;EthV2_Demo.c,1149 :: 		Higher(tts) = SPI_Ethernet_getByte();
	ADD	W14, #0, W0
	INC2	W0
	MOV	W0, [W14+4]
	PUSH.D	W12
	PUSH.D	W10
	CALL	_SPI_Ethernet_getByte
	POP.D	W10
	POP.D	W12
	MOV	[W14+4], W1
	MOV.B	W0, [W1]
;EthV2_Demo.c,1150 :: 		SPI_Set_Active(SPI1_Read, SPI1_Write);
	PUSH.D	W10
	MOV	#lo_addr(_SPI1_Write), W11
	MOV	#lo_addr(_SPI1_Read), W10
	CALL	_SPI_Set_Active
	POP.D	W10
;EthV2_Demo.c,1151 :: 		Hi(tts) = SPI_Ethernet_getByte();
	ADD	W14, #0, W0
	INC	W0
	MOV	W0, [W14+4]
	PUSH.D	W12
	PUSH.D	W10
	CALL	_SPI_Ethernet_getByte
	POP.D	W10
	POP.D	W12
	MOV	[W14+4], W1
	MOV.B	W0, [W1]
;EthV2_Demo.c,1152 :: 		SPI_Set_Active(SPI1_Read, SPI1_Write);
	PUSH.D	W10
	MOV	#lo_addr(_SPI1_Write), W11
	MOV	#lo_addr(_SPI1_Read), W10
	CALL	_SPI_Set_Active
	POP.D	W10
;EthV2_Demo.c,1153 :: 		Lo(tts) = SPI_Ethernet_getByte();
	ADD	W14, #0, W0
	MOV	W0, [W14+4]
	PUSH.D	W12
	PUSH.D	W10
	CALL	_SPI_Ethernet_getByte
	POP.D	W10
	POP.D	W12
	MOV	[W14+4], W1
	MOV.B	W0, [W1]
;EthV2_Demo.c,1156 :: 		epoch = tts - 2208988800;
	MOV	[W14+0], W2
	MOV	[W14+2], W3
	MOV	#32384, W0
	MOV	#33706, W1
	SUB	W2, W0, W0
	SUBB	W3, W1, W1
	MOV	W0, _epoch
	MOV	W1, _epoch+2
;EthV2_Demo.c,1159 :: 		lastSync = epoch;
	MOV	W0, _lastSync
	MOV	W1, _lastSync+2
;EthV2_Demo.c,1162 :: 		marquee = bufInfo;
	MOV	#lo_addr(_bufInfo), W0
	MOV	W0, _marquee
;EthV2_Demo.c,1163 :: 		SPI_Set_Active(SPI3_Read, SPI3_Write);
	PUSH.D	W10
	MOV	#lo_addr(_SPI3_Write), W11
	MOV	#lo_addr(_SPI3_Read), W10
	CALL	_SPI_Set_Active
	POP.D	W10
;EthV2_Demo.c,1164 :: 		SPI_Lcd_Cmd(_LCD_CLEAR);
	PUSH.D	W12
	PUSH.D	W10
	MOV.B	#1, W10
	CALL	_SPI_Lcd_Cmd
	POP.D	W10
	POP.D	W12
;EthV2_Demo.c,1165 :: 		}
L_SPI_Ethernet_UserUDP121:
;EthV2_Demo.c,1166 :: 		return(0);
	CLR	W0
;EthV2_Demo.c,1167 :: 		}
;EthV2_Demo.c,1166 :: 		return(0);
;EthV2_Demo.c,1167 :: 		}
L_end_SPI_Ethernet_UserUDP:
	POP	W11
	POP	W10
	ULNK
	RETURN
; end of _SPI_Ethernet_UserUDP

_Timer1Int:
	PUSH	DSWPAG
	PUSH	50
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;EthV2_Demo.c,1172 :: 		void Timer1Int() iv IVT_ADDR_T1INTERRUPT
;EthV2_Demo.c,1174 :: 		presTmr++ ;                        // increment prescaler
	PUSH	W10
	PUSH	W11
	MOV	#1, W1
	MOV	#lo_addr(_presTmr), W0
	ADD	W1, [W0], [W0]
;EthV2_Demo.c,1175 :: 		if(presTmr == 5)                   // timer1 overflows 5 times per second
	MOV	_presTmr, W0
	CP	W0, #5
	BRA Z	L__Timer1Int224
	GOTO	L_Timer1Int125
L__Timer1Int224:
;EthV2_Demo.c,1177 :: 		SPI_Set_Active(SPI1_Read, SPI1_Write);
	MOV	#lo_addr(_SPI1_Write), W11
	MOV	#lo_addr(_SPI1_Read), W10
	CALL	_SPI_Set_Active
;EthV2_Demo.c,1178 :: 		SPI_Ethernet_UserTimerSec++ ;  // increment ethernet library counter
	MOV	#1, W1
	MOV	#0, W2
	MOV	#lo_addr(_SPI_Ethernet_UserTimerSec), W0
	ADD	W1, [W0], [W0++]
	ADDC	W2, [W0], [W0--]
;EthV2_Demo.c,1179 :: 		epoch++ ;                      // epoch is RTC counter
	MOV	#1, W1
	MOV	#0, W2
	MOV	#lo_addr(_epoch), W0
	ADD	W1, [W0], [W0++]
	ADDC	W2, [W0], [W0--]
;EthV2_Demo.c,1180 :: 		presTmr = 0 ;                  // reset prescaler
	CLR	W0
	MOV	W0, _presTmr
;EthV2_Demo.c,1181 :: 		}
L_Timer1Int125:
;EthV2_Demo.c,1182 :: 		lcdEvent = 1;                      // set marquee event
	MOV	#lo_addr(_lcdEvent), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;EthV2_Demo.c,1183 :: 		T1IF_bit = 0 ;                     // clear timer0 overflow flag
	BCLR	T1IF_bit, BitPos(T1IF_bit+0)
;EthV2_Demo.c,1184 :: 		}
L_end_Timer1Int:
	POP	W11
	POP	W10
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	50
	POP	DSWPAG
	RETFIE
; end of _Timer1Int

_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 50
	MOV	#4, W0
	IOR	68

;EthV2_Demo.c,1189 :: 		void    main()
;EthV2_Demo.c,1191 :: 		PLLPRE_0_bit = 0;
	PUSH	W10
	PUSH	W11
	PUSH	W12
	BCLR	PLLPRE_0_bit, BitPos(PLLPRE_0_bit+0)
;EthV2_Demo.c,1192 :: 		PLLPRE_1_bit = 0;
	BCLR	PLLPRE_1_bit, BitPos(PLLPRE_1_bit+0)
;EthV2_Demo.c,1193 :: 		PLLPRE_2_bit = 0;
	BCLR	PLLPRE_2_bit, BitPos(PLLPRE_2_bit+0)
;EthV2_Demo.c,1194 :: 		PLLPRE_3_bit = 0;
	BCLR	PLLPRE_3_bit, BitPos(PLLPRE_3_bit+0)
;EthV2_Demo.c,1195 :: 		PLLPRE_4_bit = 0;
	BCLR	PLLPRE_4_bit, BitPos(PLLPRE_4_bit+0)
;EthV2_Demo.c,1197 :: 		PLLFBD = 38;             // PLL multiplier M=38
	MOV	#38, W0
	MOV	WREG, PLLFBD
;EthV2_Demo.c,1199 :: 		PLLPOST_0_bit = 0;
	BCLR	PLLPOST_0_bit, BitPos(PLLPOST_0_bit+0)
;EthV2_Demo.c,1200 :: 		PLLPOST_1_bit = 0;
	BCLR	PLLPOST_1_bit, BitPos(PLLPOST_1_bit+0)
;EthV2_Demo.c,1202 :: 		ANSELA = 0x00;    // Convert all I/O pins to digital
	CLR	ANSELA
;EthV2_Demo.c,1203 :: 		ANSELB = 0x00;
	CLR	ANSELB
;EthV2_Demo.c,1204 :: 		ANSELC = 0x00;
	CLR	ANSELC
;EthV2_Demo.c,1205 :: 		ANSELD = 0x00;
	CLR	ANSELD
;EthV2_Demo.c,1206 :: 		ANSELE = 0x00;
	CLR	ANSELE
;EthV2_Demo.c,1207 :: 		ANSELG = 0x00;
	CLR	ANSELG
;EthV2_Demo.c,1209 :: 		PPS_Mapping(65, _INPUT, _SDI1);
	MOV.B	#38, W12
	MOV.B	#1, W11
	MOV.B	#65, W10
	CALL	_PPS_Mapping
;EthV2_Demo.c,1210 :: 		PPS_Mapping(66, _OUTPUT, _SDO1);
	MOV.B	#5, W12
	CLR	W11
	MOV.B	#66, W10
	CALL	_PPS_Mapping
;EthV2_Demo.c,1211 :: 		PPS_Mapping(67, _OUTPUT, _SCK1OUT);
	MOV.B	#6, W12
	CLR	W11
	MOV.B	#67, W10
	CALL	_PPS_Mapping
;EthV2_Demo.c,1214 :: 		PPS_Mapping(71, _INPUT, _SDI3);
	MOV.B	#51, W12
	MOV.B	#1, W11
	MOV.B	#71, W10
	CALL	_PPS_Mapping
;EthV2_Demo.c,1215 :: 		PPS_Mapping(69, _OUTPUT, _SDO3);
	MOV.B	#31, W12
	CLR	W11
	MOV.B	#69, W10
	CALL	_PPS_Mapping
;EthV2_Demo.c,1216 :: 		PPS_Mapping(70, _OUTPUT, _SCK3OUT);
	MOV.B	#32, W12
	CLR	W11
	MOV.B	#70, W10
	CALL	_PPS_Mapping
;EthV2_Demo.c,1220 :: 		TMR1 = 0;
	CLR	TMR1
;EthV2_Demo.c,1221 :: 		PR1 = 31250;            // Set Period Register
	MOV	#31250, W0
	MOV	WREG, PR1
;EthV2_Demo.c,1222 :: 		IPC0 = IPC0 | 0x1000;   // Interrupt priority level = 1
	MOV	#4096, W1
	MOV	#lo_addr(IPC0), W0
	IOR	W1, [W0], [W0]
;EthV2_Demo.c,1223 :: 		T1CON = 0x8030;         // Timer1 ON, internal clock FCY, prescaler 1:128
	MOV	#32816, W0
	MOV	WREG, T1CON
;EthV2_Demo.c,1224 :: 		T1IF_bit = 0 ;          // clear TMR1 overflow interrupt flag
	BCLR	T1IF_bit, BitPos(T1IF_bit+0)
;EthV2_Demo.c,1225 :: 		T1IE_bit = 1 ;          // enable interrupt on TMR0 overflow
	BSET	T1IE_bit, BitPos(T1IE_bit+0)
;EthV2_Demo.c,1230 :: 		SPI3_Init();
	CALL	_SPI3_Init
;EthV2_Demo.c,1232 :: 		SPI_Set_Active(SPI3_Read, SPI3_Write);
	MOV	#lo_addr(_SPI3_Write), W11
	MOV	#lo_addr(_SPI3_Read), W10
	CALL	_SPI_Set_Active
;EthV2_Demo.c,1233 :: 		SPI_Lcd_Config(0);                     // Initialize Lcd over SPI interface
	CLR	W10
	CALL	_SPI_Lcd_Config
;EthV2_Demo.c,1234 :: 		SPI_Lcd_Cmd(_LCD_CLEAR);
	MOV.B	#1, W10
	CALL	_SPI_Lcd_Cmd
;EthV2_Demo.c,1235 :: 		SPI_Lcd_Cmd(_LCD_CURSOR_OFF);
	MOV.B	#12, W10
	CALL	_SPI_Lcd_Cmd
;EthV2_Demo.c,1237 :: 		SPI_Lcd_Out(1, 1, "EthClock Welcome");
	MOV	#lo_addr(?lstr132_EthV2_Demo), W12
	MOV.B	#1, W11
	MOV.B	#1, W10
	CALL	_SPI_Lcd_Out
;EthV2_Demo.c,1238 :: 		SPI_Lcd_Out(2, 1, "Ethernet init...");
	MOV	#lo_addr(?lstr133_EthV2_Demo), W12
	MOV.B	#1, W11
	MOV.B	#2, W10
	CALL	_SPI_Lcd_Out
;EthV2_Demo.c,1243 :: 		SPI1_Init();
	CALL	_SPI1_Init
;EthV2_Demo.c,1247 :: 		SPI_Set_Active(SPI1_Read, SPI1_Write);
	MOV	#lo_addr(_SPI1_Write), W11
	MOV	#lo_addr(_SPI1_Read), W10
	CALL	_SPI_Set_Active
;EthV2_Demo.c,1248 :: 		SPI_Ethernet_Init(macAddr, ipAddr, SPI_Ethernet_FULLDUPLEX);
	MOV.B	#1, W12
	MOV	#lo_addr(_ipAddr), W11
	MOV	#lo_addr(_macAddr), W10
	CALL	_SPI_Ethernet_Init
;EthV2_Demo.c,1253 :: 		SPI_Set_Active(SPI3_Read, SPI3_Write);
	MOV	#lo_addr(_SPI3_Write), W11
	MOV	#lo_addr(_SPI3_Read), W10
	CALL	_SPI_Set_Active
;EthV2_Demo.c,1254 :: 		SPI_Lcd_Out(2, 1, "Registering...  ");
	MOV	#lo_addr(?lstr134_EthV2_Demo), W12
	MOV.B	#1, W11
	MOV.B	#2, W10
	CALL	_SPI_Lcd_Out
;EthV2_Demo.c,1256 :: 		SPI_Set_Active(SPI1_Read, SPI1_Write);
	MOV	#lo_addr(_SPI1_Write), W11
	MOV	#lo_addr(_SPI1_Read), W10
	CALL	_SPI_Set_Active
;EthV2_Demo.c,1257 :: 		if(SPI_Ethernet_getIpAddress()[0] == 0)        // is IP address null ?
	CALL	_SPI_Ethernet_getIpAddress
	MOV.B	[W0], W0
	CP.B	W0, #0
	BRA Z	L__main226
	GOTO	L_main126
L__main226:
;EthV2_Demo.c,1259 :: 		SPI_Set_Active(SPI1_Read, SPI1_Write);
	MOV	#lo_addr(_SPI1_Write), W11
	MOV	#lo_addr(_SPI1_Read), W10
	CALL	_SPI_Set_Active
;EthV2_Demo.c,1260 :: 		while(SPI_Ethernet_initDHCP(5) == 0); // try to get one from DHCP until it works
L_main127:
	MOV.B	#5, W10
	CALL	_SPI_Ethernet_initDHCP
	CP	W0, #0
	BRA Z	L__main227
	GOTO	L_main128
L__main227:
	GOTO	L_main127
L_main128:
;EthV2_Demo.c,1267 :: 		SPI_Set_Active(SPI1_Read, SPI1_Write);
	MOV	#lo_addr(_SPI1_Write), W11
	MOV	#lo_addr(_SPI1_Read), W10
	CALL	_SPI_Set_Active
;EthV2_Demo.c,1268 :: 		memcpy(ipAddr,    SPI_Ethernet_getIpAddress(),    4); // get assigned IP address
	CALL	_SPI_Ethernet_getIpAddress
	MOV	#4, W12
	MOV	W0, W11
	MOV	#lo_addr(_ipAddr), W10
	CALL	_memcpy
;EthV2_Demo.c,1269 :: 		SPI_Set_Active(SPI1_Read, SPI1_Write);
	MOV	#lo_addr(_SPI1_Write), W11
	MOV	#lo_addr(_SPI1_Read), W10
	CALL	_SPI_Set_Active
;EthV2_Demo.c,1270 :: 		memcpy(ipMask,    SPI_Ethernet_getIpMask(),       4); // get assigned IP mask
	CALL	_SPI_Ethernet_getIpMask
	MOV	#4, W12
	MOV	W0, W11
	MOV	#lo_addr(_ipMask), W10
	CALL	_memcpy
;EthV2_Demo.c,1271 :: 		SPI_Set_Active(SPI1_Read, SPI1_Write);
	MOV	#lo_addr(_SPI1_Write), W11
	MOV	#lo_addr(_SPI1_Read), W10
	CALL	_SPI_Set_Active
;EthV2_Demo.c,1272 :: 		memcpy(gwIpAddr,  SPI_Ethernet_getGwIpAddress(),  4); // get assigned gateway IP address
	CALL	_SPI_Ethernet_getGwIpAddress
	MOV	#4, W12
	MOV	W0, W11
	MOV	#lo_addr(_gwIpAddr), W10
	CALL	_memcpy
;EthV2_Demo.c,1273 :: 		SPI_Set_Active(SPI1_Read, SPI1_Write);
	MOV	#lo_addr(_SPI1_Write), W11
	MOV	#lo_addr(_SPI1_Read), W10
	CALL	_SPI_Set_Active
;EthV2_Demo.c,1274 :: 		memcpy(dnsIpAddr, SPI_Ethernet_getDnsIpAddress(), 4); // get assigned dns IP address
	CALL	_SPI_Ethernet_getDnsIpAddress
	MOV	#4, W12
	MOV	W0, W11
	MOV	#lo_addr(_dnsIpAddr), W10
	CALL	_memcpy
;EthV2_Demo.c,1275 :: 		}
	GOTO	L_main129
L_main126:
;EthV2_Demo.c,1278 :: 		SPI_Set_Active(SPI1_Read, SPI1_Write);
	MOV	#lo_addr(_SPI1_Write), W11
	MOV	#lo_addr(_SPI1_Read), W10
	CALL	_SPI_Set_Active
;EthV2_Demo.c,1279 :: 		SPI_Ethernet_confNetwork(ipMask, gwIpAddr, dnsIpAddr); // use configured IP address
	MOV	#lo_addr(_dnsIpAddr), W12
	MOV	#lo_addr(_gwIpAddr), W11
	MOV	#lo_addr(_ipMask), W10
	CALL	_SPI_Ethernet_confNetwork
;EthV2_Demo.c,1280 :: 		}
L_main129:
;EthV2_Demo.c,1282 :: 		while(1)                                // forever
L_main130:
;EthV2_Demo.c,1287 :: 		SPI_Set_Active(SPI1_Read, SPI1_Write);
	MOV	#lo_addr(_SPI1_Write), W11
	MOV	#lo_addr(_SPI1_Read), W10
	CALL	_SPI_Set_Active
;EthV2_Demo.c,1288 :: 		SPI_Ethernet_doPacket();       // process incoming Ethernet packets
	CALL	_SPI_Ethernet_doPacket
;EthV2_Demo.c,1291 :: 		mkSNTPrequest();               // do sntp request if needed
	CALL	_mkSNTPrequest
;EthV2_Demo.c,1314 :: 		Time_epochToDate(epoch + conf.tz * 3600l, &ts);
	MOV	#lo_addr(_conf+2), W2
	MOV	#3600, W0
	MOV	#0, W1
	SE	[W2], W2
	ASR	W2, #15, W3
	CALL	__Multiply_32x32
	MOV	#lo_addr(_epoch), W4
	ADD	W0, [W4++], W2
	ADDC	W1, [W4--], W3
	MOV	#lo_addr(_ts), W12
	MOV.D	W2, W10
	CALL	_Time_epochToDate
;EthV2_Demo.c,1315 :: 		if(lcdEvent)
	MOV	#lo_addr(_lcdEvent), W0
	CP0.B	[W0]
	BRA NZ	L__main228
	GOTO	L_main132
L__main228:
;EthV2_Demo.c,1317 :: 		mkLCDLine(1, conf.lcdL1); // update lcd: first row
	MOV	#lo_addr(_conf), W0
	MOV.B	[W0], W11
	MOV.B	#1, W10
	CALL	_mkLCDLine
;EthV2_Demo.c,1318 :: 		mkLCDLine(2, conf.lcdL2); // update lcd: second row
	MOV	#lo_addr(_conf+1), W0
	MOV.B	[W0], W11
	MOV.B	#2, W10
	CALL	_mkLCDLine
;EthV2_Demo.c,1319 :: 		lcdEvent = 0;             // clear lcd update flag
	MOV	#lo_addr(_lcdEvent), W1
	CLR	W0
	MOV.B	W0, [W1]
;EthV2_Demo.c,1320 :: 		marquee++;                // set marquee pointer
	MOV	#1, W1
	MOV	#lo_addr(_marquee), W0
	ADD	W1, [W0], [W0]
;EthV2_Demo.c,1321 :: 		}
L_main132:
;EthV2_Demo.c,1322 :: 		}
	GOTO	L_main130
;EthV2_Demo.c,1323 :: 		}
L_end_main:
	POP	W12
	POP	W11
	POP	W10
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
