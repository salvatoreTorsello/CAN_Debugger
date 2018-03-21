#line 1 "C:/Users/Salvatore/Desktop/CAN Debugger/CAN_Debugger.c"
#line 1 "c:/users/salvatore/desktop/can debugger/libs/can.h"
#line 48 "c:/users/salvatore/desktop/can debugger/libs/can.h"
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
#line 1 "c:/users/salvatore/desktop/can debugger/libs/dspic.h"
#line 1 "c:/users/salvatore/desktop/can debugger/libs/basic.h"
#line 16 "c:/users/salvatore/desktop/can debugger/libs/basic.h"
void unsignedIntToString(unsigned int number, char *text);

void signedIntToString(int number, char *text);

unsigned char getNumberDigitCount(unsigned char number);

void emptyString(char* myString);

int asciiHexToInt(char* string, int lenght);
#line 171 "c:/users/salvatore/desktop/can debugger/libs/dspic.h"
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
#line 1 "c:/users/salvatore/desktop/can debugger/modules/d_can.h"
#line 7 "C:/Users/Salvatore/Desktop/CAN Debugger/CAN_Debugger.c"
int timer1Counter = 0;

void init()
{
 setAllPinAsDigital();

 UART1_Init( 9600 );
 setTimer(1, 0.5);

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
 UART1_Write_Text("Acceso");

 while(1)
 {
#line 37 "C:/Users/Salvatore/Desktop/CAN Debugger/CAN_Debugger.c"
 }
}

void onUART1Ready() iv IVT_ADDR_U1RXINTERRUPT ics ICS_AUTO
{
if(timer1Counter % 2 != 1){
 char * output;

 UART1_Read_Text(output, '\0', 255);

 PORTEbits.RE0 = strcmp(output, "Acceso") == 1 ? 0 : 0;

 IFS0bits.U1RXIF = 0;

 }

}

 void timer1_interrupt() iv IVT_ADDR_T1INTERRUPT ics ICS_AUTO 
{
 timer1Counter++;
if(timer1Counter % 2 == 0){
 UART1_Write_Text("Acceso");
 PORTEbits.RE0 = 1;
 }
}
