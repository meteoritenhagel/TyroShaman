INCLUDE "./include/hardware.inc"

SECTION "TitleScreen", ROMX, BANK[1]

InitTitleScreen::	
	; Copy the tile data
	ld de, TilesTitle
	ld hl, $9000  ; Tileblock 2
	ld bc, TilesTitleEnd - TilesTitle
	call Memcopy

	; Copy the tilemap
	ld de, TilemapTitle
	ld hl, $9800  ; Tilemap 0
	ld bc, TilemapTitleEnd - TilemapTitle
	call Memcopy
	
	; Turn the LCD on
	ld a, LCDCF_ON | LCDCF_BGON
	ld [rLCDC], a
	
	; load intro song
	xor a
	ld [wUpdateSound], a
	ld hl, title_song
	call hUGE_init
	inc a
	ld [wUpdateSound], a
	ret
	
UpdateTitleScreen::
	call WaitVBlank
	ld a, [wTimerCounter]
	cp 8
	jp c, .ChangePaletteTwo ; one half of cases, one palette
.ChangePaletteOne:
	; modify palette to let "Press START" blink
	ld a, %00011011
	jp .LoadIntoPalette ; other half of cases, second palette
.ChangePaletteTwo:
	ld a, %00010111
.LoadIntoPalette:
	ld [rBGP], a
.CheckPressStart:
	call UpdateKeys
	ld a, [wCurKeys]
	cp a, PADF_START
	ret nz ; continue normally if start wasn't pressed
	call FadeToBlack
	ld a, 1
	ld [wGameState], a
	call NextGameState
	ret
	
SECTION "Start Screen Tiles", ROMX, BANK[1]

TilesTitle:
INCBIN "./res/background/title.2bpp"
TilesTitleEnd:

SECTION "Start Screen Tilemaps", ROMX, BANK[1]

TilemapTitle:
INCBIN "./res/background/title.tilemap"
TilemapTitleEnd:

