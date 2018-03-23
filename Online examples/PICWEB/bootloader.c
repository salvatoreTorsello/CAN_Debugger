#build (reset=0x800, interrupt=0x808)        //code starts right after the bootloader
#org 0x0000,0x07FF void Bootloader(void){}   //don't overwrite the bootloader