INCLUDE "./include/hardware.inc"

DEF BRICK_LEFT EQU $05
DEF BRICK_RIGHT EQU $06
DEF BLANK_TILE EQU $08

SECTION "Game Variables", WRAM0
wGameState:: db ; current game state: 0 is title screen, 1 is story, 2 is overworld gameplay, 3 is ritual

SECTION "Counter", WRAM0
wTimerCounter:: db ; since "PRESS START" is supposed to blink each second, we must count the timer events
wSecondCounter:: db ; seconds the game is played
wMinuteCounter:: db  ; minutes the game is played
wHourCounter:: db  ; hours the game is played
wVBlankCount:: db ; VBlank counter

SECTION "Sound Variables", WRAM0
wUpdateSound:: db ; if not zero, update hUGEDriver sounds

SECTION "Input Variables", WRAM0
wCurKeys:: db ; currently pressed keys
wNewKeys:: db ; newly pressed keys

SECTION "VBLANK Interrupt Handler", ROM0[$0040]
	jp VBlankHandler
	
SECTION "Timer Interrupt Handler", ROM0[$0050]
	jp TimerHandler
	
SECTION "Header", ROM0[$100]

	jp EntryPoint

	ds $150 - @, 0 ; Make room for the header

EntryPoint:
	; Do not turn the LCD off outside of VBlank
	xor a
	; initialize variables
	ld [wTimerCounter], a
	ld [wSecondCounter], a
	ld [wMinuteCounter], a
	ld [wHourCounter], a
	
	ld [wUpdateSound], a
	
	ld [wGameState], a
	
	; initialize audio
	ld a, $80
	ld [rAUDENA], a
	ld a, $FF
	ld [rAUDTERM], a
	ld a, $77
	ld [rAUDVOL], a
	
	call WaitVBlank

	; During the first (blank) frame, initialize display registers
	ld a, %11100100
	ld [rBGP], a
	ld a, %11100100
	ld [rOBP0], a
	
	; Configure Timer
	
	; $FF-$00=$FF=255, therefore the clock frequency
	; of 4096 Hz is divided by 255,
	; yielding an interrupt frequency of 16 Hz
	ld a, %00000000
	ld [rTMA], a  ; modulo counter
	ld a, %00000100
	ld [rTAC], a ; 4096 Hz
	
	; for Shadow OMR
	call CopyDMARoutine

	; Enable Interrupts
	ld a, %00000101 ; timer bit - VBlank bit
	ld [rIE], a
	ei
	call NextGameState
Main:	
	ld a, [wGameState]
	cp 2
	call z, UpdateOverworld
	ld a, [wGameState]
	cp 1
	call z, UpdateStory
	ld a, [wGameState]
	and a
	call z, UpdateTitleScreen
	jp Main
	
TimerHandler:
	push af
	ld a, [wTimerCounter]
	inc a
	cp a, 16
	jp nz, LoadValue
	; timer completed
	ld a, [wSecondCounter]
	inc a
	cp a, 60
	jp nz, LoadSecondsValue
	; minute completed
	ld a, [wMinuteCounter]
	inc a
	cp a, 60
	jp nz, LoadMinutesValue
	; hour completed
	ld a, [wHourCounter]
	inc a
	ld [wHourCounter], a
	xor a ; must set minute counter to 0
LoadMinutesValue:
	ld [wMinuteCounter], a
	xor a ; must set seconds to 0
LoadSecondsValue:
	ld [wSecondCounter], a
	xor a ; must set timer counter to 0
LoadValue:
	ld [wTimerCounter], a
	pop af
	reti
	
DoSound:
	push af
	push bc
	push de
	push hl
	call hUGE_dosound
	pop hl
	pop de
	pop bc
	pop af
	ret

VBlankHandler:
	ld a, [wUpdateSound]
	cp 0
	call nz, DoSound
	reti
	
NextGameState::
	; Do not turn the LCD off outside of VBlank
	call WaitVBlank
	
	; Turn the LCD off
	call TurnLcdOff
	
	; disable interrupts
	;call DisableInterrupts

	; Clear all sprites
	;call ClearAllSprites

	; Initiate the next state
	ld a, [wGameState]
	cp 2 ; 2 = Gameplay
	call z, InitOverworld
	ld a, [wGameState]
	cp 1 ; 1 = Story
	call z, InitStory
	ld a, [wGameState]
	and a ; 0 = Menu
	call z, InitTitleScreen
	ret

