#include "libs/can.h"
#include "libs/dsPIC.h"
#include "modules/d_can.h"

int timer1Counter = 0;

unsignet

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
    	
    }
}

onTimer1Interrupt
{
 	timer1Counter++;	
	
	if()
	{
		
	}


    clearTimer(1);
}