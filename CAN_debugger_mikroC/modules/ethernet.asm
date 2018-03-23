
_ethernetInit:

;ethernet.c,10 :: 		void ethernetInit(void)
;ethernet.c,12 :: 		SPI1_Init();
	PUSH	W10
	PUSH	W11
	PUSH	W12
	CALL	_SPI1_Init
;ethernet.c,13 :: 		SPI_Ethernet_Init(myMacAddr, myIpAddr, Spi_Ethernet_FULLDUPLEX);
	MOV.B	#1, W12
	MOV	#lo_addr(_myIpAddr), W11
	MOV	#lo_addr(_myMacAddr), W10
	CALL	_SPI_Ethernet_Init
;ethernet.c,15 :: 		}
L_end_ethernetInit:
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of _ethernetInit

_SPI_Ethernet_UserTCP:
	LNK	#0

;ethernet.c,17 :: 		unsigned int  SPI_Ethernet_UserTCP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthPktFlags *flags)
	PUSH	W10
; flags start address is: 0 (W0)
	MOV	[W14-8], W0
; flags end address is: 0 (W0)
;ethernet.c,19 :: 		unsigned int    len = 0 ;                   // my reply length
; len start address is: 2 (W1)
	CLR	W1
;ethernet.c,22 :: 		if(localPort != 1808)
	MOV	#1808, W0
	CP	W12, W0
	BRA NZ	L__SPI_Ethernet_UserTCP5
	GOTO	L_SPI_Ethernet_UserTCP0
L__SPI_Ethernet_UserTCP5:
; len end address is: 2 (W1)
;ethernet.c,24 :: 		return(0) ;
	CLR	W0
	GOTO	L_end_SPI_Ethernet_UserTCP
;ethernet.c,25 :: 		}
L_SPI_Ethernet_UserTCP0:
;ethernet.c,27 :: 		if(len == 0)
; len start address is: 2 (W1)
	CP	W1, #0
	BRA Z	L__SPI_Ethernet_UserTCP6
	GOTO	L__SPI_Ethernet_UserTCP2
L__SPI_Ethernet_UserTCP6:
; len end address is: 2 (W1)
;ethernet.c,29 :: 		len = putConstString(provaStringa);
	MOV	#lo_addr(_provaStringa), W10
	CALL	_SPI_Ethernet_putConstString
; len start address is: 2 (W1)
	MOV	W0, W1
; len end address is: 2 (W1)
;ethernet.c,30 :: 		}
	GOTO	L_SPI_Ethernet_UserTCP1
L__SPI_Ethernet_UserTCP2:
;ethernet.c,27 :: 		if(len == 0)
;ethernet.c,30 :: 		}
L_SPI_Ethernet_UserTCP1:
;ethernet.c,32 :: 		return(len) ;                               // return to the library with the number of bytes to transmit
; len start address is: 2 (W1)
	MOV	W1, W0
; len end address is: 2 (W1)
;ethernet.c,35 :: 		}
;ethernet.c,32 :: 		return(len) ;                               // return to the library with the number of bytes to transmit
;ethernet.c,35 :: 		}
L_end_SPI_Ethernet_UserTCP:
	POP	W10
	ULNK
	RETURN
; end of _SPI_Ethernet_UserTCP
