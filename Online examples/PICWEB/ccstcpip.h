//////////////////////////////////////////////////////////////////////////////
//
// ccstcpip.h - Common code shared among all Embedded Internet/Embedded
// Ethernet tutorial book examples.
//
// If you are using a CCS Embedded Ethernet Board (labeled PICENS, which
// has an MCP ENC28J60) then define STACK_USE_CCS_PICENS to TRUE.
//
// If you are using a CCS Embedded Internet Board (labeled PICNET, which
// has a Realtek RTL8019AS and a 56K Modem) then define STACK_USE_CCS_PICNET
// to TRUE.
//
//////////////////////////////////////////////////////////////////////////////
//
// 10/25/06
//  - Added STACK_USE_CCS_PICEEC
//  - ExampleUDPPacket[] UDP header length fixed
//
//////////////////////////////////////////////////////////////////////////////

#define STACK_USE_CCS_PICENS   1
#define STACK_USE_MCPENC 1
#define STACK_USE_MAC 1

#include <18F4550.h>
#DEVICE ADC=10
#use delay(clock=20000000)
#fuses HS,NOWDT,NOPROTECT,NOLVP,NODEBUG,USBDIV,VREGEN,NOPBADEN,WRTB
#use rs232(baud=9600, xmit=PIN_C6, rcv=PIN_C7)

//#include "bootloader.c"
#include "tcpip/stacktsk.c"    //include Microchip TCP/IP Stack


void MACAddrInit(void) {
   MY_MAC_BYTE1=0;
   MY_MAC_BYTE2=2;
   MY_MAC_BYTE3=3;
   MY_MAC_BYTE4=4;
   MY_MAC_BYTE5=5;
   MY_MAC_BYTE6=6;
}

void IPAddrInit(void) {
   //IP address of this unit
   MY_IP_BYTE1=192;
   MY_IP_BYTE2=168;
   MY_IP_BYTE3=1;
   MY_IP_BYTE4=10;

   //network gateway
   MY_GATE_BYTE1=192;
   MY_GATE_BYTE2=168;
   MY_GATE_BYTE3=1;
   MY_GATE_BYTE4=1;

   //subnet mask
   MY_MASK_BYTE1=255;
   MY_MASK_BYTE2=255;
   MY_MASK_BYTE3=255;
   MY_MASK_BYTE4=0;
}

char ExampleIPDatagram[] = {
   0x45, 0x00, 0x00, 0x20, 0x00, 0x00, 0x00, 0x00,
   0x64, 0x11, 0x2A, 0x9D, 0x0A, 0x0B, 0x0C, 0x0D,
   0x0A, 0x0B, 0x0C, 0x0E
};

char ExampleUDPPacket[] = {
   0x04, 0x00, 0x04, 0x01, 0x00, 0x08, 0x00, 0x00,
   0x01, 0x02, 0x03, 0x04
};
