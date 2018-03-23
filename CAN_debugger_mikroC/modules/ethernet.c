//ethernet.c created on 23-03 02:04

#include "ethernet.h"

unsigned char   myMacAddr[6] = {0x00, 0x14, 0xA5, 0x76, 0x19, 0x00};   // my MAC address
unsigned char   myIpAddr[4]  = {192, 168, 0, 170};                     // my IP address
//char *buffer =  "dioPorcoSeee";
const unsigned char provaStringa[] = "dioPorcoSeee";

void ethernetInit(void)
{
    SPI1_Init();
    SPI_Ethernet_Init(myMacAddr, myIpAddr, Spi_Ethernet_FULLDUPLEX);
    //SPI_Ethernet_24j600_Enable(_SPI_Ethernet_24j600_MULTICAST);
}

unsigned int  SPI_Ethernet_UserTCP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthPktFlags *flags)
{
	unsigned int    len = 0 ;                   // my reply length
  	unsigned int    i ;                         // general purpose integer

	if(localPort != 1808)
  	{                        // I listen only to web request on port 1808
    	return(0) ;
  	}

  	if(len == 0)
  	{           // what do to by default
    	len = putConstString(provaStringa);
  	}

  	return(len) ;                               // return to the library with the number of bytes to transmit


}