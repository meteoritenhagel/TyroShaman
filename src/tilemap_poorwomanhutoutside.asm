INCLUDE "./include/hardware.inc"

SECTION "PoorWomanHutOutside Tilemap", ROMX, BANK[1]

PoorWomanHutOutsideStart::
db $4b, $3a, $32, $1c, $3b, $41, $4b, $3a, $32, $1c, $3b, $41, $4b, $3a, $32, $1c, $3b, $41, $4b, $3a, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $4b, $3a, $56, $53, $52, $54, $55, $2f, $31, $49, $43, $4c, $48, $2f, $31, $49, $43, $4c, $48, $30, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $48, $2f, $3d, $3d, $51, $36, $36, $3f, $00, $00, $45, $32, $1c, $3f, $00, $00, $45, $32, $1c, $43, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $1c, $3f, $3c, $3e, $46, $34, $35, $1f, $00, $00, $0c, $31, $49, $0f, $00, $00, $2d, $37, $4f, $42, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $4f, $38, $3e, $46, $4a, $46, $34, $2c, $00, $00, $00, $00, $00, $00, $00, $00, $3b, $41, $4b, $3a, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $4b, $3a, $5a, $5a, $5c, $5c, $5d, $2c, $00, $0a, $00, $00, $00, $00, $00, $00, $43, $4c, $48, $30, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $48, $2f, $58, $47, $4e, $4d, $47, $2c, $00, $00, $00, $00, $00, $00, $00, $00, $45, $32, $1c, $43, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $1c, $3f, $39, $40, $19, $17, $40, $2a, $00, $00, $00, $00, $00, $00, $00, $00, $2d, $37, $4f, $42, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $4f, $38, $23, $16, $22, $22, $16, $00, $00, $00, $00, $00, $00, $07, $00, $00, $3b, $41, $4b, $3a, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $4b, $3a, $00, $00, $00, $00, $00, $00, $00, $00, $07, $00, $00, $00, $00, $00, $43, $4c, $48, $30, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $48, $2f, $00, $00, $00, $0a, $00, $00, $00, $00, $00, $00, $00, $00, $00, $0a, $45, $32, $1c, $43, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $1c, $3f, $00, $07, $00, $00, $00, $00, $00, $00, $00, $00, $00, $07, $00, $00, $0c, $31, $49, $0f, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $4f, $38, $00, $00, $2d, $37, $4f, $38, $00, $00, $2d, $37, $4f, $38, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $4b, $3a, $10, $10, $3b, $41, $4b, $3a, $10, $0e, $3b, $41, $4b, $3a, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $48, $30, $37, $4f, $42, $4c, $48, $30, $37, $4f, $42, $4c, $48, $30, $37, $4f, $38, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $1c, $3b, $41, $4b, $3a, $32, $1c, $3b, $41, $4b, $3a, $32, $1c, $3b, $41, $4b, $3a, $00, $07, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $4f, $42, $4c, $48, $30, $37, $4f, $42, $4c, $48, $30, $37, $4f, $42, $4c, $48, $30, $37, $4f, $38, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $4b, $3a, $32, $1c, $43, $41, $4b, $3a, $32, $1c, $43, $41, $4b, $3a, $32, $1c, $43, $41, $4b, $3a, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
PoorWomanHutOutsideEnd::

PoorWomanHutOutsideLoad::
    ld de, OutsideStart
    ld hl, $9000  ; Tileblock 2
    ld bc, OutsideEnd - OutsideStart
    call Memcopy

    ld de, PoorWomanHutOutsideStart
    ld hl, $9800  ; Tilemap 0
    ld bc, PoorWomanHutOutsideEnd - PoorWomanHutOutsideStart
    call Memcopy

    ld a, $2d
    ld [wUnwalkableTileIdx], a

    ld hl, wCurrentMapCheckExits         ; Point HL to wCurrentMapCheckExits
    ld [hl], LOW(PoorWomanHutOutsideCheckExit)        ; Store the low byte
    inc hl                               ; Move to the high byte
    ld [hl], HIGH(PoorWomanHutOutsideCheckExit)       ; Store the high byte

    call UpdatePlayerObject
    ret

PoorWomanHutOutsideCheckExit::
    ; first check x coordinate
    ld a, [wPlayerX]
    cp a, 32
    jp z, .checkY0
    cp a, 144
    jp z, .checkY1
    ret

    ; if there is a match, check y coordinate

.checkY0
.subcheck0_0
    ld a, [wPlayerY]
    cp a, 48
    jp nz, .subcheck0_1
    ld a, 96
    ld [wPlayerX], a
    ld a, 112
    ld [wPlayerY], a
    ld a, 8
    ld [wVBlankCount], a
    call WaitForVBlankFunction ; wait for 8 VBlanks, since otherwise the game can crash if levels are changed to quickly
    call TurnLcdOff
    call PoorWomanHutInsideLoad
    jp .final
.subcheck0_1
    ret
.checkY1
.subcheck1_0
    ld a, [wPlayerY]
    cp a, 96
    jp nz, .subcheck1_1
    ld a, 8
    ld [wPlayerX], a
    ld a, 88
    ld [wPlayerY], a
    ld a, 8
    ld [wVBlankCount], a
    call WaitForVBlankFunction ; wait for 8 VBlanks, since otherwise the game can crash if levels are changed to quickly
    call TurnLcdOff
    call WayToTheVillage2Load
    jp .final
.subcheck1_1
    ld a, [wPlayerY]
    cp a, 104
    jp nz, .subcheck1_2
    ld a, 8
    ld [wPlayerX], a
    ld a, 88
    ld [wPlayerY], a
    ld a, 8
    ld [wVBlankCount], a
    call WaitForVBlankFunction ; wait for 8 VBlanks, since otherwise the game can crash if levels are changed to quickly
    call TurnLcdOff
    call WayToTheVillage2Load
    jp .final
.subcheck1_2
    ret
.final
    ld a, LCDCF_ON | LCDCF_BGON | LCDCF_OBJON
    ld [rLCDC], a
    ret
