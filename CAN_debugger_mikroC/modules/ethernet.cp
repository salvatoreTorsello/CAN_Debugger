#line 1 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/CAN_debugger_mikroC/modules/ethernet.c"
#line 1 "c:/users/salvatore/documents/gitkraken repositories/personali/can_debugger/can_debugger_mikroc/modules/ethernet.h"







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
 unsigned canCloseTCP: 1;
 unsigned isBroadcast: 1;
} TEthPktFlags;

void ethernetInit(void);

unsigned int SPI_Ethernet_UserTCP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthPktFlags * flags);

unsigned int SPI_Ethernet_UserUDP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthPktFlags *flags);
#line 7 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/CAN_debugger_mikroC/modules/ethernet.c"
unsigned char myMacAddr[6] = {0x00, 0x14, 0xA5, 0x76, 0x19, 0x3F};
unsigned char myIpAddr[4] = {192, 168, 20, 170};
unsigned char gwIpAddr[4] = {192, 168, 20, 6 };
unsigned char ipMask[4] = {255, 255, 255, 0 };
unsigned char dnsIpAddr[4] = {192, 168, 20, 1 };


void ethernetInit(void)
{
 SPI1_Init();
 SPI_Ethernet_Init(myMacAddr, myIpAddr,  1 );
 SPI_Ethernet_confNetwork(ipMask, gwIpAddr, dnsIpAddr);
}

unsigned int SPI_Ethernet_UserTCP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthPktFlags *flags)
{
 if(localPort == 1808)
 {
 PORTEbits.RE0 = ~PORTEbits.RE0;
 return 5;
 }
 return 0;
}

unsigned int SPI_Ethernet_UserUDP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthPktFlags *flags)
{
 return 0;
}
