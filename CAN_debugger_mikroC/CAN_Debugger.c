#include "libs/can.h"
#include "libs/dsPIC.h"
#include "modules/d_can.h"

#define BAUDRATE 9600

int timer1Counter = 0;
short flag = 0;

void init()
{
    setAllPinAsDigital();
    //Can_Init();
    UART1_Init(BAUDRATE);
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
    	if(timer1Counter % 2 == 0)
		{
    		UART1_Write_Text("Acceso");
     		PORTEbits.RE0 = 1;
    	}
        /*PORTEbits.RE0 = 0;
        delay_ms(1000);
        PORTEbits.RE0 = 1;
        delay_ms(1000);*/
    }
}

void onUART1Ready() iv IVT_ADDR_U1RXINTERRUPT ics ICS_AUTO 
{
	char * output;

	flag = strcmp(output, "Acceso");

	IFS0bits.U1RXIF = 0;	//clear U1RX interrupt flag
}

onTimer1Interrupt
{
 	timer1Counter++;	
	
	if(flag && timer1Counter % 2 == 0)
	{
		
	}


    clearTimer(1);
}

/*onTimer1Interrupt
{
    switch(PORTEbits.RE0)
    {
        case 1:
            UART1_Write_Text("Acceso\0");
            break;
        case 0:
            UART1_Write_Text("Spento\0");
            break;
    }

    PORTEbits.RE0 = ~PORTEbits.RE0;
    clearTimer(1);
}*/