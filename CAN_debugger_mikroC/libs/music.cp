#line 1 "C:/Users/Salvatore/Desktop/CAN Debugger/libs/music.c"
#line 1 "c:/users/salvatore/desktop/can debugger/libs/music.h"
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
#line 11 "c:/users/salvatore/desktop/can debugger/libs/music.h"
char Music_hasToMakeSound(void);

void Music_tick(void);

void Music_setSongTime(unsigned int time);

void Music_playSong(unsigned char song[], unsigned int songLength);

void Music_playSongNextNote(void);

void Music_playNote(unsigned char note, unsigned char duration);

float Music_getActualNoteDuration(unsigned char duration);

float Music_getNoteFrequency(unsigned char note);

char music_isPlaying =  0 ;
char music_isPlayingNote =  0 ;
unsigned char *music_song;
unsigned int music_songTime, music_songLength;
const float MUSIC_NOTE_TABLE[] = {
 261.63, 277.18, 293.66, 311.13, 329.63, 349.23,
 369.99, 392.00, 415.30, 440.00, 466.16, 493.88, 523.25, 554.37,
 587.33, 622.25, 659.25, 698.46, 739.99, 783.99,
 830.61, 880.00, 932.33, 987.77, 1046.50, 1108.73,
 1174.66, 1244.51, 1318.51, 1396.91, 1479.98, 1567.98,
 1661.22, 1760.00, 1864.66, 1975.53};
#line 1 "c:/users/salvatore/desktop/can debugger/libs/songs/amourtoujour.h"
#line 1 "c:/users/salvatore/desktop/can debugger/libs/songs/../music.h"
#line 10 "c:/users/salvatore/desktop/can debugger/libs/songs/amourtoujour.h"
const unsigned int AMOR_TOUJOUR_TEMPO = 120;
const unsigned char AMOR_TOUJOUR_SONG[] = {
  19 ,  8 ,
  200 ,  16 ,
  19 ,  8 ,
  19 ,  4 ,
  27 ,  4 ,
  26 ,  8 ,
  200 ,  8 ,
  26 ,  8 ,
  26 ,  4 ,
  27 ,  4 ,
  24 ,  8 ,
  200 ,  8 
};
const unsigned int AMOR_TOUJOUR_LENGTH = sizeof(AMOR_TOUJOUR_SONG);
#line 8 "C:/Users/Salvatore/Desktop/CAN Debugger/libs/music.c"
unsigned int music_tickCounter = 0;
unsigned int music_currentNote = 0;
unsigned int music_trentaduesimoTicks = 0;

char Music_hasToMakeSound(void) {
 return music_isPlayingNote && (music_tickCounter > music_trentaduesimoTicks);
}

void Music_tick(void) {
 if (music_tickCounter > 0) {
 music_tickCounter -= 1;
 if (music_tickCounter == 0) {
 Music_playSongNextNote();
 }
 }
}

void Music_setSongTime(unsigned int time) {
 music_songTime = time;
}

void Music_playSong(unsigned char song[], unsigned int songLength) {
 music_song = song;
 music_songLength = songLength;
 music_isPlaying =  1 ;
 music_currentNote = 0;
 Music_playSongNextNote();
}

void Music_playSongNextNote(void) {
 unsigned char note, duration;
 if (music_currentNote < music_songLength) {
 note = *(music_song + music_currentNote);
 duration = *(music_song + music_currentNote + 1);
 Music_playNote(note, duration);
 music_currentNote += 2;
 } else {
 music_isPlaying =  0 ;
 }
}

void Music_playNote(unsigned char note, unsigned char duration) {
 float timerPeriod;
 if (note ==  200 ) {
 music_isPlayingNote =  0 ;
 timerPeriod = 0.001;
 } else {
 music_isPlayingNote =  1 ;
 timerPeriod = 1.0 / Music_getNoteFrequency(note);
 }
 music_tickCounter = (unsigned int) (Music_getActualNoteDuration(duration) / timerPeriod);
 music_trentaduesimoTicks = (unsigned int) (Music_getActualNoteDuration( 1 ) / timerPeriod);
 setTimer( 3 , timerPeriod);
}

float Music_getActualNoteDuration(unsigned char duration) {
 return ((float) duration / (float) music_songTime) * 7.5;
}

float Music_getNoteFrequency(unsigned char note) {
 return MUSIC_NOTE_TABLE[note];
}
