//ethernet.c created on 23-03 02:04

void ethernetInit(void)
{
	SPI1Init();
	SPI_Ethernet_24j600_Init(myMacAddr, myIpAddr, SPI_Ethernet_24j600_MANUAL_NEGOTIATION & SPI_Ethernet_24j600_FULLDUPLEX & SPI_Ethernet_24j600_SPD100);
}

