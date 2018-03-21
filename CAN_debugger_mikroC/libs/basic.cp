#line 1 "C:/Users/Salvatore/Desktop/CAN Debugger/libs/basic.c"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for dspic/include/stdio.h"
#line 1 "c:/users/salvatore/desktop/can debugger/libs/basic.h"
#line 16 "c:/users/salvatore/desktop/can debugger/libs/basic.h"
void unsignedIntToString(unsigned int number, char *text);

void signedIntToString(int number, char *text);

unsigned char getNumberDigitCount(unsigned char number);

void emptyString(char* myString);

int asciiHexToInt(char* string, int lenght);
#line 8 "C:/Users/Salvatore/Desktop/CAN Debugger/libs/basic.c"
void unsignedIntToString(unsigned int number, char *text) {
 emptyString(text);
 sprintf(text, "%u", number);
}

void signedIntToString(int number, char *text) {
 emptyString(text);
 sprintf(text, "%d", number);
}

void emptyString(char *myString) {
 myString[0] = '\0';
#line 23 "C:/Users/Salvatore/Desktop/CAN Debugger/libs/basic.c"
}

unsigned char getNumberDigitCount(unsigned char number) {
 if (number >= 100) {
 return 3;
 } else if (number >= 10) {
 return 2;
 } else {
 return 1;
 }
}

int asciiHexToInt(char* string, int lenght)
{
int i;
int result=0;
 for(i=0;i<lenght;i++)
 {
 if(string[i]<='9' && string[i]>='0')
 {
 result+=(string[i]-'0')*pow(16,lenght-i-1);
 }
 else if(string[i]<='f' && string[i]>='a')
 {
 result+=(string[i]-'a'+10)*pow(16,lenght-i-1);
 }
 else if(string[i]<='F' && string[i]>='A')
 {
 result+=(string[i]-'A'+10)*pow(16,lenght-i-1);
 }
 }
 return result;
}
