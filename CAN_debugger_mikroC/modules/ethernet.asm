
_ethernetInit:

;ethernet.c,14 :: 		void ethernetInit(void)
;ethernet.c,16 :: 		SPI1_Init();
	PUSH	W10
	PUSH	W11
	PUSH	W12
	CALL	_SPI1_Init
;ethernet.c,17 :: 		SPI_Ethernet_Init(myMacAddr, myIpAddr, SPI_Ethernet_FULLDUPLEX);
	MOV.B	#1, W12
	MOV	#lo_addr(_myIpAddr), W11
	MOV	#lo_addr(_myMacAddr), W10
	CALL	_SPI_Ethernet_Init
;ethernet.c,18 :: 		SPI_Ethernet_confNetwork(ipMask, gwIpAddr, dnsIpAddr);
	MOV	#lo_addr(_dnsIpAddr), W12
	MOV	#lo_addr(_gwIpAddr), W11
	MOV	#lo_addr(_ipMask), W10
	CALL	_SPI_Ethernet_confNetwork
;ethernet.c,19 :: 		}
L_end_ethernetInit:
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of _ethernetInit

_SPI_Ethernet_UserTCP:
	LNK	#0

;ethernet.c,21 :: 		unsigned int  SPI_Ethernet_UserTCP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthPktFlags *flags)
; flags start address is: 0 (W0)
	MOV	[W14-8], W0
; flags end address is: 0 (W0)
;ethernet.c,23 :: 		if(localPort == 1808)
	MOV	#1808, W0
	CP	W12, W0
	BRA Z	L__SPI_Ethernet_UserTCP3
	GOTO	L_SPI_Ethernet_UserTCP0
L__SPI_Ethernet_UserTCP3:
;ethernet.c,25 :: 		PORTEbits.RE0 = ~PORTEbits.RE0;
	BTG	PORTEbits, #0
;ethernet.c,26 :: 		return 5;
	MOV	#5, W0
	GOTO	L_end_SPI_Ethernet_UserTCP
;ethernet.c,27 :: 		}
L_SPI_Ethernet_UserTCP0:
;ethernet.c,28 :: 		return 0;
	CLR	W0
;ethernet.c,29 :: 		}
L_end_SPI_Ethernet_UserTCP:
	ULNK
	RETURN
; end of _SPI_Ethernet_UserTCP

_SPI_Ethernet_UserUDP:
	LNK	#0

;ethernet.c,31 :: 		unsigned int SPI_Ethernet_UserUDP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthPktFlags *flags)
; flags start address is: 0 (W0)
	MOV	[W14-8], W0
; flags end address is: 0 (W0)
;ethernet.c,33 :: 		return 0;
	CLR	W0
;ethernet.c,34 :: 		}
L_end_SPI_Ethernet_UserUDP:
	ULNK
	RETURN
; end of _SPI_Ethernet_UserUDP
