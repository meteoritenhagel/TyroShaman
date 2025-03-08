INCLUDE "./include/hardware.inc"
INCLUDE "./include/constants.inc"
INCLUDE "src/charmap.asm"

DEF BOX_EMPTY EQU $4
DEF BOX_WITH_ARROW EQU $5
DEF BOX_FILLED EQU $6
DEF ARROW EQU $2

DEF EARTH1 EQU $0c
DEF EARTH2 EQU $16
DEF EARTH3 EQU $13
DEF EARTH4 EQU $09

DEF WATER1 EQU $0a
DEF WATER2 EQU $15
DEF WATER3 EQU $12
DEF WATER4 EQU $14

DEF WIND1 EQU $0b
DEF WIND2 EQU $0f
DEF WIND3 EQU $0e
DEF WIND4 EQU $17

DEF FIRE1 EQU $08 
DEF FIRE2 EQU $07 
DEF FIRE3 EQU $11 
DEF FIRE4 EQU $10

SECTION "Ritual Variables", WRAM0
wPlayerLives:: db
wRitualSpirit:: db ; 0 earth, 1 water, 2 wind, 3 fire
wSpiritPosition:: db
wSpiritRhythm::
	.r1 db
	.r2 db
	.r3 db
	.r4 db
	.r5 db
	.r6 db
	.r7 db
	.r8 db
	
wPlayerPosition:: db
wPlayerRhythm::
	.r1 db
	.r2 db
	.r3 db
	.r4 db
	.r5 db
	.r6 db
	.r7 db
	.r8 db
	
wCorrectSolution:: db
wPlayerSolution:: db
wTimePerBeat:: db
	
wWaitCounter:: db

SECTION "RitualScreen", ROM0

DrawText:
	; Wait for VBlank
	ld a, 1
	ld [wVBlankCount], a
	call WaitForVBlankFunction
	
	; Check for the end of string character 255
	ld a, [hl]
	cp 255
	ret z

	; Write the current character (in hl) to the address
	; on the tilemap (in de)
	ld a, [hl]
	add $80
	ld [de], a

	; move to the next character and next background tile
	inc hl
	inc de

	jp DrawText

Wait:
	push af
	push bc
	push hl
	ld a, [wTimePerBeat]
	ld [wWaitCounter], a
.start
	ld a, [wWaitCounter]
	cp a, 0
	jp z, .return
	dec a
	ld [wWaitCounter], a
	xor a
	ld [wUpdateSound], a
	
	ld a, [wTimePerBeat]
	dec a
	ld b, a
	ld a, [wWaitCounter]
	cp a, b
	jp nz, .switchOffSound
	push hl
	ld hl, normalbeat
	call hUGE_init
	pop hl
	inc a
	ld [wUpdateSound], a
	jp .continue
.switchOffSound
	xor a
	ld [wUpdateSound], a
	ld hl, empty_song
	call hUGE_init
	inc a
	ld [wUpdateSound], a
.continue
	ld a, 5
	ld [wVBlankCount], a
	call WaitForVBlankFunction
	jp .start
.return
	pop hl
	pop bc
	pop af
	ret
	
WaitPlayer:
	ld d, h
	ld e, l
	push af
	push bc
	push hl
	ld a, [wTimePerBeat]
	ld [wWaitCounter], a
	ld c, $20
	ld b, 0
	ld h, d
	ld l, e
	add hl, bc
.start
	ld a, [wWaitCounter]
	cp a, 0
	jp z, .return
	dec a
	ld [wWaitCounter], a
	
	call UpdateKeys
	ld a, [wNewKeys]
	cp a, 0
	jp z, .switchOffSound; continue normally if no key was pressed
	; but if a key was pressed, register it
	ld a, BOX_FILLED
	ld [hl], a

	push hl
	ld a, [wPlayerPosition]
	ld b, 0
	ld c, a
	ld hl, wPlayerRhythm
	add hl, bc
	ld a, [hl] ; if already set, don't make sound
	cp a, 0 ; set or unset z
	ld a, 1
	ld [hl], a
	pop hl
	jp nz, .switchOffSound
	
	xor a
	ld [wUpdateSound], a
	push hl
	ld hl, mainbeat
	call hUGE_init
	pop hl
	ld [wUpdateSound], a
	jp .continue
	
.switchOffSound
	nop
	nop
	xor a
	push hl
	ld [wUpdateSound], a
	ld hl, empty_song
	call hUGE_init
	pop hl
	inc a
	ld [wUpdateSound], a
.continue
	ld a, 5
	ld [wVBlankCount], a
	call WaitForVBlankFunction
	jp .start
.return
	ld a, [wPlayerPosition]
	inc a
	ld [wPlayerPosition], a
	pop hl
	pop bc
	pop af
	ret
	
WaitSpirit:
	ld d, h
	ld e, l
	push af
	push bc
	push hl
	ld a, [wTimePerBeat]
	ld [wWaitCounter], a
	ld c, $20
	ld b, 0
	add hl, bc
.start
	ld a, [wWaitCounter]
	cp a, 0
	jp z, .return
	dec a
	ld [wWaitCounter], a
	
	push hl
	ld a, [wSpiritPosition]
	ld b, 0
	ld c, a
	ld hl, wSpiritRhythm
	add hl, bc
	ld a, [hl]
	pop hl
	
	cp a, 0
	jp z, .switchOffSound
	; if the rhythm contains a beat, write it down
	ld a, BOX_FILLED
	ld [hl], a
	xor a
	ld [wUpdateSound], a
	
	ld a, [wTimePerBeat]
	dec a
	ld b, a
	ld a, [wWaitCounter]
	cp a, b
	jp nz, .switchOffSound
	push hl
	ld hl, mainbeat
	call hUGE_init
	pop hl
	inc a
	ld [wUpdateSound], a
	jp .continue
.switchOffSound
	xor a
	ld [wUpdateSound], a
	push hl
	ld hl, empty_song
	call hUGE_init
	pop hl
	inc a
	ld [wUpdateSound], a
.continue
	ld a, 5
	ld [wVBlankCount], a
	call WaitForVBlankFunction
	jp .start
.return
	ld a, [wSpiritPosition]
	inc a
	ld [wSpiritPosition], a
	pop hl
	pop bc
	pop af
	ret
	
Cursor:
	call CursorOuter
	call CursorInner
	call CursorInner
	call CursorInner
	ret
	
CursorPlayer:
	call CursorOuterPlayer
	call CursorInnerPlayer
	call CursorInnerPlayer
	call CursorInnerPlayer
	ret
	
CursorSpirit:
	call CursorOuterSpirit
	call CursorInnerSpirit
	call CursorInnerSpirit
	call CursorInnerSpirit
	ret
	
CursorOuter:
	ld a, BOX_WITH_ARROW
	ld [hl], a
	call Wait
	ld a, BOX_EMPTY
	ld [hli], a
	ret
CursorInner:
	ld a, ARROW
	ld [hl], a
	call Wait
	xor a
	ld [hli], a
	ret
	
CursorOuterPlayer:
	ld a, BOX_WITH_ARROW
	ld [hl], a
	call WaitPlayer
	ld a, BOX_EMPTY
	ld [hli], a
	ret
CursorInnerPlayer:
	ld a, ARROW
	ld [hl], a
	call WaitPlayer
	xor a
	ld [hli], a
	ret

CursorOuterSpirit:
	ld a, BOX_WITH_ARROW
	ld [hl], a
	call WaitSpirit
	ld a, BOX_EMPTY
	ld [hli], a
	ret
CursorInnerSpirit:
	ld a, ARROW
	ld [hl], a
	call WaitSpirit
	xor a
	ld [hli], a
	ret
	
; returns z if ritual was successful
PerformRitual::
	; Stop music
	xor a
	ld [wUpdateSound], a
	ld hl, empty_song
	call hUGE_init
	inc a
	ld [wUpdateSound], a
	
	xor a
	ld [rLCDC], a
	call LoadTextFontIntoVRAM
	call ClearBackground
	
	; READY?
	ld de, $98C2
	ld hl, RitualText.Ready
	call DrawText_WithTypewriterEffect

	ld a, 100
	ld [wVBlankCount], a
	call WaitForVBlankFunction
	
	xor a
	ld [rLCDC], a
	call ritual_tilemapLoad
	
	; set spirit rhythm field
	ld b, `10000000
	ld hl, wSpiritRhythm
.solutionLoop
	ld a, [wCorrectSolution]
	and a, b
	ld [hli], a
	rr b ; sets zero
	jp nz, .solutionLoop
	
	; draw Ritual Spirit and calculate the solution
	; Earth does not change the rhythm
	ld a, [wRitualSpirit]
	cp a, EARTH
	jp nz, .checkWater
	ld a, EARTH1
	ld [$9862], a
	ld a, EARTH2
	ld [$9863], a
	ld a, EARTH3
	ld [$9882], a
	ld a, EARTH4
	ld [$9883], a
	ld hl, RitualText.Earth
	jp .end
.checkWater
	; water means starting one beat too late
	cp a, WATER
	jp nz, .checkWind
	
	ld a, [wCorrectSolution]
	rra
	ld [wCorrectSolution], a
	
	
	ld a, WATER1
	ld [$9862], a
	ld a, WATER2
	ld [$9863], a
	ld a, WATER3
	ld [$9882], a
	ld a, WATER4
	ld [$9883], a
	ld hl, RitualText.Water
	jp .end
.checkWind
	; wind means starting one beat too early
	cp a, WIND
	jp nz, .checkFire
	
	ld a, [wCorrectSolution]
	rla
	ld [wCorrectSolution], a
	
	ld a, WIND1
	ld [$9862], a
	ld a, WIND2
	ld [$9863], a
	ld a, WIND3
	ld [$9882], a
	ld a, WIND4
	ld [$9883], a
	ld hl, RitualText.Wind
	jp .end
.checkFire
	; fire inverts the solution
	ld a, [wCorrectSolution]
	cpl a
	ld [wCorrectSolution], a
	ld a, FIRE1
	ld [$9862], a
	ld a, FIRE2
	ld [$9863], a
	ld a, FIRE3
	ld [$9882], a
	ld a, FIRE4
	ld [$9883], a
	ld hl, RitualText.Fire
.end
	ld a, %11100100
	ld [rBGP], a

	; Turn the LCD on
	ld a, LCDCF_ON | LCDCF_BGON
	ld [rLCDC], a
	
	ld de, $9865
	call DrawText
	
	ld de, $9885
	ld hl, RitualText.Spirit
	call DrawText
	
	ld de, $986D
	ld hl, RitualText.Lives
	call DrawText
	
	ld a, 3
	ld [wPlayerLives], a
	; draw lives
	add a, $90
	ld [$9891], a
	
	
	ld a, 20
	ld [wVBlankCount], a
	call WaitForVBlankFunction
	
.loop
	; clean wPlayerRhythm
	ld b, 8
	xor a
	ld hl, wPlayerRhythm.r1
.cleanLoop
	ld [hli], a
	dec b
	jp nz, .cleanLoop
	
	; draw lives
	ld a, [wPlayerLives]
	add a, $90
	ld [$9891], a
	
; clean spirit rhythm display
	ld b, 8
	ld a, BOX_EMPTY
	ld hl, $98e6
.cleanSpirit
	ld [hli], a
	dec b
	jp nz, .cleanSpirit
	
	; clean player rhythm display
	ld b, 8
	ld a, BOX_EMPTY
	ld hl, $99C6
.cleanDisplay
	ld [hli], a
	dec b
	jp nz, .cleanDisplay
	
	; draw lives
	ld a, [wPlayerLives]
	add a, $90
	ld [$9891], a
	
	ld hl, $98C2 ; position cursor
	xor a
	ld [wSpiritPosition], a
	call Cursor
	call CursorSpirit
	call CursorSpirit
	call Cursor
	
	ld hl, $99A2 ; position cursor
	xor a
	ld [wPlayerPosition], a
	call Cursor
	call CursorPlayer
	call CursorPlayer
	call Cursor
	
	; set solution
	ld b, `10000000
	ld c, 0 ; save solution in c
	ld hl, wPlayerRhythm
.playerInputLoop
	ld a, [hli]
	cp a, 0
	jp nz, .setPlayerBit
	jp .jumpOverPlayer
.setPlayerBit
	ld a, c
	or a, b
	ld c, a
.jumpOverPlayer
	rr b
	jp nz, .playerInputLoop
	ld a, c
	ld [wPlayerSolution], a
	
	; check if solution is correct
	ld b, a
	ld a, [wCorrectSolution]
	cp a, b
	jp z, .success
	
	ld a, [wPlayerLives]
	dec a
	ld [wPlayerLives], a
	cp a, 0
	jp nz, .loop
	
	; failure
	call ClearBackground
	
	ld a, %00011011
	ld [rBGP], a
	
	ld de, $98C2
	ld hl, RitualText.Failure1
	call DrawText_WithTypewriterEffect
	
	ld de, $98E2
	ld hl, RitualText.Failure2
	call DrawText_WithTypewriterEffect
	
	xor a
	ld [wUpdateSound], a
	ld hl, music_gameover
	call hUGE_init
	inc a
	ld [wUpdateSound], a
	
	ld de, $9922
	ld hl, RitualText.Failure3
	call DrawText_WithTypewriterEffect
	
	ld a, 150
	ld [wVBlankCount], a
	call WaitForVBlankFunction
	call FadeToBlack
	
	xor a
	cp a, 1
	
	ret
	
.success
	ld a, [wSuccessfulRitualCounter]
	cp a, NUM_RITUALS_UNTIL_FINISHED-1
	jp z, .youWon
	inc a
	ld [wSuccessfulRitualCounter], a
	
	xor a
	ld [wUpdateSound], a
	ld hl, music_success
	call hUGE_init
	inc a
	ld [wUpdateSound], a
	
	call ClearBackground
	
	ld de, $98A2
	ld hl, RitualText.Success1
	call DrawText_WithTypewriterEffect
	
	ld de, $9902
	ld hl, RitualText.Success2
	call DrawText_WithTypewriterEffect
	
	ld de, $9962
	ld hl, RitualText.Success3
	call DrawText_WithTypewriterEffect
	
	ld a, 30
	ld [wVBlankCount], a
	call WaitForVBlankFunction
	call FadeToBlack
	
	cp a
	ret
	
.youWon
	call ClearBackground
	
	ld de, $98A1
	ld hl, FinalText.Success1
	call DrawText_WithTypewriterEffect
	
	ld de, $9901
	ld hl, FinalText.Success2
	call DrawText_WithTypewriterEffect
	
	ld de, $9961
	ld hl, FinalText.Success3
	call DrawText_WithTypewriterEffect
	
.finalLoop
	jp .finalLoop
	
	
SECTION "RitualText", ROMX, BANK[1]

RitualText:
	.Ready db "Ready...?", 255
	.Success1 db "The patient's", 255
	.Success2 db "spirit is healed!", 255
	.Success3 db "Time to rest.", 255
	.Failure1 db "You feel dizzy", 255
	.Failure2 db "and fall down.", 255
	.Failure3 db "Is this the end?", 255
	.Lives db "LIVES", 255
        .Spirit db "SPIRIT", 255
	.Earth db "EARTH", 255
	.Water db "WATER", 255
	.Wind db "WIND ", 255
	.Fire db "FIRE ", 255
	
SECTION "Final Text", ROMX, BANK[1]
FinalText:
	.Success1 db "Thank you, Naura!", 255
	.Success2 db "  You saved the", 255
	.Success3 db "  SUN FESTIVAL!", 255
