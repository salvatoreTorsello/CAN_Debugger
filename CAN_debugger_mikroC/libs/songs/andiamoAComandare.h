//
// Created by Aaron Russo on 07/08/16.
//

#ifndef DP8_DISPLAY_CONTROLLER_ANDIAMOACOMANDARE_H
#define DP8_DISPLAY_CONTROLLER_ANDIAMOACOMANDARE_H

#include "../music.h"

const unsigned int ANDIAMO_A_COMANDARE_TEMPO = 130;
const unsigned char ANDIAMO_A_COMANDARE_SONG[] = {
        DO5, QUARTO,
        DO5, QUARTO,
        LA4_, QUARTO,
        RE4_, OTTAVO,
        SOL4_, OTTAVO,
        PAUSA, OTTAVO,
        SOL4_, OTTAVO,
        PAUSA, OTTAVO,
        SOL4_, OTTAVO,
        SOL4, OTTAVO,
        SOL4_, SEDICESIMO,
        SOL4, SEDICESIMO,
        PAUSA, OTTAVO,
        RE4_, OTTAVO
};
const unsigned int ANDIAMO_A_COMANDARE_LENGTH = sizeof(ANDIAMO_A_COMANDARE_SONG);
#define ANDIAMO_A_COMANDARE ANDIAMO_A_COMANDARE_SONG, ANDIAMO_A_COMANDARE_LENGTH

#endif //DP8_DISPLAY_CONTROLLER_ANDIAMOACOMANDARE_H
