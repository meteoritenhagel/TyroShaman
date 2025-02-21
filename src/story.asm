INCLUDE "./include/hardware.inc"
INCLUDE "src/charmap.asm"

SECTION "Story", ROM0

LoadTextFontIntoVRAM:
	; Copy the font data
	ld de, Font
	ld hl, $8800  ; Tileblock 1
	ld bc, FontEnd - Font
	call Memcopy
	
ClearBackground::
    ; Turn the LCD off
    xor a
    ld [rLCDC], a
    ld bc, 1024
    ld hl, $9800
ClearBackgroundLoop:
    ld a, $80
    ld [hli], a
    dec bc
    ld a, b
    or c
    jp nz, ClearBackgroundLoop
    ; Turn the LCD on
    ld a, LCDCF_ON  | LCDCF_BGON ;|LCDCF_OBJON | LCDCF_OBJ16
    ld [rLCDC], a
    ret

	
DrawText_WithTypewriterEffect::
	; Wait a bit
	ld a, 6
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

	jp DrawText_WithTypewriterEffect

InitStory::
	call LoadTextFontIntoVRAM
	
	ld a, %11100100
	ld [rBGP], a
	
	call ClearBackground

	; Turn the LCD on
	ld a, LCDCF_ON | LCDCF_BGON ;| LCDCF_OBJON
	ld [rLCDC], a
	
	; load story song
	xor a
	ld [wUpdateSound], a
	ld hl, story_song
	call hUGE_init
	inc a
	ld [wUpdateSound], a
	ret
	
UpdateStory::
	call WaitVBlank
	
	; Call Our function that typewrites text onto background/window tiles
	ld de, $9821
	ld hl, Story.Line1
	call DrawText_WithTypewriterEffect
	
	ld de, $9861
	ld hl, Story.Line2
	call DrawText_WithTypewriterEffect
	
	ld de, $98A1
	ld hl, Story.Line3
	call DrawText_WithTypewriterEffect
	
	ld de, $98E1
	ld hl, Story.Blank
	call DrawText_WithTypewriterEffect
	
	ld de, $9921
	ld hl, Story.Line4
	call DrawText_WithTypewriterEffect
	
	ld de, $9961
	ld hl, Story.Line5
	call DrawText_WithTypewriterEffect
	
	ld de, $99A1
	ld hl, Story.Line6
	call DrawText_WithTypewriterEffect
	
	ld de, $99E1
	ld hl, Story.Line7
	call DrawText_WithTypewriterEffect

	ret
	
	
SECTION "Text", ROM0

Story: 
        ;.Line1 db "The galatic empire", 255
        .Blank db " ", 255
	.Line1 db "Naura...", 255
	.Line2 db "Naura, awaken", 255
	.Line3 db "from your sleep...", 255
	.Line4 db "Awaken... For the", 255
	.Line5 db "'Curse of Miswend'", 255
	.Line6 db "has fallen upon", 255
	.Line7 db "the lands.", 255


Font:
INCBIN "./res/font.2bpp"
FontEnd:
