#line 1 "C:/Users/Salvatore/Desktop/CAN Debugger/libs/buttons.c"
#line 1 "c:/users/salvatore/desktop/can debugger/libs/buttons.h"
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
#line 50 "c:/users/salvatore/desktop/can debugger/libs/buttons.h"
void button_onR1Down(void);

void button_onR2Down(void);

void button_onR3Down(void);

void button_onL1Down(void);

void button_onL2Down(void);

void button_onL3Down(void);

void button_onBRDown(void);

void button_onBLDown(void);

void button_onCDown(void);

void Buttons_init(void);

void Buttons_protractPress(unsigned char button, unsigned int milliseconds);

void Buttons_tick(void);

char Buttons_isPressureProtracted(void);

void Buttons_clearPressureProtraction(void);
#line 10 "C:/Users/Salvatore/Desktop/CAN Debugger/libs/buttons.c"
 void external0() iv IVT_ADDR_INT0INTERRUPT ics ICS_AUTO {
 Delay_ms( 1 );
 if ( RF3_bit  ==  0 ) {
 button_onBRDown();
 } else if ( RF2_bit  ==  0 ) {
 button_onBLDown();
 }
 clearExternalInterrupt( 4 );
}

 void external1() iv IVT_ADDR_INT1INTERRUPT ics ICS_AUTO {
 Delay_ms( 1 );
 if ( RB11_bit  ==  0 ) {
 button_onL1Down();
 } else if ( RB12_bit  ==  0 ) {
 button_onL2Down();
 } else if ( RG2_bit  ==  0 ) {
 button_onL3Down();
 }
 clearExternalInterrupt( 5 );
}

 void external2() iv IVT_ADDR_INT2INTERRUPT ics ICS_AUTO {
 Delay_ms( 1 );
 if ( RB9_bit  ==  0 ) {
 button_onR1Down();
 } else if ( RB10_bit  ==  0 ) {
 button_onR2Down();
 } else if ( RG3_bit  ==  0 ) {
 button_onR3Down();
 }
 clearExternalInterrupt( 6 );
}

 void external4() iv IVT_ADDR_INT4INTERRUPT ics ICS_AUTO {
 Delay_ms( 1 );
 button_onCDown();
 clearExternalInterrupt( 8 );
}

void Buttons_init(void) {
  TRISB9_bit  =  1 ;
  TRISB10_bit  =  1 ;
  TRISG3_bit  =  1 ;
  TRISB11_bit  =  1 ;
  TRISB12_bit  =  1 ;
  TRISG2_bit  =  1 ;
  TRISF2_bit  =  1 ;
  TRISF3_bit  =  1 ;

 setExternalInterrupt( 4 ,  1 );
 setExternalInterrupt( 5 ,  1 );
 setExternalInterrupt( 6 ,  1 );
 setExternalInterrupt( 8 ,  1 );
}

unsigned int buttons_pressureProtraction = 0;
unsigned char buttons_pressureProtractionButton;
char buttons_pressureProtractionFlag =  0 ;

void Buttons_protractPress(unsigned char button, unsigned int milliseconds) {
 if (!Buttons_isPressureProtracted()) {
 buttons_pressureProtraction = milliseconds;
 buttons_pressureProtractionButton = button;
 buttons_pressureProtractionFlag =  1 ;
 }
}

void Buttons_tick(void) {
 if (buttons_pressureProtraction > 0) {
 buttons_pressureProtraction -= 1;
 if (buttons_pressureProtraction == 0) {
 switch (buttons_pressureProtractionButton) {
 case  0 :
 button_onR1Down();
 break;
 case  1 :
 button_onR2Down();
 break;
 case  2 :
 button_onR3Down();
 break;
 case  3 :
 button_onL1Down();
 break;
 case  4 :
 button_onL2Down();
 break;
 case  5 :
 button_onL3Down();
 break;
 case  7 :
 button_onBLDown();
 break;
 case  6 :
 button_onBRDown();
 break;
 default:
 break;
 }
 } else {
 switch (buttons_pressureProtractionButton) {
 case  0 :
 if ( RB9_bit  !=  0 ) {
 buttons_pressureProtraction = 0;
 Buttons_clearPressureProtraction();
 }
 break;
 case  1 :
 if ( RB10_bit  !=  0 ) {
 buttons_pressureProtraction = 0;
 Buttons_clearPressureProtraction();
 }
 break;
 case  2 :
 if ( RG3_bit  !=  0 ) {
 buttons_pressureProtraction = 0;
 Buttons_clearPressureProtraction();
 }
 break;
 case  3 :
 if ( RB11_bit  !=  0 ) {
 buttons_pressureProtraction = 0;
 Buttons_clearPressureProtraction();
 }
 break;
 case  4 :
 if ( RB12_bit  !=  0 ) {
 buttons_pressureProtraction = 0;
 Buttons_clearPressureProtraction();
 }
 break;
 case  5 :
 if ( RG2_bit  !=  0 ) {
 buttons_pressureProtraction = 0;
 Buttons_clearPressureProtraction();
 }
 break;
 case  7 :
 if ( RF2_bit  !=  0 ) {
 buttons_pressureProtraction = 0;
 Buttons_clearPressureProtraction();
 }
 break;
 case  6 :
 if ( RF3_bit  !=  0 ) {
 buttons_pressureProtraction = 0;
 Buttons_clearPressureProtraction();
 }
 break;
 default:
 break;
 }
 }
 }
}

char Buttons_isPressureProtracted(void) {
 return buttons_pressureProtractionFlag;
}

void Buttons_clearPressureProtraction(void) {
 buttons_pressureProtractionFlag =  0 ;
}
