INCLUDE "./include/hardware.inc"
INCLUDE "src/charmap.asm"

SECTION "Player Variables", WRAM0
wPlayerX:: db
wPlayerY:: db
wPlayerCurSprite:: db
wPlayerOrientation:: db

SECTION "Overworld", ROM0
  
UpdatePlayerObject:
	ld hl, wShadowOAM
	ld a, [wPlayerY]
	add a, 16
	ld [hli], a
	ld b, 8
	ld a, [wPlayerOrientation]
	cp a, 0
	jp z, .noflip1
	ld b, 8+8
.noflip1
	ld a, [wPlayerX]
	add a, b
	ld [hli], a
	ld a, [wPlayerCurSprite]
	ld [hli], a
	ld a, [wPlayerOrientation]

	
	ld [hli], a
	ld a, [wPlayerY]
	add a, 16
	ld [hli], a
	ld b, 8+8
	ld a, [wPlayerOrientation]
	cp a, 0
	jp z, .noflip2
	ld b, 8
.noflip2
	ld a, [wPlayerX]
	add a, b
	ld [hli], a
	ld a, [wPlayerCurSprite]
	inc a
	ld [hli], a
	ld a, [wPlayerOrientation]
	
	ld [hli], a
	ld a, [wPlayerY]
	add a, 16+8
	ld [hli], a
	ld b, 8
	ld a, [wPlayerOrientation]
	cp a, 0
	jp z, .noflip3
	ld b, 8+8
.noflip3
	ld a, [wPlayerX]
	add a, b
	ld [hli], a
	ld a, [wPlayerCurSprite]
	add a, 2
	ld [hli], a
	ld a, [wPlayerOrientation]
	ld [hli], a
	ld a, [wPlayerY]
	add a, 16+8
	
	ld [hli], a
	ld b, 8+8
	ld a, [wPlayerOrientation]
	cp a, 0
	jp z, .noflip4
	ld b, 8
.noflip4
	ld a, [wPlayerX]
	add a, b
	ld [hli], a
	ld a, [wPlayerCurSprite]
	add a, 3
	ld [hli], a
	ld a, [wPlayerOrientation]
	ld [hl], a
	
	ret

LoadOverworld::
	ld de, InsideStart
	ld hl, $9000  ; Tileblock 2
	ld bc, InsideEnd - InsideStart
	call Memcopy
	
	; Copy the tilemap
	ld de, HutInsideStart
	ld hl, $9800  ; Tilemap 0
	ld bc, HutInsideEnd - HutInsideStart
	call Memcopy
	
	ld a, 0
	ld b, 160
	ld hl, wShadowOAM
ClearOam:
	ld [hli], a
	dec b
	jp nz, ClearOam
	
	ld hl, _OAMRAM
ClearShadowOam:
	ld [hli], a
	dec b
	jp nz, ClearShadowOam
	
	xor a
	ld [wPlayerX], a
	ld [wPlayerY], a
	ld [wPlayerCurSprite], a
	ld [wPlayerOrientation], a
	
	; write player object
	call UpdatePlayerObject
	
	; load object tiles
	ld de, CharacterMapStart
	ld hl, $8000
	ld bc, CharacterMapEnd - CharacterMapStart
	call Memcopy
	
	ret

InitOverworld::
	call LoadOverworld

	; Turn the LCD on
	ld a, LCDCF_ON | LCDCF_BGON | LCDCF_OBJON
	ld [rLCDC], a
	
	ld a, %11100100
	ld [rBGP], a
	ld a, %11010000
	ld [rOBP0], a
	
	; load story song
	xor a
	ld [wUpdateSound], a
	ld hl, story_song
	call hUGE_init
	inc a
	ld [wUpdateSound], a
	ret
	
UpdateOverworld::
	call WaitVBlank
	
.checkright
	call UpdateKeys
	ld a, [wCurKeys]
	cp a, PADF_RIGHT
	jp nz, .checkleft
	ld a, [wPlayerX]
	add a, 8
	cp a, 19*8
	jp nc, .return
	ld [wPlayerX], a
	ld a, 8
	ld [wPlayerCurSprite], a
	xor a
	ld [wPlayerOrientation], a
	call UpdatePlayerObject
	jp .return
.checkleft
	ld a, [wCurKeys]
	cp a, PADF_LEFT
	jp nz, .checkup
	ld a, [wPlayerX]
	cp a, 0
	jp z, .return
	sub a, 8
	ld [wPlayerX], a
	ld a, 8
	ld [wPlayerCurSprite], a
	ld a, `00100000; flip X
	ld [wPlayerOrientation], a
	call UpdatePlayerObject
	jp .return
.checkup
	ld a, [wCurKeys]
	cp a, PADF_UP
	jp nz, .checkdown
	ld a, [wPlayerY]
	cp a, 0
	jp z, .return
	sub a, 8
	ld [wPlayerY], a
	ld a, 4
	ld [wPlayerCurSprite], a
	xor a
	ld [wPlayerOrientation], a
	call UpdatePlayerObject
	jp .return
.checkdown
	ld a, [wCurKeys]
	cp a, PADF_DOWN
	jp nz, .return 
	ld a, [wPlayerY]
	add a, 8
	cp a, 17*8
	jp nc, .return
	ld [wPlayerY], a
	ld a, 0
	ld [wPlayerCurSprite], a
	xor a
	ld [wPlayerOrientation], a
	call UpdatePlayerObject
	jp .return
.return
	ld  a, HIGH(wShadowOAM)
	call hOAMDMA
	ret
