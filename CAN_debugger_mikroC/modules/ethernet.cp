#line 1 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/CAN_debugger_mikroC/modules/ethernet.c"
#line 1 "c:/users/salvatore/documents/gitkraken repositories/personali/can_debugger/can_debugger_mikroc/modules/ethernet.h"
#line 1 "c:/users/salvatore/documents/gitkraken repositories/personali/can_debugger/can_debugger_mikroc/modules/../ethv2 demo/__ethenc28j60.h"
#line 120 "c:/users/salvatore/documents/gitkraken repositories/personali/can_debugger/can_debugger_mikroc/modules/../ethv2 demo/__ethenc28j60.h"
typedef struct
 {
 unsigned char valid;
 unsigned long tmr;
 unsigned char ip[4];
 unsigned char mac[6];
 } SPI_Ethernet_arpCacheStruct;

extern SPI_Ethernet_arpCacheStruct SPI_Ethernet_arpCache[];

extern unsigned char SPI_Ethernet_macAddr[6];
extern unsigned char SPI_Ethernet_ipAddr[4];
extern unsigned char SPI_Ethernet_gwIpAddr[4];
extern unsigned char SPI_Ethernet_ipMask[4];
extern unsigned char SPI_Ethernet_dnsIpAddr[4];
extern unsigned char SPI_Ethernet_rmtIpAddr[4];

extern unsigned long SPI_Ethernet_userTimerSec;

typedef struct {
 unsigned canCloseTCP: 1;
 unsigned isBroadcast: 1;
} TEthPktFlags;
#line 147 "c:/users/salvatore/documents/gitkraken repositories/personali/can_debugger/can_debugger_mikroc/modules/../ethv2 demo/__ethenc28j60.h"
extern void SPI_Ethernet_Init(unsigned char *resetPort, unsigned char resetBit, unsigned char *CSport, unsigned char CSbit, unsigned char *mac, unsigned char *ip, unsigned char fullDuplex);
extern unsigned char SPI_Ethernet_doPacket();
extern void SPI_Ethernet_putByte(unsigned char b);
extern void SPI_Ethernet_putBytes(unsigned char *ptr, unsigned int n);
extern void SPI_Ethernet_putConstBytes(const unsigned char *ptr, unsigned int n);
extern unsigned char SPI_Ethernet_getByte();
extern void SPI_Ethernet_getBytes(unsigned char *ptr, unsigned int addr, unsigned int n);
extern unsigned int SPI_Ethernet_UserUDP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength);
extern unsigned int SPI_Ethernet_UserTCP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, char * canClose);
extern void SPI_Ethernet_confNetwork(char *ipMask, char *gwIpAddr, char *dnsIpAddr);
#line 15 "c:/users/salvatore/documents/gitkraken repositories/personali/can_debugger/can_debugger_mikroc/modules/ethernet.h"
sfr sbit SPI_Ethernet_Rst at RE8_bit;
sfr sbit SPI_Ethernet_CS at RD3_bit;
sfr sbit SPI_Ethernet_Rst_Direction at TRISE8_bit;
sfr sbit SPI_Ethernet_CS_Direction at TRISD3_bit;
#line 26 "c:/users/salvatore/documents/gitkraken repositories/personali/can_debugger/can_debugger_mikroc/modules/ethernet.h"
void ethernetInit(void);

unsigned int SPI_Ethernet_UserTCP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthPktFlags *flags);
#line 5 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/CAN_debugger_mikroC/modules/ethernet.c"
unsigned char myMacAddr[6] = {0x00, 0x14, 0xA5, 0x76, 0x19, 0x00};
unsigned char myIpAddr[4] = {192, 168, 0, 170};

const unsigned char provaStringa[] = "dioPorcoSeee";

void ethernetInit(void)
{
 SPI1_Init();
 SPI_Ethernet_Init(myMacAddr, myIpAddr,  0x01 );

}

unsigned int SPI_Ethernet_UserTCP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthPktFlags *flags)
{
 unsigned int len = 0 ;
 unsigned int i ;

 if(localPort != 1808)
 {
 return(0) ;
 }

 if(len == 0)
 {
 len =  SPI_Ethernet_putConstString (provaStringa);
 }

 return(len) ;


}
