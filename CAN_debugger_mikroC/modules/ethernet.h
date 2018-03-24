//ethernet.h Created on 23-03 01:40

#ifndef ETHERNET_MODULE
#define ETHERNET_MODULE

#define putConstString  SPI_Ethernet_putConstString

extern sfr sbit SPI_Ethernet_CS;
extern sfr sbit SPI_Ethernet_RST;
extern sfr sbit SPI_Ethernet_CS_Direction;
extern sfr sbit SPI_Ethernet_RST_Direction;

sbit SPI_Ethernet_CS at LATD3_bit;
sbit SPI_Ethernet_Rst at LATE8_bit;
sbit SPI_Ethernet_CS_Direction at TRISD3_bit;
sbit SPI_Ethernet_Rst_Direction at TRISE8_bit;

typedef struct
{
        unsigned canCloseTCP: 1;  // flag which closes TCP socket (not relevant to UDP)
          unsigned isBroadcast: 1;  // flag which denotes that the IP package has been received via subnet broadcast address (not used for PIC16 family)
} TEthPktFlags;

void ethernetInit(void);

unsigned int SPI_Ethernet_UserTCP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthPktFlags * flags);

unsigned int SPI_Ethernet_UserUDP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthPktFlags *flags);

#endif