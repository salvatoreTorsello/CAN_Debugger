//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
/* 

Graphic LCD Nokia 3310 (LPH7779) routines v3 
CCS compiler 


by Michel Bavin 2004 --- bavin@skynet.be --- http://users.skynet.be/bk317494/ --- 
august 29, 2004 

*/ 

// ex: 
// 
// ... 
// nokia_init(); 
// ... 
// nokia_gotoxy(0,0); 
// printf(nokia_printchar,"test???"); 
// ... 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 

#define nok_sck   PIN_B0  // Pino de Clock do LCD
#define nok_sdin  PIN_B1  // Pino de Dados do LCD
#define nok_dc    PIN_B2  // Pino de Sele��o entre Dados e Comandos
#define nok_sce   PIN_B3  // Pino de Sele��o do LCD
#define nok_res   PIN_B5  // Pino de Reset do LCD 

char char_row,charsel,charpos,chardata;       // for nokia_3310 lcd 
int16 ddram; 
//char plot_value; 
int32 plot_value32; 
int32 plot_umsb,plot_lmsb,plot_ulsb,plot_llsb; 


BYTE const TABLE1[240]= {                  // Tabela ASCII caracteres 5x5 pixels
        0x00, 0x00, 0x00, 0x00, 0x00,      // Espa�o
        0x00, 0x00, 0x2E, 0x00, 0x00,      // !
        0x00, 0x06, 0x00, 0x06, 0x00,      // "
        0x14, 0x3E, 0x14, 0x3E, 0x14,      // #
        0x24, 0x0A, 0x1E, 0x2A, 0x12,      // $
        0x22, 0x10, 0x08, 0x04, 0x22,      // %
        0x14, 0x2A, 0x2A, 0x3C, 0x28,      // &
        0x00, 0x06, 0x00, 0x00, 0x00,      // '
        0x00, 0x1C, 0x22, 0x00, 0x00,      // (
        0x00, 0x00, 0x22, 0x1C, 0x00,      // )
        0x14, 0x08, 0x3E, 0x08, 0x14,      // *
        0x00, 0x08, 0x1C, 0x08, 0x00,      // +
        0x00, 0x10, 0x30, 0x00, 0x00,      // ,
        0x00, 0x08, 0x08, 0x08, 0x00,      // -
        0x00, 0x00, 0x20, 0x00, 0x00,      // .
        0x20, 0x10, 0x08, 0x04, 0x02,      // /
        0x1C, 0x32, 0x2A, 0x26, 0x1C,      // 0
        0x00, 0x24, 0x3E, 0x20, 0x00,      // 1
        0x32, 0x2A, 0x2A, 0x2A, 0x24,      // 2
        0x22, 0x22, 0x2A, 0x2A, 0x14,      // 3
        0x06, 0x08, 0x08, 0x08, 0x3E,      // 4
        0x2E, 0x2A, 0x2A, 0x2A, 0x12,      // 5
        0x1C, 0x2A, 0x2A, 0x2A, 0x12,      // 6
        0x02, 0x02, 0x02, 0x3A, 0x06,      // 7
        0x14, 0x2A, 0x2A, 0x2A, 0x14,      // 8
        0x04, 0x0A, 0x2A, 0x2A, 0x1C,      // 9
        0x00, 0x00, 0x28, 0x00, 0x00,      // :
        0x00, 0x00, 0x28, 0x00, 0x00,      // ;
        0x00, 0x08, 0x14, 0x22, 0x00,      // <
        0x14, 0x14, 0x14, 0x14, 0x14,      // =
        0x00, 0x22, 0x14, 0x08, 0x00,      // >
        0x04, 0x02, 0x2A, 0x0A, 0x04,      // ?
        0x1C, 0x22, 0x2A, 0x12, 0x1C,      // @
        0x3C, 0x0A, 0x0A, 0x0A, 0x3C,      // A
        0x3E, 0x2A, 0x2A, 0x2A, 0x14,      // B
        0x1C, 0x22, 0x22, 0x22, 0x22,      // C
        0x3E, 0x22, 0x22, 0x22, 0x1C,      // D
        0x3E, 0x2A, 0x2A, 0x2A, 0x22,      // E
        0x3E, 0x0A, 0x0A, 0x02, 0x02,      // F
        0x1C, 0x22, 0x2A, 0x2A, 0x3A,      // G
        0x3E, 0x08, 0x08, 0x08, 0x3E,      // H
        0x00, 0x22, 0x3E, 0x22, 0x00,      // I
        0x10, 0x20, 0x22, 0x22, 0x1E,      // J
        0x3E, 0x08, 0x0C, 0x0A, 0x30,      // K
        0x3E, 0x20, 0x20, 0x20, 0x20,      // L
        0x3E, 0x04, 0x08, 0x04, 0x3E,      // M
        0x3E, 0x02, 0x1C, 0x20, 0x3E,      // N
        0x1C, 0x22, 0x22, 0x22, 0x1C       // O
};


BYTE const TABLE2[240]= {
        0x3E, 0x0A, 0x0A, 0x0A, 0x04,      // P
        0x1C, 0x22, 0x22, 0x3C, 0x20,      // Q
        0x3E, 0x0A, 0x0A, 0x1A, 0x24,      // R
        0x24, 0x2A, 0x2A, 0x2A, 0x12,      // S
        0x02, 0x02, 0x3E, 0x02, 0x02,      // T
        0x1E, 0x20, 0x20, 0x20, 0x1E,      // U
        0x06, 0x18, 0x20, 0x18, 0x06,      // V
        0x3E, 0x10, 0x08, 0x10, 0x3E,      // W
        0x22, 0x14, 0x08, 0x14, 0x22,      // X
        0x06, 0x08, 0x38, 0x08, 0x06,      // Y
        0x32, 0x2A, 0x2A, 0x2A, 0x26,      // Z
        0x00, 0x3E, 0x22, 0x00, 0x00,      // [
        0x02, 0x04, 0x08, 0x10, 0x20,      // \
        0x00, 0x00, 0x22, 0x3E, 0x00,      // ]
        0x00, 0x04, 0x02, 0x04, 0x00,      // ^
        0x20, 0x20, 0x20, 0x20, 0x20,      // _
        0x00, 0x00, 0x06, 0x00, 0x00,      // `
        0x12, 0x2A, 0x2A, 0x2A, 0x3C,      // a
        0x3E, 0x24, 0x24, 0x24, 0x18,      // b
        0x1C, 0x22, 0x22, 0x22, 0x14,      // c
        0x18, 0x24, 0x24, 0x24, 0x3E,      // d
        0x1C, 0x2A, 0x2A, 0x2A, 0x2C,      // e
        0x3C, 0x0A, 0x0A, 0x02, 0x02,      // f
        0x24, 0x2A, 0x2A, 0x2A, 0x1C,      // g
        0x3E, 0x04, 0x04, 0x04, 0x38,      // h
        0x00, 0x00, 0x3A, 0x00, 0x00,      // i
        0x20, 0x20, 0x20, 0x20, 0x1E,      // j
        0x3E, 0x08, 0x08, 0x14, 0x22,      // k
        0x1E, 0x20, 0x20, 0x20, 0x20,      // l
        0x3C, 0x02, 0x3C, 0x02, 0x3C,      // m
        0x3E, 0x02, 0x02, 0x02, 0x3C,      // n
        0x1C, 0x22, 0x22, 0x22, 0x1C,      // o
        0x3E, 0x12, 0x12, 0x12, 0x0C,      // p
        0x0C, 0x12, 0x12, 0x12, 0x3E,      // q
        0x3E, 0x04, 0x02, 0x02, 0x04,      // r
        0x24, 0x2A, 0x2A, 0x2A, 0x12,      // s
        0x1E, 0x24, 0x24, 0x20, 0x10,      // t
        0x1E, 0x20, 0x20, 0x10, 0x3E,      // u
        0x06, 0x18, 0x20, 0x18, 0x06,      // v
        0x1E, 0x20, 0x1E, 0x20, 0x1E,      // w
        0x36, 0x08, 0x08, 0x08, 0x36,      // x
        0x26, 0x28, 0x28, 0x28, 0x1E,      // y
        0x22, 0x32, 0x2A, 0x26, 0x22,      // z
        0x08, 0x36, 0x22, 0x00, 0x00,      // {
        0x00, 0x00, 0x3E, 0x00, 0x00,      // |
        0x00, 0x00, 0x22, 0x36, 0x08,      // }
        0x00, 0x04, 0x02, 0x04, 0x02,      // ~
   0x00, 0x04, 0x02, 0x04, 0x02       // ~
};

BYTE const TABLE3[240]= {                  // Tabela ASCII caracteres 5x5 pixels Sublinhados
        0x80, 0x80, 0x80, 0x80, 0x80,      // Espa�o 
        0x80, 0x80, 0xAE, 0x80, 0x80,      // !
        0x80, 0x86, 0x80, 0x86, 0x80,      // "
        0x94, 0xBE, 0x94, 0xBE, 0x94,      // #
        0xA4, 0xAA, 0xBE, 0xAA, 0x92,      // $
        0xA2, 0x90, 0x88, 0x84, 0xA2,      // %
        0x94, 0xAA, 0xAA, 0xBC, 0xA8,      // &
        0x80, 0x86, 0x80, 0x80, 0x80,      // '
        0x80, 0x9C, 0xA2, 0x80, 0x80,      // (
        0x80, 0x80, 0xA2, 0x9C, 0x80,      // )
        0x94, 0x88, 0xBE, 0x88, 0x94,      // *
        0x80, 0x88, 0x9C, 0x88, 0x80,      // +
        0x80, 0x90, 0xB0, 0x80, 0x80,      // ,
        0x80, 0x88, 0x88, 0x88, 0x80,      // -
        0x80, 0x80, 0xA0, 0x80, 0x80,      // .
        0xA0, 0x90, 0x88, 0x84, 0x82,      // /
        0x9C, 0xB2, 0xAA, 0xA6, 0x9C,      // 0
        0x80, 0xA4, 0xBE, 0xA0, 0x80,      // 1
        0xB2, 0xAA, 0xAA, 0xAA, 0xA4,      // 2
        0xA2, 0xA2, 0xAA, 0xAA, 0x94,      // 3
        0x86, 0x88, 0x88, 0x88, 0xBE,      // 4
        0xAE, 0xAA, 0xAA, 0xAA, 0x92,      // 5
        0x9C, 0xAA, 0xAA, 0xAA, 0x92,      // 6
        0x82, 0x82, 0x82, 0xBA, 0x86,      // 7
        0x94, 0xAA, 0xAA, 0xAA, 0x94,      // 8
        0x84, 0x8A, 0xAA, 0xAA, 0x9C,      // 9
        0x80, 0x80, 0xA8, 0x80, 0x80,      // :
        0x80, 0x80, 0xA8, 0x80, 0x80,      // ;
        0x80, 0x88, 0x94, 0xA2, 0x80,      // <
        0x94, 0x94, 0x94, 0x94, 0x94,      // =
        0x80, 0xA2, 0x94, 0x88, 0x80,      // >
        0x84, 0x82, 0xAA, 0x8A, 0x84,      // ?
        0x9C, 0xA2, 0xAA, 0x92, 0x9C,      // @
        0xBC, 0x8A, 0x8A, 0x8A, 0xBC,      // A
        0xBE, 0xAA, 0xAA, 0xAA, 0x94,      // B
        0x9C, 0xA2, 0xA2, 0xA2, 0xA2,      // C
        0xBE, 0xA2, 0xA2, 0xA2, 0x9C,      // D
        0xBE, 0xAA, 0xAA, 0xAA, 0xA2,      // E
        0xBE, 0x8A, 0x8A, 0x82, 0x82,      // F
        0x9C, 0xA2, 0xAA, 0xAA, 0xBA,      // G
        0xBE, 0x88, 0x88, 0x88, 0xBE,      // H
        0x80, 0xA2, 0xBE, 0xA2, 0x80,      // I
        0x90, 0xA0, 0xA2, 0xA2, 0x9E,      // J
        0xBE, 0x88, 0x8C, 0x8A, 0xB0,      // K
        0xBE, 0xA0, 0xA0, 0xA0, 0xA0,      // L
        0xBE, 0x84, 0x88, 0x84, 0xBE,      // M
        0xBE, 0x82, 0x9C, 0xA0, 0xBE,      // N
        0x9C, 0xA2, 0xA2, 0xA2, 0x9C       // O
};

BYTE const TABLE4[240]= {
        0xBE, 0x8A, 0x8A, 0x8A, 0x84,      // P
        0x9C, 0xA2, 0xA2, 0xBC, 0xA0,      // Q
        0xBE, 0x8A, 0x8A, 0x9A, 0xA4,      // R
        0xA4, 0xAA, 0xAA, 0xAA, 0x92,      // S
        0x82, 0x82, 0xBE, 0x82, 0x82,      // T
        0x9E, 0xA0, 0xA0, 0xA0, 0x9E,      // U
        0x86, 0x98, 0xA0, 0x98, 0x86,      // V
        0xBE, 0x90, 0x88, 0x90, 0xBE,      // W
        0xA2, 0x94, 0x88, 0x94, 0xA2,      // X
        0x86, 0x88, 0xB8, 0x88, 0x86,      // Y
        0xB2, 0xAA, 0xAA, 0xAA, 0xA6,      // Z
        0x80, 0xBE, 0xA2, 0x80, 0x80,      // [
        0x82, 0x84, 0x88, 0x90, 0xA0,      // \
        0x80, 0x80, 0xA2, 0xBE, 0x80,      // ]
        0x80, 0x84, 0x82, 0x84, 0x80,      // ^
        0xA0, 0xA0, 0xA0, 0xA0, 0xA0,      // _
        0x80, 0x80, 0x86, 0x80, 0x80,      // `
        0x92, 0xAA, 0xAA, 0xAA, 0xBC,      // a
        0xBE, 0xA4, 0xA4, 0xA4, 0x98,      // b
        0x9C, 0xA2, 0xA2, 0xA2, 0x94,      // c
        0x98, 0xA4, 0xA4, 0xA4, 0xBE,      // d
        0x9C, 0xAA, 0xAA, 0xAA, 0xAC,      // e
        0xBC, 0x8A, 0x8A, 0x82, 0x82,      // f
        0xA4, 0xAA, 0xAA, 0xAA, 0x9C,      // g
        0xBE, 0x84, 0x84, 0x84, 0xB8,      // h
        0x80, 0x80, 0xBA, 0x80, 0x80,      // i
        0xA0, 0xA0, 0xA0, 0xA0, 0x9E,      // j
        0xBE, 0x88, 0x88, 0x94, 0xA2,      // k
        0x9E, 0xA0, 0xA0, 0xA0, 0xA0,      // l
        0xBC, 0x82, 0xBC, 0x82, 0xBC,      // m
        0xBE, 0x82, 0x82, 0x82, 0xBC,      // n
        0x9C, 0xA2, 0xA2, 0xA2, 0x9C,      // o
        0xBE, 0x92, 0x92, 0x92, 0x8C,      // p
        0x8C, 0x92, 0x92, 0x92, 0xBE,      // q
        0xBE, 0x84, 0x82, 0x82, 0x84,      // r
        0xA4, 0xAA, 0xAA, 0xAA, 0x92,      // s
        0x9E, 0xA4, 0xA4, 0xA0, 0x90,      // t
        0x9E, 0xA0, 0xA0, 0x90, 0xBE,      // u
        0x86, 0x98, 0xA0, 0x98, 0x86,      // v
        0x9E, 0xA0, 0x9E, 0xA0, 0x9E,      // w
        0xB6, 0x88, 0x88, 0x88, 0xB6,      // x
        0xA6, 0xA8, 0xA8, 0xA8, 0x9E,      // y
        0xA2, 0xB2, 0xAA, 0xA6, 0xA2,      // z
        0x88, 0xB6, 0xA2, 0x80, 0x80,      // {
        0x80, 0x80, 0xBE, 0x80, 0x80,      // |
        0x80, 0x80, 0xA2, 0xB6, 0x88,      // }
        0x80, 0x84, 0x82, 0x84, 0x82,      // ~
        0x80, 0x84, 0x82, 0x84, 0x82       // ~
};

BYTE const TABLE5[240]=            
 {0x00,0x00,0x00,0x00,0x00,   // 20 space          ASCII table for NOKIA LCD: 96 rows * 5 bytes= 480 bytes 
  0x00,0x00,0x5f,0x00,0x00,   // 21 ! 
  0x00,0x07,0x00,0x07,0x00,   // 22 " 
  0x14,0x7f,0x14,0x7f,0x14,   // 23 # 
  0x24,0x2a,0x7f,0x2a,0x12,   // 24 $ 
  0x23,0x13,0x08,0x64,0x62,   // 25 % 
  0x36,0x49,0x55,0x22,0x50,   // 26 & 
  0x00,0x05,0x03,0x00,0x00,   // 27 ' 
  0x00,0x1c,0x22,0x41,0x00,   // 28 ( 
  0x00,0x41,0x22,0x1c,0x00,   // 29 ) 
  0x14,0x08,0x3e,0x08,0x14,   // 2a * 
  0x08,0x08,0x3e,0x08,0x08,   // 2b + 
  0x00,0x50,0x30,0x00,0x00,   // 2c , 
  0x08,0x08,0x08,0x08,0x08,   // 2d - 
  0x00,0x60,0x60,0x00,0x00,   // 2e . 
  0x20,0x10,0x08,0x04,0x02,   // 2f / 
  0x3e,0x51,0x49,0x45,0x3e,   // 30 0 
  0x00,0x42,0x7f,0x40,0x00,   // 31 1 
  0x42,0x61,0x51,0x49,0x46,   // 32 2 
  0x21,0x41,0x45,0x4b,0x31,   // 33 3 
  0x18,0x14,0x12,0x7f,0x10,   // 34 4 
  0x27,0x45,0x45,0x45,0x39,   // 35 5 
  0x3c,0x4a,0x49,0x49,0x30,   // 36 6 
  0x01,0x71,0x09,0x05,0x03,   // 37 7 
  0x36,0x49,0x49,0x49,0x36,   // 38 8 
  0x06,0x49,0x49,0x29,0x1e,   // 39 9 
  0x00,0x36,0x36,0x00,0x00,   // 3a : 
  0x00,0x56,0x36,0x00,0x00,   // 3b ; 
  0x08,0x14,0x22,0x41,0x00,   // 3c < 
  0x14,0x14,0x14,0x14,0x14,   // 3d = 
  0x00,0x41,0x22,0x14,0x08,   // 3e > 
  0x02,0x01,0x51,0x09,0x06,   // 3f ? 
  0x32,0x49,0x79,0x41,0x3e,   // 40 @ 
  0x7e,0x11,0x11,0x11,0x7e,   // 41 A 
  0x7f,0x49,0x49,0x49,0x36,   // 42 B 
  0x3e,0x41,0x41,0x41,0x22,   // 43 C 
  0x7f,0x41,0x41,0x22,0x1c,   // 44 D 
  0x7f,0x49,0x49,0x49,0x41,   // 45 E 
  0x7f,0x09,0x09,0x09,0x01,   // 46 F 
  0x3e,0x41,0x49,0x49,0x7a,   // 47 G 
  0x7f,0x08,0x08,0x08,0x7f,   // 48 H 
  0x00,0x41,0x7f,0x41,0x00,   // 49 I 
  0x20,0x40,0x41,0x3f,0x01,   // 4a J 
  0x7f,0x08,0x14,0x22,0x41,   // 4b K 
  0x7f,0x40,0x40,0x40,0x40,   // 4c L 
  0x7f,0x02,0x0c,0x02,0x7f,   // 4d M 
  0x7f,0x04,0x08,0x10,0x7f,   // 4e N 
  0x3e,0x41,0x41,0x41,0x3e    // 4f O 
};    


BYTE const TABLE6[240]=            
 {0x7f,0x09,0x09,0x09,0x06,   // 50 P 
  0x3e,0x41,0x51,0x21,0x5e,   // 51 Q 
  0x7f,0x09,0x19,0x29,0x46,   // 52 R 
  0x46,0x49,0x49,0x49,0x31,   // 53 S 
  0x01,0x01,0x7f,0x01,0x01,   // 54 T 
  0x3f,0x40,0x40,0x40,0x3f,   // 55 U 
  0x1f,0x20,0x40,0x20,0x1f,   // 56 V 
  0x3f,0x40,0x38,0x40,0x3f,   // 57 W 
  0x63,0x14,0x08,0x14,0x63,   // 58 X 
  0x07,0x08,0x70,0x08,0x07,   // 59 Y 
  0x61,0x51,0x49,0x45,0x43,   // 5a Z 
  0x00,0x7f,0x41,0x41,0x00,   // 5b [ 
  0x02,0x04,0x08,0x10,0x20,   // 5c \
  0x00,0x41,0x41,0x7f,0x00,   // 5d ]
  0x04,0x02,0x01,0x02,0x04,   // 5e ^
  0x40,0x40,0x40,0x40,0x40,   // 5f _
  0x00,0x01,0x02,0x04,0x00,   // 60 `
  0x20,0x54,0x54,0x54,0x78,   // 61 a 
  0x7f,0x48,0x44,0x44,0x38,   // 62 b 
  0x38,0x44,0x44,0x44,0x20,   // 63 c 
  0x38,0x44,0x44,0x48,0x7f,   // 64 d 
  0x38,0x54,0x54,0x54,0x18,   // 65 e 
  0x08,0x7e,0x09,0x01,0x02,   // 66 f 
  0x0c,0x52,0x52,0x52,0x3e,   // 67 g 
  0x7f,0x08,0x04,0x04,0x78,   // 68 h 
  0x00,0x44,0x7d,0x40,0x00,   // 69 i 
  0x20,0x40,0x44,0x3d,0x00,   // 6a j 
  0x7f,0x10,0x28,0x44,0x00,   // 6b k 
  0x00,0x41,0x7f,0x40,0x00,   // 6c l 
  0x7c,0x04,0x18,0x04,0x78,   // 6d m 
  0x7c,0x08,0x04,0x04,0x78,   // 6e n 
  0x38,0x44,0x44,0x44,0x38,   // 6f o 
  0x7c,0x14,0x14,0x14,0x08,   // 70 p 
  0x08,0x14,0x14,0x18,0x7c,   // 71 q 
  0x7c,0x08,0x04,0x04,0x08,   // 72 r 
  0x48,0x54,0x54,0x54,0x20,   // 73 s 
  0x04,0x3f,0x44,0x40,0x20,   // 74 t 
  0x3c,0x40,0x40,0x20,0x7c,   // 75 u 
  0x1c,0x20,0x40,0x20,0x1c,   // 76 v 
  0x3c,0x40,0x30,0x40,0x3c,   // 77 w 
  0x44,0x28,0x10,0x28,0x44,   // 78 x 
  0x0c,0x50,0x50,0x50,0x3c,   // 79 y 
  0x44,0x64,0x54,0x4c,0x44,   // 7a z 
  0x00,0x08,0x36,0x41,0x00,   // 7b {
  0x00,0x00,0x7f,0x00,0x00,   // 7c |
  0x00,0x41,0x36,0x08,0x00,   // 7d }
  0x10,0x08,0x08,0x10,0x08,   // 7e ~
  0x78,0x46,0x41,0x46,0x78    // 7f 
};  


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 

void    nokia_init(void); 
void    nokia_write_command(char bytefornokia_command); 
void    nokia_write_data(char bytefornokia_data); 
void    nokia_write_dorc(char bytefornokia); 
void    nokia_gotoxy(int8 xnokia, int8 ynokia); 
void    nokia_erase_y(int8 ynokia); 
void    nokia_erase_x(int8 xnokia); 
void    nokia_printchar1(int8 cvar);
void    nokia_printchar2(int8 cvar);
void    nokia_printchar3(int8 cvar);
void    nokia_clean_ddram(void); 
void    table_to_nokialcd1(void);
void    table_to_nokialcd2(void);
void    table_to_nokialcd3(void);
void    nokia_plot(int8 xnokia,int8 plot_value8); 
void    nokia_write_data_inv(char bytefornokia_data_inv); 
void    nokia_clear_screen(void); 
void    nokia_clear_xy(int8 xnokia, int8 ynokia); 
void    nokia_print_uparrow(void); 
void    nokia_print_downarrow(void); 
void    nokia_print_leftarrow(void); 
void    nokia_print_rightarrow(void); 
void    nokia_print_degree(void); 
void    nokia_print_lowbatdegree(void); 

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 

void nokia_init(void) 
{ 
  output_high(nok_dc);            // bytes are stored in the display data ram, address counter, incremented automatically 
  output_high(nok_sce);            // chip disabled 

  output_low(nok_res);            // reset chip during 250ms 
  delay_ms(10);         // works with less..... 
  output_high(nok_res); 

  nokia_write_command(0x21);   // set extins extended instruction set 
  nokia_write_command(0xd8);   // Vop  v1: 0xc8 (for 3V)// v2: 0xa0 (for 3V) // v3: 0xc2 (2v6-5v)   ******************************************************************************************************************** 
  nokia_write_command(0x13);   // bias 
  nokia_write_command(0x20);   // horizontal mode from left to right, X axe are incremented automatically , 0x22 for vertical addressing ,back on normal instruction set too 
  nokia_write_command(0x09);   // all on 

  nokia_clean_ddram();      // reset DDRAM, otherwise the lcd is blurred with random pixels 

  nokia_write_command(0x08);   // mod control blank change (all off) 

  nokia_write_command(0x0c);   // mod control normal change 

} 

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 

void nokia_clean_ddram(void) 
{ 
  nokia_gotoxy(0,0);         // 84*6=504      clear LCD 
  for (ddram=504;ddram>0;ddram--){nokia_write_data(0x00);} 

} 

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 

void nokia_write_command(char bytefornokia_command) 
{ 

  output_low(nok_dc);   // byte is a command it is read with the eight SCLK pulse 
  output_low(nok_sce);   // chip enabled 
  nokia_write_dorc(bytefornokia_command); 
  output_high(nok_sce);   // chip disabled 

} 

///////////////////////////////////////////////////////////////////////////////// 

void nokia_write_data(char bytefornokia_data) 
{ 

  output_high(nok_dc); 
  output_low(nok_sce);   // chip enabled 
  nokia_write_dorc(bytefornokia_data); 
  output_high(nok_sce);   // chip disabled 

} 

////////////////////////////////////////////////////////////////////////////////// 

void nokia_write_dorc(char bytefornokia)         // serial write data or command subroutine 
{ 
  char caa; 
  for (caa=8;caa>0;caa--) { 
    output_low(nok_sck); 
    // delay_us(2); 
    if ((bytefornokia&0x80)==0){output_low(nok_sdin);} 
    else {output_high(nok_sdin);} 
    output_high(nok_sck); 
    bytefornokia=bytefornokia<<1; 
  } 
} 

////////////////////////////////////////////////////////////////////////////////// 

void nokia_gotoxy(int8 xnokia, int8 ynokia)      // Nokia LCD 3310 Position cursor 
{ 
  nokia_write_command(0x40|(ynokia&0x07));   // Y axe initialisation: 0100 0yyy 

  nokia_write_command(0x80|(xnokia&0x7f));   // X axe initialisation: 1xxx xxxx 
} 

////////////////////////////////////////////////////////////////////////////////// 

void nokia_erase_y(int8 ynokia) 
{ 
  nokia_gotoxy(0,ynokia); 
  printf(nokia_printchar3,"              "); 
} 

////////////////////////////////////////////////////////////////////////////////// 

void nokia_erase_x(int8 xnokia) 
{ 
  char column; 

  for (column=0;column!=6;column++){ 
    nokia_gotoxy(xnokia,column); 
    nokia_write_data(0x00); 
    nokia_write_data(0x00); 
    nokia_write_data(0x00); 
    nokia_write_data(0x00); 
    nokia_write_data(0x00); 
    nokia_write_data(0x00); 

  } 
} 

////////////////////////////////////////////////////////////////////////////////// 

void nokia_printchar1(int8 cvar)               // Write 1 character to LCD 
{ 
  charsel=cvar; 
  table_to_nokialcd1(); 
} 

////////////////////////////////////////////////////////////////////////////////// 

void table_to_nokialcd1(void)   // extract ascii from tables & write to LCD 
{ 
  if (charsel<0x20)return; 
  if (charsel>0x7f)return; 

  for (char_row=0;char_row<5;char_row++) {      // 5 bytes 

    if (charsel<0x50){charpos=(((charsel&0xff)-0x20)*5);chardata=TABLE1[(charpos+char_row)];}            // use TABLE5 
    else if (charsel>0x4f){charpos=(((charsel&0xff)-0x50)*5);chardata=TABLE2[(charpos+char_row)];}            // use TABLE6 


    nokia_write_data(chardata);      // send data to nokia 
  } 

  nokia_write_data(0x00);      //    1 byte (always blank) 

} 


////////////////////////////////////////////////////////////////////////////////// 

void nokia_printchar2(int8 cvar)               // Write 1 character to LCD 
{ 
  charsel=cvar; 
  table_to_nokialcd2(); 
} 

////////////////////////////////////////////////////////////////////////////////// 

void table_to_nokialcd2(void)   // extract ascii from tables & write to LCD 
{ 
  if (charsel<0x20)return; 
  if (charsel>0x7f)return; 

  for (char_row=0;char_row<5;char_row++) {      // 5 bytes 

    if (charsel<0x50){charpos=(((charsel&0xff)-0x20)*5);chardata=TABLE3[(charpos+char_row)];}            // use TABLE5 
    else if (charsel>0x4f){charpos=(((charsel&0xff)-0x50)*5);chardata=TABLE4[(charpos+char_row)];}            // use TABLE6 


    nokia_write_data(chardata);      // send data to nokia 
  } 

  nokia_write_data(0x80);      //    1 byte (always blank) 

}

////////////////////////////////////////////////////////////////////////////////// 

void nokia_printchar3(int8 cvar)               // Write 1 character to LCD 
{ 
  charsel=cvar; 
  table_to_nokialcd3(); 
} 

////////////////////////////////////////////////////////////////////////////////// 

void table_to_nokialcd3(void)   // extract ascii from tables & write to LCD 
{ 
  if (charsel<0x20)return; 
  if (charsel>0x7f)return; 

  for (char_row=0;char_row<5;char_row++) {      // 5 bytes 

    if (charsel<0x50){charpos=(((charsel&0xff)-0x20)*5);chardata=TABLE5[(charpos+char_row)];}            // use TABLE5 
    else if (charsel>0x4f){charpos=(((charsel&0xff)-0x50)*5);chardata=TABLE6[(charpos+char_row)];}            // use TABLE6 


    nokia_write_data(chardata);      // send data to nokia 
  } 

  nokia_write_data(0x00);      //    1 byte (always blank) 

}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 

void nokia_plot(int8 xnokia,int8 plot_value8) 
{ 
  char i; 

  plot_value32=0; 
  // plot_value32|=1;         // unremark this if you want dotgraph instead of bargraph 

  for (i=0;i!=plot_value8;i++){ 

    plot_value32|=1;         // remark this if you want dotgraph instead of bargraph 
    plot_value32<<=1; 
  } 

  plot_value32|=2;            // bottom line is always filled 

  plot_llsb=(plot_value32&0xff); 
  plot_ulsb=((plot_value32>>8)&0xff); 
  plot_lmsb=((plot_value32>>16)&0xff); 
  plot_umsb=((plot_value32>>24)&0xff); 

  nokia_gotoxy(xnokia,1); 
  nokia_write_data_inv(plot_umsb); 

  nokia_gotoxy(xnokia,2); 
  nokia_write_data_inv(plot_lmsb); 

  nokia_gotoxy(xnokia,3); 
  nokia_write_data_inv(plot_ulsb); 

  nokia_gotoxy(xnokia,4); 
  nokia_write_data_inv(plot_llsb); 

} 

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 

void nokia_write_data_inv(char bytefornokia_data_inv) 
{ 
  char caa; 

  output_high(nok_dc); 
  output_low(nok_sce);   // chip enabled 

  for (caa=8;caa>0;caa--) { 
    output_low(nok_sck); 
    delay_us(2); 
    if ((bytefornokia_data_inv&0x01)==0){output_low(nok_sdin);} 
    else {output_high(nok_sdin);} 
    output_high(nok_sck); 
    bytefornokia_data_inv=bytefornokia_data_inv>>1; 
  } 

  output_high(nok_sce);   // chip disabled 
} 

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 

void nokia_clear_screen(void) 
{ 
  nokia_erase_y(0); 
  nokia_erase_y(1); 
  nokia_erase_y(2); 
  nokia_erase_y(3); 
  nokia_erase_y(4); 
  nokia_erase_y(5); 

} 

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 

void nokia_clear_xy(int8 xnokia, int8 ynokia) 
{ 

  nokia_gotoxy(xnokia,ynokia); 
  nokia_printchar3(" "); 


} 

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 

void nokia_print_uparrow(void) 
{ 
  nokia_write_data(0x04); 
  nokia_write_data(0x02); 
  nokia_write_data(0x7f); 
  nokia_write_data(0x02); 
  nokia_write_data(0x04); 
  nokia_write_data(0x00); 
} 
// 
void nokia_print_downarrow(void) 
{ 
  nokia_write_data(0x10); 
  nokia_write_data(0x20); 
  nokia_write_data(0x7f); 
  nokia_write_data(0x20); 
  nokia_write_data(0x10); 
  nokia_write_data(0x00); 
} 
// 
void nokia_print_leftarrow(void) 
{ 
  nokia_write_data(0x08); 
  nokia_write_data(0x1c); 
  nokia_write_data(0x2a); 
  nokia_write_data(0x08); 
  nokia_write_data(0x08); 
  nokia_write_data(0xf8); 
} 
// 
void nokia_print_rightarrow(void) 
{ 
  nokia_write_data(0x08); 
  nokia_write_data(0x08); 
  nokia_write_data(0x2a); 
  nokia_write_data(0x1c); 
  nokia_write_data(0x08); 
  nokia_write_data(0x00); 
} 
// 
void nokia_print_degree(void) 
{ 
  nokia_write_data(0x00); 
  nokia_write_data(0x06); 
  nokia_write_data(0x09); 
  nokia_write_data(0x09); 
  nokia_write_data(0x06); 
  nokia_write_data(0x00); 

  // nokia_printchar("  "); 
} 
// 
void nokia_print_lowbatdegree(void) 
{ 
  nokia_write_data(0x00); 
  nokia_write_data(0x06); 
  nokia_write_data(0x0f); 
  nokia_write_data(0x0f); 
  nokia_write_data(0x06); 
  nokia_write_data(0x00); 

  // nokia_printchar("  "); 
} 

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
