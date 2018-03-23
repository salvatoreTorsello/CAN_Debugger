#line 1 "C:/Users/Salvatore/Desktop/CAN Debugger/libs/eGlcd.c"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for dspic/include/string.h"





void * memchr(void *p, char n, unsigned int v);
int memcmp(void *s1, void *s2, int n);
void * memcpy(void * d1, void * s1, int n);
void * memmove(void * to, void * from, int n);
void * memset(void * p1, char character, int n);
char * strcat(char * to, char * from);
char * strchr(char * ptr, char chr);
int strcmp(char * s1, char * s2);
char * strcpy(char * to, char * from);
int strlen(char * s);
char * strncat(char * to, char * from, int size);
char * strncpy(char * to, char * from, int size);
int strspn(char * str1, char * str2);
char strcspn(char * s1, char * s2);
int strncmp(char * s1, char * s2, char len);
char * strpbrk(char * s1, char * s2);
char * strrchr(char *ptr, char chr);
char * strstr(char * s1, char * s2);
char * strtok(char * s1, char * s2);
#line 1 "c:/users/salvatore/desktop/can debugger/libs/eglcd.h"
#line 34 "c:/users/salvatore/desktop/can debugger/libs/eglcd.h"
float EGLCD_TIMER_COEFFICIENT = 4;
#line 55 "c:/users/salvatore/desktop/can debugger/libs/eglcd.h"
unsigned char BLACK, WHITE;
const unsigned char INVERT =  2 ;





void eGlcd_init(void);

void eGlcd_invertColors(void);

void eGlcd_clear(void);

void eGlcd_fill(unsigned char color);

void eGlcd_overwriteChar(char oldChar, char newChar, unsigned char x, unsigned char y);

void eGlcd_clearChar(char letter, unsigned char x, unsigned char y);

void eGlcd_writeChar(char letter, unsigned char x, unsigned char y);

void eGlcd_overwriteText(char *oldText, char *newText, unsigned char x, unsigned char y);

void eGlcd_clearText(char *text, unsigned char x, unsigned char y);

void eGlcd_writeText(char *text, unsigned char x, unsigned char y);

void eGlcd_setupTimer(void);

void eGlcd_setTimerCoefficient(float coefficient);

unsigned int eGlcd_getTextPixelLength(char *text);
#line 97 "c:/users/salvatore/desktop/can debugger/libs/eglcd.h"
void xGlcd_Set_Font(const char *ptrFontTbl, unsigned short font_width,
 unsigned short font_height, unsigned int font_offset);

void xGLCD_Write_Data(unsigned short pX, unsigned short pY, unsigned short pData);

unsigned short xGlcd_Write_Char(unsigned short ch, unsigned short x, unsigned short y, unsigned short color);

unsigned short xGlcd_Char_Width(unsigned short ch);

void xGlcd_Write_Text(char *text, unsigned short x, unsigned short y, unsigned short color);

unsigned short xGlcd_Text_Width(char *text);

void xGLCD_Set_Transparency(char active);
#line 1 "c:/users/salvatore/desktop/can debugger/libs/basic.h"
#line 16 "c:/users/salvatore/desktop/can debugger/libs/basic.h"
void unsignedIntToString(unsigned int number, char *text);

void signedIntToString(int number, char *text);

unsigned char getNumberDigitCount(unsigned char number);

void emptyString(char* myString);

int asciiHexToInt(char* string, int lenght);
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
#line 1 "c:/users/salvatore/desktop/can debugger/libs/glcdpins.c"

 sbit GLCD_D0 at RB8_bit;
 sbit GLCD_D1 at RB0_bit;
 sbit GLCD_D2 at RB1_bit;
 sbit GLCD_D3 at RB2_bit;
 sbit GLCD_D4 at RB3_bit;
 sbit GLCD_D5 at RB4_bit;
 sbit GLCD_D6 at RB5_bit;
 sbit GLCD_D7 at RG9_bit;

 sbit GLCD_D0_Direction at TRISB8_bit;
 sbit GLCD_D1_Direction at TRISB0_bit;
 sbit GLCD_D2_Direction at TRISB1_bit;
 sbit GLCD_D3_Direction at TRISB2_bit;
 sbit GLCD_D4_Direction at TRISB3_bit;
 sbit GLCD_D5_Direction at TRISB4_bit;
 sbit GLCD_D6_Direction at TRISB5_bit;
 sbit GLCD_D7_Direction at TRISG9_bit;

 sbit GLCD_CS1 at LATG8_bit;
 sbit GLCD_CS2 at LATG7_bit;
 sbit GLCD_RST at LATG6_bit;
 sbit GLCD_RW at LATC2_bit;
 sbit GLCD_RS at LATC1_bit;
 sbit GLCD_EN at LATG15_bit;

 sbit GLCD_CS1_Direction at TRISG8_bit;
 sbit GLCD_CS2_Direction at TRISG7_bit;
 sbit GLCD_RST_Direction at TRISG6_bit;
 sbit GLCD_RW_Direction at TRISC2_bit;
 sbit GLCD_RS_Direction at TRISC1_bit;
 sbit GLCD_EN_Direction at TRISG15_bit;
#line 20 "C:/Users/Salvatore/Desktop/CAN Debugger/libs/eGlcd.c"
const unsigned short xColorClear = 0;
const unsigned short xColorSet = 1;
const unsigned short xColorInvert = 2;


const char *xGlcdSelFont;

unsigned short xGlcdX, xGlcdY, xGlcdSelFontHeight,
 xGlcdSelFontWidth, xGlcdSelFontOffset,
 xGlcdSelFontNbRows;

char xGLCD_Transparency;

void eGlcd_init() {
 BLACK =  1 ;
 WHITE =  0 ;
 Glcd_Init();
 if ( 32  >  80 ) {
 eGlcd_setupTimer();
 }
}

void eGlcd_invertColors(void) {
 if (BLACK ==  0 ) {
 BLACK =  1 ;
 WHITE =  0 ;
 } else {
 BLACK =  0 ;
 WHITE =  1 ;
 }
}

void eGlcd_clear(void) {
 eGlcd_fill(WHITE);
}

void eGlcd_fill(unsigned char color) {
 if (color) {
  Glcd_Fill(0xFF) ;
 } else {
  Glcd_Fill(0x00) ;
 }
}


void eGlcd_overwriteChar(char oldChar, char newChar, unsigned char x, unsigned char y) {
 eGlcd_clearChar(oldChar, x, y);
 eGlcd_writeChar(newChar, x, y);
}

void eGlcd_clearChar(char letter, unsigned char x, unsigned char y) {
 if (BLACK) {
 xGlcd_Write_Char(letter, x, y, WHITE);
 } else {
 xGLCD_Set_Transparency( 1 );
 xGlcd_Write_Char(letter, x, y, WHITE);
 xGLCD_Set_Transparency( 0 );
 }
}

void eGlcd_writeChar(char letter, unsigned char x, unsigned char y) {
 if (BLACK) {
 xGlcd_Write_Char(letter, x, y, BLACK);
 } else {
 xGlcd_Write_Char(letter, x, y, INVERT);
 }
}

void eGlcd_overwriteText(char *oldText, char *newText, unsigned char x, unsigned char y) {
 eGlcd_clearText(oldText, x, y);
 eGlcd_writeText(newText, x, y);
}

void eGlcd_clearText(char *text, unsigned char x, unsigned char y) {
 if (BLACK) {
 xGlcd_Write_Text(text, x, y, WHITE);
 } else {
 xGLCD_Set_Transparency( 1 );
 xGlcd_Write_Text(text, x, y, WHITE);
 xGLCD_Set_Transparency( 0 );
 }
}

void eGlcd_writeText(char *text, unsigned char x, unsigned char y) {
 if (BLACK) {
 xGlcd_Write_Text(text, x, y, BLACK);
 } else {
 xGlcd_Write_Text(text, x, y, INVERT);
 }
}

void eGlcd_setupTimer(void) {
 setTimer( 3 ,  ( ((6.2 - 4) / (80 - 64))  * (0.025 * EGLCD_TIMER_COEFFICIENT * 10) * ( (4/ ((6.2 - 4) / (80 - 64)) ) + 80  - 32 ))  * 0.000001);
 setInterruptPriority( 3 ,  5 );
 turnOffTimer( 3 );
}

void eGlcd_setTimerCoefficient(float coefficient) {
 EGLCD_TIMER_COEFFICIENT = coefficient;
}

unsigned int eGlcd_getTextPixelLength(char *text) {
 unsigned int textPixelLength, i;
 textPixelLength = 0;
 for (i = 0; i < strlen(text); i += 1) {
 textPixelLength = textPixelLength + xGlcd_Char_Width(text[i]);
 }
 return textPixelLength;
}






void xGlcd_Set_Font(const char *ptrFontTbl, unsigned short font_width,
 unsigned short font_height, unsigned int font_offset) {
 xGlcdSelFont = ptrFontTbl;
 xGlcdSelFontWidth = font_width;
 xGlcdSelFontHeight = font_height;
 xGlcdSelFontOffset = font_offset;
 xGLCD_Transparency =  0 ;
 xGlcdSelFontNbRows = xGlcdSelFontHeight / 8;
 if (xGlcdSelFontHeight % 8) xGlcdSelFontNbRows++;
}


void xGLCD_Write_Data(unsigned short pX, unsigned short pY, unsigned short pData) {
 unsigned short tmp, tmpY, gData, dataR, xx, yy;

 if ((pX > 127) || (pY > 63)) return;
 xx = pX % 64;
 tmp = pY / 8;
 if (tmp > 7) return;
 tmpY = pY % 8;
 if (tmpY) {

 gData = pData << tmpY;
  Glcd_Set_Side(pX); Glcd_Set_X(xx); Glcd_Set_Page(tmp); dataR = Glcd_Read_Data(); dataR = Glcd_Read_Data(); ;
#line 163 "C:/Users/Salvatore/Desktop/CAN Debugger/libs/eGlcd.c"
 if (!xGLCD_Transparency)
 dataR = dataR & (0xff >> (8 - tmpY));
 dataR = gData | dataR;
  Glcd_Set_X(xx); Glcd_Write_Data(dataR); ;
#line 169 "C:/Users/Salvatore/Desktop/CAN Debugger/libs/eGlcd.c"
 tmp++;
 if (tmp > 7) return;
  Glcd_Set_X(xx); Glcd_Set_Page(tmp); gData = pData >> (8 - tmpY); dataR = Glcd_Read_Data(); dataR = Glcd_Read_Data(); ;
#line 176 "C:/Users/Salvatore/Desktop/CAN Debugger/libs/eGlcd.c"
 if (!xGLCD_Transparency)
 dataR = dataR & (0xff << tmpY);
 dataR = gData | dataR;
  Glcd_Set_X(xx); Glcd_Write_Data(dataR); ;
#line 181 "C:/Users/Salvatore/Desktop/CAN Debugger/libs/eGlcd.c"
 }
 else {
  Glcd_Set_Side(pX); Glcd_Set_X(xx); Glcd_Set_Page(tmp); ;
#line 186 "C:/Users/Salvatore/Desktop/CAN Debugger/libs/eGlcd.c"
 if (xGLCD_Transparency) {
  dataR = Glcd_Read_Data(); dataR = Glcd_Read_Data(); dataR = pData | dataR; ;
#line 190 "C:/Users/Salvatore/Desktop/CAN Debugger/libs/eGlcd.c"
 }
 else
 dataR = pData;
  Glcd_Set_X(xx); Glcd_Write_Data(dataR); ;
#line 195 "C:/Users/Salvatore/Desktop/CAN Debugger/libs/eGlcd.c"
 }
}

unsigned short xGlcd_Write_Char(unsigned short ch, unsigned short x, unsigned short y, unsigned short color) {
 const char *CurCharData;
 unsigned short i, j, CharWidth, CharData;
 unsigned long cOffset;

 cOffset = xGlcdSelFontWidth * xGlcdSelFontNbRows + 1;
 cOffset = cOffset * (ch - xGlcdSelFontOffset);
 CurCharData = xGlcdSelFont + cOffset;
 CharWidth = *CurCharData;
 cOffset++;
 for (i = 0; i < CharWidth; i++)
 for (j = 0; j < xGlcdSelFontNbRows; j++) {
 CurCharData = xGlcdSelFont + (i * xGlcdSelFontNbRows) + j + cOffset;
 switch (color) {
 case 0 :
 CharData = 0;
 break;
 case 1 :
 CharData = *CurCharData;
 break;
 case 2 :
 CharData = ~(*CurCharData);
 break;
 }
 xGLCD_Write_Data(x + i, y + j * 8, CharData);
 };
 return CharWidth;
}

unsigned short xGlcd_Char_Width(unsigned short ch) {
 const char *CurCharDt;
 unsigned long cOffset;
 cOffset = xGlcdSelFontWidth * xGlcdSelFontNbRows + 1;
 cOffset = cOffset * (ch - xGlcdSelFontOffset);
 CurCharDt = xGlcdSelFont + cOffset;
 return *CurCharDt;
}

void xGlcd_Write_Text(char *text, unsigned short x, unsigned short y, unsigned short color) {
 unsigned short i, l, posX;
 char *curChar;
 l = strlen(text);
 posX = x;
 curChar = text;
 for (i = 0; i < l; i++) {
 posX = posX + xGlcd_Write_Char(*curChar, posX, y, color) + 1;
 curChar++;
 }
}

unsigned short xGlcd_Text_Width(char *text) {
 unsigned short i, l, w;
 l = strlen(text);
 w = 0;
 for (i = 0; i < l; i++)
 w = w + xGlcd_Char_Width(text[i]) + 1;
 return w;
}

void xGLCD_Set_Transparency(char active) {
 xGLCD_Transparency = active;
}
