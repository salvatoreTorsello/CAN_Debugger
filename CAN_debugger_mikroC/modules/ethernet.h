//ethernet.h Created on 23-03 01:40

#ifndef ETHERNET_MODULE
#define ETHERNET_MODULE

#endif

#include "../EthV2 Demo/__EthEnc28j60.h"

#define Spi_Ethernet_HALFDUPLEX     0x00  // half duplex
#define Spi_Ethernet_FULLDUPLEX     0x01  // full duplex

#define putConstString  SPI_Ethernet_putConstString

sfr sbit SPI_Ethernet_Rst at RE8_bit;
sfr sbit SPI_Ethernet_CS  at RD3_bit;
sfr sbit SPI_Ethernet_Rst_Direction at TRISE8_bit;
sfr sbit SPI_Ethernet_CS_Direction  at TRISD3_bit;

/*typedef struct
{
	unsigned canCloseTCP: 1;  // flag which closes TCP socket (not relevant to UDP)
  	unsigned isBroadcast: 1;  // flag which denotes that the IP package has been received via subnet broadcast address (not used for PIC16 family)
} TEthPktFlags;*/

void ethernetInit(void);

unsigned int  SPI_Ethernet_UserTCP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthPktFlags *flags);