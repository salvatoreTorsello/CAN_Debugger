
_HTTP_b64_decode4:

;httpUtils.c,89 :: 		void    HTTP_b64_decode4(unsigned char in[4], unsigned char out[3])
;httpUtils.c,91 :: 		out[0] = (in[0] << 2) | (in[1] >> 4);
	MOV.B	[W10], W0
	ZE	W0, W0
	SL	W0, #2, W1
	ADD	W10, #1, W0
	MOV.B	[W0], W0
	ZE	W0, W0
	LSR	W0, #4, W0
	ZE	W0, W0
	IOR	W1, W0, W0
	MOV.B	W0, [W11]
;httpUtils.c,92 :: 		out[1] = (in[1] << 4) | (in[2] >> 2);
	ADD	W11, #1, W2
	ADD	W10, #1, W0
	MOV.B	[W0], W0
	ZE	W0, W0
	SL	W0, #4, W1
	ADD	W10, #2, W0
	MOV.B	[W0], W0
	ZE	W0, W0
	LSR	W0, #2, W0
	ZE	W0, W0
	IOR	W1, W0, W0
	MOV.B	W0, [W2]
;httpUtils.c,93 :: 		out[2] = ((in[2] << 6) & 0xc0) | in[3];
	ADD	W11, #2, W2
	ADD	W10, #2, W0
	MOV.B	[W0], W0
	ZE	W0, W0
	SL	W0, #6, W1
	MOV	#192, W0
	AND	W1, W0, W1
	ADD	W10, #3, W0
	ZE	[W0], W0
	IOR	W1, W0, W0
	MOV.B	W0, [W2]
;httpUtils.c,94 :: 		}
L_end_HTTP_b64_decode4:
	RETURN
; end of _HTTP_b64_decode4

_HTTP_b64_unencode:
	LNK	#10

;httpUtils.c,99 :: 		void    HTTP_b64_unencode(char *src, char *dst)
;httpUtils.c,104 :: 		while(*src)
L_HTTP_b64_unencode0:
	CP0.B	[W10]
	BRA NZ	L__HTTP_b64_unencode65
	GOTO	L_HTTP_b64_unencode1
L__HTTP_b64_unencode65:
;httpUtils.c,106 :: 		for(len = 0, i = 0; i < 4 && *src; i++)
; len start address is: 8 (W4)
	CLR	W4
; i start address is: 0 (W0)
	CLR	W0
; i end address is: 0 (W0)
; len end address is: 8 (W4)
	MOV	W0, W3
L_HTTP_b64_unencode2:
; i start address is: 6 (W3)
; len start address is: 8 (W4)
	CP	W3, #4
	BRA LT	L__HTTP_b64_unencode66
	GOTO	L__HTTP_b64_unencode50
L__HTTP_b64_unencode66:
	CP0.B	[W10]
	BRA NZ	L__HTTP_b64_unencode67
	GOTO	L__HTTP_b64_unencode49
L__HTTP_b64_unencode67:
L__HTTP_b64_unencode44:
;httpUtils.c,108 :: 		v = 0;
; v start address is: 4 (W2)
	CLR	W2
; v end address is: 4 (W2)
; len end address is: 8 (W4)
; i end address is: 6 (W3)
;httpUtils.c,109 :: 		while(*src && (v == 0))
L_HTTP_b64_unencode7:
; v start address is: 4 (W2)
; len start address is: 8 (W4)
; i start address is: 6 (W3)
	CP0.B	[W10]
	BRA NZ	L__HTTP_b64_unencode68
	GOTO	L__HTTP_b64_unencode48
L__HTTP_b64_unencode68:
	CP.B	W2, #0
	BRA Z	L__HTTP_b64_unencode69
	GOTO	L__HTTP_b64_unencode47
L__HTTP_b64_unencode69:
; v end address is: 4 (W2)
L__HTTP_b64_unencode43:
;httpUtils.c,111 :: 		v = *src++;
	MOV.B	[W10], W1
; v start address is: 4 (W2)
	MOV.B	W1, W2
	ADD	W10, #1, W0
	MOV	W0, W10
;httpUtils.c,112 :: 		v = ((v < 43 || v > 122) ? 0 : HTTP_b64_reverse[v - 43]);
	MOV.B	#43, W0
	CP.B	W1, W0
	BRA GEU	L__HTTP_b64_unencode70
	GOTO	L__HTTP_b64_unencode46
L__HTTP_b64_unencode70:
	MOV.B	#122, W0
	CP.B	W2, W0
	BRA LEU	L__HTTP_b64_unencode71
	GOTO	L__HTTP_b64_unencode45
L__HTTP_b64_unencode71:
	GOTO	L_HTTP_b64_unencode13
; v end address is: 4 (W2)
L__HTTP_b64_unencode46:
L__HTTP_b64_unencode45:
; ?FLOC___HTTP_b64_unencode?T48 start address is: 0 (W0)
	CLR	W0
; ?FLOC___HTTP_b64_unencode?T48 end address is: 0 (W0)
	GOTO	L_HTTP_b64_unencode14
L_HTTP_b64_unencode13:
; v start address is: 4 (W2)
	ZE	W2, W1
; v end address is: 4 (W2)
	MOV	#43, W0
	SUB	W1, W0, W1
	MOV	#lo_addr(_HTTP_b64_reverse), W0
	ADD	W0, W1, W1
	MOV	#___Lib_System_DefaultPage, W0
	MOV	WREG, 52
	MOV.B	[W1], W0
; ?FLOC___HTTP_b64_unencode?T48 start address is: 2 (W1)
	MOV.B	W0, W1
; ?FLOC___HTTP_b64_unencode?T48 end address is: 2 (W1)
	MOV.B	W1, W0
L_HTTP_b64_unencode14:
; ?FLOC___HTTP_b64_unencode?T48 start address is: 0 (W0)
; v start address is: 2 (W1)
	MOV.B	W0, W1
;httpUtils.c,113 :: 		if(v)
	CP0.B	W0
	BRA NZ	L__HTTP_b64_unencode72
	GOTO	L__HTTP_b64_unencode51
L__HTTP_b64_unencode72:
; ?FLOC___HTTP_b64_unencode?T48 end address is: 0 (W0)
;httpUtils.c,115 :: 		v = ((v == '$') ? 0 : v - 61);
	MOV.B	#36, W0
	CP.B	W1, W0
	BRA Z	L__HTTP_b64_unencode73
	GOTO	L_HTTP_b64_unencode16
L__HTTP_b64_unencode73:
; v end address is: 2 (W1)
	CLR	W0
	MOV	W0, [W14+0]
	GOTO	L_HTTP_b64_unencode17
L_HTTP_b64_unencode16:
; v start address is: 2 (W1)
	ZE	W1, W2
; v end address is: 2 (W1)
	MOV	#61, W1
	ADD	W14, #0, W0
	SUB	W2, W1, [W0]
L_HTTP_b64_unencode17:
; v start address is: 0 (W0)
	MOV.B	[W14+0], W0
; v end address is: 0 (W0)
	MOV.B	W0, W2
;httpUtils.c,116 :: 		}
	GOTO	L_HTTP_b64_unencode15
L__HTTP_b64_unencode51:
;httpUtils.c,113 :: 		if(v)
	MOV.B	W1, W2
;httpUtils.c,116 :: 		}
L_HTTP_b64_unencode15:
;httpUtils.c,117 :: 		}
; v start address is: 4 (W2)
	GOTO	L_HTTP_b64_unencode7
;httpUtils.c,109 :: 		while(*src && (v == 0))
L__HTTP_b64_unencode48:
L__HTTP_b64_unencode47:
;httpUtils.c,118 :: 		if(*src)
	CP0.B	[W10]
	BRA NZ	L__HTTP_b64_unencode74
	GOTO	L_HTTP_b64_unencode18
L__HTTP_b64_unencode74:
;httpUtils.c,120 :: 		len++;
; len start address is: 8 (W4)
	INC	W4
; len end address is: 8 (W4)
;httpUtils.c,121 :: 		if(v)
	CP0.B	W2
	BRA NZ	L__HTTP_b64_unencode75
	GOTO	L_HTTP_b64_unencode19
L__HTTP_b64_unencode75:
;httpUtils.c,123 :: 		in[i] = (v - 1);
	ADD	W14, #2, W0
	ADD	W0, W3, W1
	ZE	W2, W0
; v end address is: 4 (W2)
	DEC	W0
	MOV.B	W0, [W1]
;httpUtils.c,124 :: 		}
L_HTTP_b64_unencode19:
;httpUtils.c,125 :: 		}
	GOTO	L_HTTP_b64_unencode20
L_HTTP_b64_unencode18:
;httpUtils.c,128 :: 		in[i] = 0;
	ADD	W14, #2, W0
	ADD	W0, W3, W1
	CLR	W0
	MOV.B	W0, [W1]
; len end address is: 8 (W4)
;httpUtils.c,129 :: 		}
L_HTTP_b64_unencode20:
;httpUtils.c,106 :: 		for(len = 0, i = 0; i < 4 && *src; i++)
; len start address is: 8 (W4)
	INC	W3
;httpUtils.c,130 :: 		}
; i end address is: 6 (W3)
	GOTO	L_HTTP_b64_unencode2
;httpUtils.c,106 :: 		for(len = 0, i = 0; i < 4 && *src; i++)
L__HTTP_b64_unencode50:
L__HTTP_b64_unencode49:
;httpUtils.c,132 :: 		if(len)
	CP0	W4
	BRA NZ	L__HTTP_b64_unencode76
	GOTO	L_HTTP_b64_unencode21
L__HTTP_b64_unencode76:
;httpUtils.c,134 :: 		HTTP_b64_decode4(in, out);
	ADD	W14, #6, W1
	ADD	W14, #2, W0
	PUSH.D	W10
	MOV	W1, W11
	MOV	W0, W10
	CALL	_HTTP_b64_decode4
	POP.D	W10
;httpUtils.c,135 :: 		for(i = 0; i < len - 1; i++)
; i start address is: 4 (W2)
	CLR	W2
; len end address is: 8 (W4)
; i end address is: 4 (W2)
	MOV	W4, W1
L_HTTP_b64_unencode22:
; i start address is: 4 (W2)
; len start address is: 2 (W1)
	SUB	W1, #1, W0
	CP	W2, W0
	BRA LT	L__HTTP_b64_unencode77
	GOTO	L_HTTP_b64_unencode23
L__HTTP_b64_unencode77:
;httpUtils.c,137 :: 		*dst = out[i];
	ADD	W14, #6, W0
	ADD	W0, W2, W0
	MOV.B	[W0], [W11]
;httpUtils.c,138 :: 		dst++;
	ADD	W11, #1, W0
	MOV	W0, W11
;httpUtils.c,135 :: 		for(i = 0; i < len - 1; i++)
	INC	W2
;httpUtils.c,139 :: 		}
; len end address is: 2 (W1)
; i end address is: 4 (W2)
	GOTO	L_HTTP_b64_unencode22
L_HTTP_b64_unencode23:
;httpUtils.c,140 :: 		}
L_HTTP_b64_unencode21:
;httpUtils.c,141 :: 		}
	GOTO	L_HTTP_b64_unencode0
L_HTTP_b64_unencode1:
;httpUtils.c,143 :: 		*dst = 0;
	CLR	W0
	MOV.B	W0, [W11]
;httpUtils.c,144 :: 		}
L_end_HTTP_b64_unencode:
	ULNK
	RETURN
; end of _HTTP_b64_unencode

_HTTP_basicRealm:
	LNK	#168

;httpUtils.c,159 :: 		unsigned char   HTTP_basicRealm(unsigned int l, unsigned char *passwd)
;httpUtils.c,161 :: 		unsigned int    len = 0;       // my reply length
	PUSH	W12
;httpUtils.c,167 :: 		i = 0;
; i start address is: 8 (W4)
	CLR	W4
;httpUtils.c,168 :: 		found = 0;
	CLR	W0
	MOV.B	W0, [W14+159]
; i end address is: 8 (W4)
	MOV	W4, W3
;httpUtils.c,169 :: 		while(l--)
L_HTTP_basicRealm25:
; i start address is: 6 (W3)
	MOV	W10, W1
	SUB	W10, #1, W0
	MOV	W0, W10
	CP0	W1
	BRA NZ	L__HTTP_basicRealm79
	GOTO	L_HTTP_basicRealm26
L__HTTP_basicRealm79:
;httpUtils.c,171 :: 		auth[i] = SPI_Ethernet_getByte();
	ADD	W14, #0, W0
	MOV	W0, [W14+166]
	ADD	W0, W3, W0
	MOV	W0, [W14+164]
	PUSH	W3
	PUSH.D	W10
	CALL	_SPI_Ethernet_getByte
	POP.D	W10
	POP	W3
	MOV	[W14+164], W1
	MOV.B	W0, [W1]
;httpUtils.c,172 :: 		if((auth[i] < 32) || (i == AUTH_STR_MAXLENGTH - 1))
	MOV	[W14+166], W0
	ADD	W0, W3, W0
	MOV.B	[W0], W1
	MOV.B	#32, W0
	CP.B	W1, W0
	BRA GEU	L__HTTP_basicRealm80
	GOTO	L__HTTP_basicRealm54
L__HTTP_basicRealm80:
	MOV	#127, W0
	CP	W3, W0
	BRA NZ	L__HTTP_basicRealm81
	GOTO	L__HTTP_basicRealm53
L__HTTP_basicRealm81:
	GOTO	L_HTTP_basicRealm29
L__HTTP_basicRealm54:
L__HTTP_basicRealm53:
;httpUtils.c,174 :: 		if(memcmp(auth, AUTH_STRING, sizeof(AUTH_STRING) - 1) == 0)
	ADD	W14, #0, W0
	PUSH.D	W10
	MOV	#20, W12
	MOV	#lo_addr(?lstr1_httpUtils), W11
	MOV	W0, W10
	CALL	_memcmp
	POP.D	W10
	CP	W0, #0
	BRA Z	L__HTTP_basicRealm82
	GOTO	L_HTTP_basicRealm30
L__HTTP_basicRealm82:
;httpUtils.c,176 :: 		auth[i] = 0;
	ADD	W14, #0, W2
	ADD	W2, W3, W1
; i end address is: 6 (W3)
	CLR	W0
	MOV.B	W0, [W1]
;httpUtils.c,177 :: 		HTTP_b64_unencode(auth + sizeof(AUTH_STRING) - 1, login);
	MOV	#128, W1
	ADD	W14, W1, W1
	ADD	W2, #21, W0
	DEC	W0
	PUSH.D	W10
	MOV	W1, W11
	MOV	W0, W10
	CALL	_HTTP_b64_unencode
	POP.D	W10
;httpUtils.c,178 :: 		if(strcmp(login, passwd) == 0)
	MOV	#128, W0
	ADD	W14, W0, W0
	PUSH.D	W10
	MOV	W0, W10
	CALL	_strcmp
	POP.D	W10
	CP	W0, #0
	BRA Z	L__HTTP_basicRealm83
	GOTO	L_HTTP_basicRealm31
L__HTTP_basicRealm83:
;httpUtils.c,180 :: 		found = 1;
	MOV.B	#1, W0
	MOV.B	W0, [W14+159]
;httpUtils.c,181 :: 		}
L_HTTP_basicRealm31:
;httpUtils.c,182 :: 		break;
	GOTO	L_HTTP_basicRealm26
;httpUtils.c,183 :: 		}
L_HTTP_basicRealm30:
;httpUtils.c,184 :: 		i = 0;
; i start address is: 8 (W4)
	CLR	W4
;httpUtils.c,185 :: 		}
; i end address is: 8 (W4)
	GOTO	L_HTTP_basicRealm32
L_HTTP_basicRealm29:
;httpUtils.c,188 :: 		i++;
; i start address is: 8 (W4)
; i start address is: 6 (W3)
	ADD	W3, #1, W4
; i end address is: 6 (W3)
; i end address is: 8 (W4)
;httpUtils.c,189 :: 		}
L_HTTP_basicRealm32:
;httpUtils.c,190 :: 		}
; i start address is: 8 (W4)
	MOV	W4, W3
; i end address is: 8 (W4)
	GOTO	L_HTTP_basicRealm25
L_HTTP_basicRealm26:
;httpUtils.c,192 :: 		return(found);
	MOV.B	[W14+159], W0
;httpUtils.c,193 :: 		}
;httpUtils.c,192 :: 		return(found);
;httpUtils.c,193 :: 		}
L_end_HTTP_basicRealm:
	POP	W12
	ULNK
	RETURN
; end of _HTTP_basicRealm

_HTTP_getRequest:

;httpUtils.c,202 :: 		unsigned char   HTTP_getRequest(unsigned char *buf, unsigned int *len, unsigned int max)
;httpUtils.c,209 :: 		if((SPI_Ethernet_getByte() != 'G')
	PUSH	W12
	PUSH.D	W10
	CALL	_SPI_Ethernet_getByte
	POP.D	W10
	POP	W12
;httpUtils.c,210 :: 		|| (SPI_Ethernet_getByte() != 'E')
	MOV.B	#71, W1
	CP.B	W0, W1
	BRA Z	L__HTTP_getRequest85
	GOTO	L__HTTP_getRequest60
L__HTTP_getRequest85:
	PUSH	W12
	PUSH.D	W10
	CALL	_SPI_Ethernet_getByte
	POP.D	W10
	POP	W12
	MOV.B	#69, W1
	CP.B	W0, W1
	BRA Z	L__HTTP_getRequest86
	GOTO	L__HTTP_getRequest59
L__HTTP_getRequest86:
;httpUtils.c,211 :: 		|| (SPI_Ethernet_getByte() != 'T')
	PUSH	W12
	PUSH.D	W10
	CALL	_SPI_Ethernet_getByte
	POP.D	W10
	POP	W12
	MOV.B	#84, W1
	CP.B	W0, W1
	BRA Z	L__HTTP_getRequest87
	GOTO	L__HTTP_getRequest58
L__HTTP_getRequest87:
;httpUtils.c,212 :: 		|| (SPI_Ethernet_getByte() != ' ')
	PUSH	W12
	PUSH.D	W10
	CALL	_SPI_Ethernet_getByte
	POP.D	W10
	POP	W12
	MOV.B	#32, W1
	CP.B	W0, W1
	BRA Z	L__HTTP_getRequest88
	GOTO	L__HTTP_getRequest57
L__HTTP_getRequest88:
	GOTO	L_HTTP_getRequest35
;httpUtils.c,210 :: 		|| (SPI_Ethernet_getByte() != 'E')
L__HTTP_getRequest60:
L__HTTP_getRequest59:
;httpUtils.c,211 :: 		|| (SPI_Ethernet_getByte() != 'T')
L__HTTP_getRequest58:
;httpUtils.c,212 :: 		|| (SPI_Ethernet_getByte() != ' ')
L__HTTP_getRequest57:
;httpUtils.c,215 :: 		return(0);
	CLR	W0
	GOTO	L_end_HTTP_getRequest
;httpUtils.c,216 :: 		}
L_HTTP_getRequest35:
;httpUtils.c,221 :: 		for(i = 0; (i < max) && *len; i++, buf++)
; i start address is: 4 (W2)
	CLR	W2
; i end address is: 4 (W2)
L_HTTP_getRequest36:
; i start address is: 4 (W2)
	CP	W2, W12
	BRA LTU	L__HTTP_getRequest89
	GOTO	L__HTTP_getRequest62
L__HTTP_getRequest89:
	CP0	[W11]
	BRA NZ	L__HTTP_getRequest90
	GOTO	L__HTTP_getRequest61
L__HTTP_getRequest90:
L__HTTP_getRequest55:
;httpUtils.c,223 :: 		*buf = SPI_Ethernet_getByte();
	PUSH	W2
	PUSH	W12
	PUSH.D	W10
	CALL	_SPI_Ethernet_getByte
	POP.D	W10
	POP	W12
	POP	W2
	MOV.B	W0, [W10]
;httpUtils.c,224 :: 		(*len)--;
	MOV	[W11], W0
	DEC	W0
	MOV	W0, [W11]
;httpUtils.c,225 :: 		if(*buf < 32) break;
	MOV.B	[W10], W1
	MOV.B	#32, W0
	CP.B	W1, W0
	BRA LTU	L__HTTP_getRequest91
	GOTO	L_HTTP_getRequest41
L__HTTP_getRequest91:
; i end address is: 4 (W2)
	GOTO	L_HTTP_getRequest37
L_HTTP_getRequest41:
;httpUtils.c,221 :: 		for(i = 0; (i < max) && *len; i++, buf++)
; i start address is: 4 (W2)
	INC	W2
	ADD	W10, #1, W0
	MOV	W0, W10
;httpUtils.c,226 :: 		}
; i end address is: 4 (W2)
	GOTO	L_HTTP_getRequest36
L_HTTP_getRequest37:
;httpUtils.c,221 :: 		for(i = 0; (i < max) && *len; i++, buf++)
L__HTTP_getRequest62:
L__HTTP_getRequest61:
;httpUtils.c,227 :: 		*(buf) = 0;
	CLR	W0
	MOV.B	W0, [W10]
;httpUtils.c,229 :: 		return(1);
	MOV.B	#1, W0
;httpUtils.c,230 :: 		}
L_end_HTTP_getRequest:
	RETURN
; end of _HTTP_getRequest

_HTTP_accessDenied:
	LNK	#2

;httpUtils.c,244 :: 		unsigned int    HTTP_accessDenied(const unsigned char *zn, const unsigned char *m)
;httpUtils.c,248 :: 		len = SPI_Ethernet_putConstString(HTTP_Denied);
	PUSH	W10
	PUSH.D	W10
	MOV	#lo_addr(_HTTP_Denied), W10
	CALL	_SPI_Ethernet_putConstString
	POP.D	W10
	MOV	W0, [W14+0]
;httpUtils.c,249 :: 		len += SPI_Ethernet_putConstString(zn);
	PUSH	W11
	CALL	_SPI_Ethernet_putConstString
	ADD	W14, #0, W2
	ADD	W14, #0, W1
	ADD	W0, [W2], [W1]
;httpUtils.c,250 :: 		len += SPI_Ethernet_putConstString("\"\n\n");
	MOV	#lo_addr(?lstr_2_httpUtils), W10
	CALL	_SPI_Ethernet_putConstString
	POP	W11
	ADD	W14, #0, W2
	ADD	W14, #0, W1
	ADD	W0, [W2], [W1]
;httpUtils.c,251 :: 		len += SPI_Ethernet_putConstString(m);
	MOV	W11, W10
	CALL	_SPI_Ethernet_putConstString
	ADD	W14, #0, W1
	ADD	W0, [W1], W0
;httpUtils.c,253 :: 		return(len);
;httpUtils.c,254 :: 		}
;httpUtils.c,253 :: 		return(len);
;httpUtils.c,254 :: 		}
L_end_HTTP_accessDenied:
	POP	W10
	ULNK
	RETURN
; end of _HTTP_accessDenied

_HTTP_redirect:
	LNK	#2

;httpUtils.c,260 :: 		unsigned int    HTTP_redirect(unsigned char *url)
;httpUtils.c,264 :: 		len = SPI_Ethernet_putConstString(HTTP_Redir);
	PUSH	W10
	PUSH	W10
	MOV	#lo_addr(_HTTP_Redir), W10
	CALL	_SPI_Ethernet_putConstString
	POP	W10
	MOV	W0, [W14+0]
;httpUtils.c,265 :: 		len += SPI_Ethernet_putString(url);
	CALL	_SPI_Ethernet_putString
	ADD	W14, #0, W2
	ADD	W14, #0, W1
	ADD	W0, [W2], [W1]
;httpUtils.c,266 :: 		len += SPI_Ethernet_putConstString("\n\n");
	MOV	#lo_addr(?lstr_3_httpUtils), W10
	CALL	_SPI_Ethernet_putConstString
	ADD	W14, #0, W1
	ADD	W0, [W1], W0
;httpUtils.c,268 :: 		return(len);
;httpUtils.c,269 :: 		}
;httpUtils.c,268 :: 		return(len);
;httpUtils.c,269 :: 		}
L_end_HTTP_redirect:
	POP	W10
	ULNK
	RETURN
; end of _HTTP_redirect

_HTTP_html:
	LNK	#2

;httpUtils.c,275 :: 		unsigned int    HTTP_html(const unsigned char *html)
;httpUtils.c,279 :: 		len = SPI_Ethernet_putConstString(HTTP_HeaderHtml);
	PUSH	W10
	MOV	#lo_addr(_HTTP_HeaderHtml), W10
	CALL	_SPI_Ethernet_putConstString
	POP	W10
	MOV	W0, [W14+0]
;httpUtils.c,280 :: 		len += SPI_Ethernet_putConstString(html);
	CALL	_SPI_Ethernet_putConstString
	ADD	W14, #0, W1
	ADD	W0, [W1], W0
;httpUtils.c,282 :: 		return(len);
;httpUtils.c,283 :: 		}
L_end_HTTP_html:
	ULNK
	RETURN
; end of _HTTP_html

_HTTP_imageGIF:
	LNK	#2

;httpUtils.c,289 :: 		unsigned int    HTTP_imageGIF(const unsigned char *img, unsigned int l)
;httpUtils.c,293 :: 		len = SPI_Ethernet_putConstString(HTTP_HeaderGif);
	PUSH.D	W10
	MOV	#lo_addr(_HTTP_HeaderGif), W10
	CALL	_SPI_Ethernet_putConstString
	POP.D	W10
	MOV	W0, [W14+0]
;httpUtils.c,294 :: 		SPI_Ethernet_putConstBytes(img, l);
	PUSH	W11
	CALL	_SPI_Ethernet_putConstBytes
	POP	W11
;httpUtils.c,295 :: 		len += l;
	ADD	W14, #0, W0
	ADD	W11, [W0], W0
;httpUtils.c,297 :: 		return(len);
;httpUtils.c,298 :: 		}
L_end_HTTP_imageGIF:
	ULNK
	RETURN
; end of _HTTP_imageGIF

_HTTP_error:

;httpUtils.c,304 :: 		unsigned int    HTTP_error()
;httpUtils.c,308 :: 		len = SPI_Ethernet_putConstString(HTTP_NotFound);
	PUSH	W10
	MOV	#lo_addr(_HTTP_NotFound), W10
	CALL	_SPI_Ethernet_putConstString
;httpUtils.c,310 :: 		return(len);
;httpUtils.c,311 :: 		}
;httpUtils.c,310 :: 		return(len);
;httpUtils.c,311 :: 		}
L_end_HTTP_error:
	POP	W10
	RETURN
; end of _HTTP_error
