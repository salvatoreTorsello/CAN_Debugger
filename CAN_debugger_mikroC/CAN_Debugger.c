#include "libs/can.h"
#include "libs/dsPIC.h"
#include "modules/d_can.h"
#include "modules/ethernet.h"

int timer1Counter = 0;
unsigned char IpDestAddr[4] = {169, 254, 117, 241};

const unsigned char provaStringa[] = "dioPorcoSeee";

void init()
{
    setAllPinAsDigital();
    ethernetInit();
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

    while(1)
    {
        SPI_Ethernet_doPacket();
    }   

}

onTimer1Interrupt
{
         timer1Counter++;

    
    

        clearTimer(1);
}