#line 1 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/CAN_debugger_mikroC/CAN_Debugger.c"
#line 1 "c:/users/salvatore/documents/gitkraken repositories/personali/can_debugger/can_debugger_mikroc/libs/can.h"
#line 48 "c:/users/salvatore/documents/gitkraken repositories/personali/can_debugger/can_debugger_mikroc/libs/can.h"
void Can_init(void);

void Can_read(unsigned long int *id, char dataBuffer[], unsigned int *dataLength, unsigned int *inFlags);

void Can_writeByte(unsigned long int id, unsigned char dataOut);

void Can_writeInt(unsigned long int id, int dataOut);

void Can_addIntToWritePacket(int dataOut);

void Can_addByteToWritePacket(unsigned char dataOut);

void Can_write(unsigned long int id);

void Can_setWritePriority(unsigned int txPriority);

void Can_resetWritePacket(void);

unsigned int Can_getWriteFlags(void);

unsigned char Can_B0hasBeenReceived(void);

unsigned char Can_B1hasBeenReceived(void);

void Can_clearB0Flag(void);

void Can_clearB1Flag(void);

void Can_clearInterrupt(void);

void Can_initInterrupt(void);
#line 1 "c:/users/salvatore/documents/gitkraken repositories/personali/can_debugger/can_debugger_mikroc/libs/dspic.h"
#line 1 "c:/users/salvatore/documents/gitkraken repositories/personali/can_debugger/can_debugger_mikroc/libs/basic.h"
#line 16 "c:/users/salvatore/documents/gitkraken repositories/personali/can_debugger/can_debugger_mikroc/libs/basic.h"
void unsignedIntToString(unsigned int number, char *text);

void signedIntToString(int number, char *text);

unsigned char getNumberDigitCount(unsigned char number);

void emptyString(char* myString);

int asciiHexToInt(char* string, int lenght);
#line 171 "c:/users/salvatore/documents/gitkraken repositories/personali/can_debugger/can_debugger_mikroc/libs/dspic.h"
void setAllPinAsDigital(void);

void setInterruptPriority(unsigned char device, unsigned char priority);

void setExternalInterrupt(unsigned char device, char edge);

void switchExternalInterruptEdge(unsigned char);

char getExternalInterruptEdge(unsigned char);

void clearExternalInterrupt(unsigned char);

void setTimer(unsigned char device, double timePeriod);

void clearTimer(unsigned char device);

void turnOnTimer(unsigned char device);

void turnOffTimer(unsigned char device);

unsigned int getTimerPeriod(double timePeriod, unsigned char prescalerIndex);

unsigned char getTimerPrescaler(double timePeriod);

double getExactTimerPrescaler(double timePeriod);

void setupAnalogSampling(void);

void turnOnAnalogModule();

void turnOffAnalogModule();

void startSampling(void);

unsigned int getAnalogValue(void);

void setAnalogPIN(unsigned char pin);

void unsetAnalogPIN(unsigned char pin);

void setAnalogInterrupt(void);

void unsetAnalogInterrupt(void);

void clearAnalogInterrupt(void);


void setAutomaticSampling(void);

void unsetAutomaticSampling(void);


void setAnalogVoltageReference(unsigned char mode);

void setAnalogDataOutputFormat(unsigned char adof);

int getMinimumAnalogClockConversion(void);
#line 1 "c:/users/salvatore/documents/gitkraken repositories/personali/can_debugger/can_debugger_mikroc/modules/d_can.h"
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
#line 7 "C:/Users/Salvatore/Documents/gitKraken repositories/Personali/CAN_Debugger/CAN_debugger_mikroC/CAN_Debugger.c"
int timer1Counter = 0;

void init()
{
 setAllPinAsDigital();
 ethernetInit();
 setTimer(1, 1);

 delay_ms(200);
}

void setPort()
{
 TRISEbits.TRISE0 = 0;
}

void main()
{
 init();
 setPort();
 turnOnTimer(1);



 while(1)
 {
 delay_ms(500);
 PORTEbits.RE0 = ~PORTEbits.RE0;
 }


}

 void timer1_interrupt() iv IVT_ADDR_T1INTERRUPT ics ICS_AUTO 
{
 timer1Counter++;




 clearTimer(1);
}
