#include "libs/can.h"
#include "libs/dsPIC.h"
#include "modules/d_can.h"
#include "modules/ethernet.h"


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

onTimer1Interrupt
{
 	timer1Counter++;


    

	clearTimer(1);
}