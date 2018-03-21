#line 1 "C:/Users/Salvatore/Desktop/CAN Debugger/libs/eeprom.c"
#line 1 "c:/users/salvatore/desktop/can debugger/libs/eeprom.h"









void EEPROM_writeInt(unsigned int address, unsigned int value);

unsigned int EEPROM_readInt(unsigned int address);

void EEPROM_writeArray(unsigned int address, unsigned int *values);

void EEPROM_readArray(unsigned int address, unsigned int *values);
#line 7 "C:/Users/Salvatore/Desktop/CAN Debugger/libs/eeprom.c"
void EEPROM_writeInt(unsigned int address, unsigned int value) {
 unsigned int currentValue;


 EEPROM_write(address, value);
 while(WR_bit);

}

unsigned int EEPROM_readInt(unsigned int address) {
 return EEPROM_read(address);
}

void EEPROM_writeArray(unsigned int address, unsigned int *values) {
 unsigned int i;
 for (i = 0; i < sizeof(values); i += 1) {
 EEPROM_writeInt(address, values[i]);
 }
}

void EEPROM_readArray(unsigned int address, unsigned int *values) {
 unsigned int i;
 for (i = 0; i < sizeof(values); i += 1) {
 values[i] = EEPROM_read(address + i);
 }
}
