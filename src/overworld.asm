INCLUDE "./include/hardware.inc"
INCLUDE "src/charmap.asm"

SECTION "Player Variables", WRAM0
wPlayerX:: db
wPlayerY:: db
wPlayerCurSprite:: db
wPlayerOrientation:: db

SECTION "Tile Variables", WRAM0
wUnwalkableTileIdx:: db

SECTION "Overworld", ROM0

; Convert a pixel position to a tilemap address
; @b: Y coordinate
; @c: X coordinate
; hl = $9800 + X + Y * 32
; @return hl: tile address
GetPlayerTile:
	; First, we need to divide by 8 to convert a pixel position to a tile position.
	; After this we want to multiply the Y position by 32.
	; These operations effectively cancel out so we only need to mask the Y value.
	ld a, b
	and a, %11111000
	ld l, a
	ld h, 0
	; Now we have the position * 8 in hl
	add hl, hl ; position * 16
	add hl, hl ; position * 32
	; Convert the X position to an offset.
	ld a, c
	srl a ; a / 2
	srl a ; a / 4
	srl a ; a / 8
	; Add the two offsets together.
	add a, l
	ld l, a
	adc a, h
	sub a, l
	ld h, a
	; Add the offset to the tilemap's base address, and we are done!
	ld bc, $9800
	add hl, bc
	ret

  
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
	
	ld  a, HIGH(wShadowOAM)
	call hOAMDMA
	
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
	ld [wPlayerCurSprite], a
	ld [wPlayerOrientation], a
	ld a, $70
	ld [wPlayerX], a
	ld a, $30
	ld [wPlayerY], a
	
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
	
	ld a, %11100100
	ld [rBGP], a
	ld a, %11010000
	ld [rOBP0], a

	; Turn the LCD on
	ld a, LCDCF_ON | LCDCF_BGON | LCDCF_OBJON
	ld [rLCDC], a
	
	; load story song
	xor a
	ld [wUpdateSound], a
	ld hl, story_song
	call hUGE_init
	inc a
	ld [wUpdateSound], a
	ret

; c set if walkable
CanMoveRight:
	ld a, [wPlayerY]
	add a, 8
	ld b, a
	ld a, [wPlayerX]
	add a, 16
	ld c, a
	call GetPlayerTile
	ld a, [hl]
	cp a, $1F
	ret
	
CanMoveLeft:
	ld a, [wPlayerY]
	add a, 8
	ld b, a
	ld a, [wPlayerX]
	sub a, 8
	ld c, a
	call GetPlayerTile
	ld a, [hl]
	cp a, $1F
	ret
	
CanMoveUp:
	ld a, [wPlayerY]
	ld b, a
	ld a, [wPlayerX]
	ld c, a
	call GetPlayerTile
	ld a, [hl]
	cp a, $1F ; so many tiles are walkable, if above, it must be a wall
	jp nc, .return
	
	ld a, [wPlayerY]
	ld b, a
	ld a, [wPlayerX]
	add a, 8
	ld c, a
	call GetPlayerTile
	ld a, [hl]
	cp a, $1F
.return
	ret
	
CanMoveDown:
	ld a, [wPlayerY]
	add a, 16
	ld b, a
	ld a, [wPlayerX]
	ld c, a
	call GetPlayerTile
	ld a, [hl]
	cp a, $1F ; so many tiles are walkable, if above, it must be a wall
	jp nc, .return
	
	ld a, [wPlayerY]
	add a, 16
	ld b, a
	ld a, [wPlayerX]
	add a, 8
	ld c, a
	call GetPlayerTile
	ld a, [hl]
	cp a, $1F
.return
	ret
	
UpdateOverworld::
	call WaitVBlank
	
	
	ld [wUnwalkableTileIdx], a
	
.checkright
	call UpdateKeys
	ld a, [wNewKeys]
	cp a, PADF_RIGHT
	jp nz, .checkleft
	call CanMoveRight
	jp nc, .return
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
	ld a, [wNewKeys]
	cp a, PADF_LEFT
	jp nz, .checkup
	call CanMoveLeft
	jp nc, .return
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
	ld a, [wNewKeys]
	cp a, PADF_UP
	jp nz, .checkdown
	call CanMoveUp
	jp nc, .return
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
	ld a, [wNewKeys]
	cp a, PADF_DOWN
	jp nz, .return 
	call CanMoveDown
	jp nc, .return
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
	
	ret
