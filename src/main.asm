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

; Copy bytes from one area to another.
; @param de: Source
; @param hl: Destination
; @param bc: Length
Memcopy::
	ld a, [de]
	ld [hli], a
	inc de
	dec bc
	ld a, b
	or a, c
	jp nz, Memcopy
	ret
    
UpdateKeys::
	; Poll half the controller
	ld a, P1F_GET_BTN
	call .onenibble
	ld b, a ; B7-4 = 1; B3-0 = unpressed buttons

	; Poll the other half
	ld a, P1F_GET_DPAD
	call .onenibble
	swap a ; A3-0 = unpressed directions; A7-4 = 1
	xor a, b ; A = pressed buttons + directions
	ld b, a ; B = pressed buttons + directions

	; And release the controller
	ld a, P1F_GET_NONE
	ldh [rP1], a

	; Combine with previous wCurKeys to make wNewKeys
	ld a, [wCurKeys]
	xor a, b ; A = keys that changed state
	and a, b ; A = keys that changed to pressed
	ld [wNewKeys], a
	ld a, b
	ld [wCurKeys], a
	ret

.onenibble
	ldh [rP1], a ; switch the key matrix
	call .knownret ; burn 10 cycles calling a known ret
	ldh a, [rP1] ; ignore value while waiting for the key matrix to settle
	ldh a, [rP1]
	ldh a, [rP1]
	ldh a, [rP1]
	ldh a, [rP1] ; this read counts
	or a, $F0 ; A7-4 = 1; A3-0 = unpressed keys
.knownret
	ret


	
WaitVBlank::
	ld a, [rLY]
	cp 144
	jp c, WaitVBlank
	ret

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

	; Clear OAM. Important: LCD screen must be off for this!
;	ld a, 0
;	ld b, 160 ; 160 bytes, equals 40 objects!
;	ld hl, _OAMRAM
;ClearOam:
;	ld [hli], a
;	dec b
;	jp nz, ClearOam
	
	; draw objects

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
	

	; Enable Interrupts
	ld a, %00000101 ; timer bit - VBlank bit
	ld [rIE], a
	ei
	call NextGameState
Main:
	ld a, [wGameState]
	cp 1
	call z, UpdateStory
	ld a, [wGameState]
	and a
	call z, UpdateTitleScreen
	jp Main
	
TimerHandler:
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
	
	
	ld a, %00011011
	ld [rBGP], a
	ld a, 12
	ld [wVBlankCount], a
	call WaitForVBlankFunction
	
	ld a, %01101111
	ld [rBGP], a
	ld a, 12
	ld [wVBlankCount], a
	call WaitForVBlankFunction
	
	ld a, %10111111
	ld [rBGP], a
	ld a, 12
	ld [wVBlankCount], a
	call WaitForVBlankFunction
	
	ld a, %11111111
	ld [rBGP], a
	ld a, 12
	ld [wVBlankCount], a
	call WaitForVBlankFunction

	call WaitVBlank
	
	; Turn the LCD off
	xor a
	ld [rLCDC], a

	ld [rSCX], a
	ld [rSCY], a
	ld [rWX], a
	ld [rWY], a
	; disable interrupts
	;call DisableInterrupts

	; Clear all sprites
	;call ClearAllSprites

	; Initiate the next state
	;ld a, [wGameState]
	;cp 2 ; 2 = Gameplay
	;call z, InitGameplayState
	ld a, [wGameState]
	cp 1 ; 1 = Story
	call z, InitStory
	ld a, [wGameState]
	and a ; 0 = Menu
	call z, InitTitleScreen
	ret

