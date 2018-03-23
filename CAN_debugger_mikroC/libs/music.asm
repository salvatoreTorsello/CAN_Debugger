
_Music_hasToMakeSound:

;music.c,12 :: 		char Music_hasToMakeSound(void) {
;music.c,13 :: 		return music_isPlayingNote && (music_tickCounter > music_trentaduesimoTicks);
	MOV	#lo_addr(_music_isPlayingNote), W0
	CP0.B	[W0]
	BRA NZ	L__Music_hasToMakeSound9
	GOTO	L_Music_hasToMakeSound1
L__Music_hasToMakeSound9:
	MOV	_music_tickCounter, W1
	MOV	#lo_addr(_music_trentaduesimoTicks), W0
	CP	W1, [W0]
	BRA GTU	L__Music_hasToMakeSound10
	GOTO	L_Music_hasToMakeSound1
L__Music_hasToMakeSound10:
	MOV.B	#1, W0
	GOTO	L_Music_hasToMakeSound0
L_Music_hasToMakeSound1:
	CLR	W0
L_Music_hasToMakeSound0:
;music.c,14 :: 		}
L_end_Music_hasToMakeSound:
	RETURN
; end of _Music_hasToMakeSound

_Music_tick:

;music.c,16 :: 		void Music_tick(void) {
;music.c,17 :: 		if (music_tickCounter > 0) {
	MOV	_music_tickCounter, W0
	CP	W0, #0
	BRA GTU	L__Music_tick12
	GOTO	L_Music_tick2
L__Music_tick12:
;music.c,18 :: 		music_tickCounter -= 1;
	MOV	#1, W1
	MOV	#lo_addr(_music_tickCounter), W0
	SUBR	W1, [W0], [W0]
;music.c,19 :: 		if (music_tickCounter == 0) {
	MOV	_music_tickCounter, W0
	CP	W0, #0
	BRA Z	L__Music_tick13
	GOTO	L_Music_tick3
L__Music_tick13:
;music.c,20 :: 		Music_playSongNextNote();
	CALL	_Music_playSongNextNote
;music.c,21 :: 		}
L_Music_tick3:
;music.c,22 :: 		}
L_Music_tick2:
;music.c,23 :: 		}
L_end_Music_tick:
	RETURN
; end of _Music_tick

_Music_setSongTime:

;music.c,25 :: 		void Music_setSongTime(unsigned int time) {
;music.c,26 :: 		music_songTime = time;
	MOV	W10, _music_songTime
;music.c,27 :: 		}
L_end_Music_setSongTime:
	RETURN
; end of _Music_setSongTime

_Music_playSong:

;music.c,29 :: 		void Music_playSong(unsigned char song[], unsigned int songLength) {
;music.c,30 :: 		music_song = song;
	MOV	W10, _music_song
;music.c,31 :: 		music_songLength = songLength;
	MOV	W11, _music_songLength
;music.c,32 :: 		music_isPlaying = TRUE;
	MOV	#lo_addr(_music_isPlaying), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;music.c,33 :: 		music_currentNote = 0;
	CLR	W0
	MOV	W0, _music_currentNote
;music.c,34 :: 		Music_playSongNextNote();
	CALL	_Music_playSongNextNote
;music.c,35 :: 		}
L_end_Music_playSong:
	RETURN
; end of _Music_playSong

_Music_playSongNextNote:

;music.c,37 :: 		void Music_playSongNextNote(void) {
;music.c,39 :: 		if (music_currentNote < music_songLength) {
	PUSH	W10
	PUSH	W11
	MOV	_music_currentNote, W1
	MOV	#lo_addr(_music_songLength), W0
	CP	W1, [W0]
	BRA LTU	L__Music_playSongNextNote17
	GOTO	L_Music_playSongNextNote4
L__Music_playSongNextNote17:
;music.c,40 :: 		note = *(music_song + music_currentNote);
	MOV	_music_song, W1
	MOV	#lo_addr(_music_currentNote), W0
	ADD	W1, [W0], W1
;music.c,41 :: 		duration = *(music_song + music_currentNote + 1);
	ADD	W1, #1, W0
;music.c,42 :: 		Music_playNote(note, duration);
	MOV.B	[W0], W11
	MOV.B	[W1], W10
	CALL	_Music_playNote
;music.c,43 :: 		music_currentNote += 2;
	MOV	#2, W1
	MOV	#lo_addr(_music_currentNote), W0
	ADD	W1, [W0], [W0]
;music.c,44 :: 		} else {
	GOTO	L_Music_playSongNextNote5
L_Music_playSongNextNote4:
;music.c,45 :: 		music_isPlaying = FALSE;
	MOV	#lo_addr(_music_isPlaying), W1
	CLR	W0
	MOV.B	W0, [W1]
;music.c,46 :: 		}
L_Music_playSongNextNote5:
;music.c,47 :: 		}
L_end_Music_playSongNextNote:
	POP	W11
	POP	W10
	RETURN
; end of _Music_playSongNextNote

_Music_playNote:
	LNK	#4

;music.c,49 :: 		void Music_playNote(unsigned char note, unsigned char duration) {
;music.c,51 :: 		if (note == PAUSA) {
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV.B	#200, W0
	CP.B	W10, W0
	BRA Z	L__Music_playNote19
	GOTO	L_Music_playNote6
L__Music_playNote19:
;music.c,52 :: 		music_isPlayingNote = FALSE;
	MOV	#lo_addr(_music_isPlayingNote), W1
	CLR	W0
	MOV.B	W0, [W1]
;music.c,53 :: 		timerPeriod = 0.001;
	MOV	#4719, W0
	MOV	#14979, W1
	MOV	W0, [W14+0]
	MOV	W1, [W14+2]
;music.c,54 :: 		} else {
	GOTO	L_Music_playNote7
L_Music_playNote6:
;music.c,55 :: 		music_isPlayingNote = TRUE;
	MOV	#lo_addr(_music_isPlayingNote), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;music.c,56 :: 		timerPeriod = 1.0 / Music_getNoteFrequency(note);
	CALL	_Music_getNoteFrequency
	PUSH	W11
	MOV.D	W0, W2
	MOV	#0, W0
	MOV	#16256, W1
	CALL	__Div_FP
	POP	W11
	MOV	W0, [W14+0]
	MOV	W1, [W14+2]
;music.c,57 :: 		}
L_Music_playNote7:
;music.c,58 :: 		music_tickCounter = (unsigned int) (Music_getActualNoteDuration(duration) / timerPeriod);
	MOV.B	W11, W10
	CALL	_Music_getActualNoteDuration
	MOV	[W14+0], W2
	MOV	[W14+2], W3
	CALL	__Div_FP
	CALL	__Float2Longint
	MOV	W0, _music_tickCounter
;music.c,59 :: 		music_trentaduesimoTicks = (unsigned int) (Music_getActualNoteDuration(TRENTADUESIMO) / timerPeriod);
	MOV.B	#1, W10
	CALL	_Music_getActualNoteDuration
	MOV	[W14+0], W2
	MOV	[W14+2], W3
	CALL	__Div_FP
	CALL	__Float2Longint
	MOV	W0, _music_trentaduesimoTicks
;music.c,60 :: 		setTimer(TIMER4_DEVICE, timerPeriod);
	MOV	[W14+0], W11
	MOV	[W14+2], W12
	MOV.B	#3, W10
	CALL	_setTimer
;music.c,61 :: 		}
L_end_Music_playNote:
	POP	W12
	POP	W11
	POP	W10
	ULNK
	RETURN
; end of _Music_playNote

_Music_getActualNoteDuration:
	LNK	#8

;music.c,63 :: 		float Music_getActualNoteDuration(unsigned char duration) {
;music.c,64 :: 		return ((float) duration / (float) music_songTime) * 7.5; //60 / 8
	ZE	W10, W0
	CLR	W1
	CALL	__Long2Float
	MOV	W0, [W14+4]
	MOV	W1, [W14+6]
	MOV	_music_songTime, W0
	CLR	W1
	CALL	__Long2Float
	MOV	W0, [W14+0]
	MOV	W1, [W14+2]
	MOV	[W14+4], W0
	MOV	[W14+6], W1
	PUSH.D	W2
	MOV	[W14+0], W2
	MOV	[W14+2], W3
	CALL	__Div_FP
	POP.D	W2
	MOV	#0, W2
	MOV	#16624, W3
	CALL	__Mul_FP
;music.c,65 :: 		}
L_end_Music_getActualNoteDuration:
	ULNK
	RETURN
; end of _Music_getActualNoteDuration

_Music_getNoteFrequency:

;music.c,67 :: 		float Music_getNoteFrequency(unsigned char note) {
;music.c,68 :: 		return MUSIC_NOTE_TABLE[note];
	ZE	W10, W0
	SL	W0, #2, W1
	MOV	#lo_addr(_MUSIC_NOTE_TABLE), W0
	ADD	W0, W1, W2
	MOV	#___Lib_System_DefaultPage, W0
	MOV	WREG, 52
	MOV.D	[W2], W0
;music.c,69 :: 		}
L_end_Music_getNoteFrequency:
	RETURN
; end of _Music_getNoteFrequency

music____?ag:

L_end_music___?ag:
	RETURN
; end of music____?ag
