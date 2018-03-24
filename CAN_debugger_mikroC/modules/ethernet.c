//ethernet.c created on 23-03 02:04

#include "ethernet.h"

#define SPI_Ethernet_FULLDUPLEX 1

unsigned char   myMacAddr[6] = {0x00, 0x14, 0xA5, 0x76, 0x19, 0x3F};   // my MAC address
unsigned char   myIpAddr[4]  = {192, 168, 20, 170};                     // my IP address
unsigned char gwIpAddr[4] = {192, 168, 20, 6 };                        // gateway (router) IP address
unsigned char ipMask[4] = {255, 255, 255, 0 };                         // network mask
unsigned char dnsIpAddr[4] = {192, 168, 20, 1 };                       // DNS server IP address
//char *buffer =  "dioPorcoSeee";

void ethernetInit(void)
{  
  SPI1_Init(); 
  SPI_Ethernet_Init(myMacAddr, myIpAddr, SPI_Ethernet_FULLDUPLEX);
  SPI_Ethernet_confNetwork(ipMask, gwIpAddr, dnsIpAddr);
}

unsigned int  SPI_Ethernet_UserTCP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthPktFlags *flags)
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