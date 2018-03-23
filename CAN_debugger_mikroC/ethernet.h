//ethernet.h Created on 23-03 01:40

#ifndef ETHERNET_MODULE
#define ETHERNET_MODULE

#endif

#include "__EthEnc24J600.h"

sfr sbit SPI_Ethernet_24j600_CS at RB0_bit;					//ethernet pinOut
sfr sbit SPI_Ethernet_24j600_CS_Direction at TRISB0_bit;	//ethenret pinMode

unsigned char   myMacAddr[6] = {0x00, 0x14, 0xA5, 0x76, 0x19, 0x3f} ;   // my MAC address 00-20-165-118-25-63
unsigned char   myIpAddr[4]  = {192, 168, 20, 60} ;                     // my IP address

void ethernetInit(void);

SPI1Init();

SPI_Ethernet_24j600_Init(myMacAddr, myIpAddr, SPI_Ethernet_24j600_MANUAL_NEGOTIATION & SPI_Ethernet_24j600_FULLDUPLEX & SPI_Ethernet_24j600_SPD100);