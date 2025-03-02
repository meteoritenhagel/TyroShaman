INCLUDE "./include/hardware.inc"

SECTION "WayToTheVillage2 Tilemap", ROMX, BANK[1]

WayToTheVillage2Start::
db $48, $30, $41, $4b, $3a, $32, $1c, $3b, $41, $4b, $3a, $32, $1c, $3b, $41, $4b, $3a, $32, $1c, $3b, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $1c, $43, $4c, $48, $2f, $31, $49, $43, $4c, $48, $2f, $31, $49, $43, $4c, $48, $2f, $31, $49, $43, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $4f, $42, $32, $1c, $3f, $00, $00, $45, $32, $1c, $3f, $00, $00, $45, $32, $1c, $3f, $00, $00, $45, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $4b, $3a, $31, $49, $0f, $00, $00, $0c, $31, $49, $0f, $00, $00, $0c, $31, $49, $0f, $00, $0a, $0c, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $48, $30, $37, $4f, $38, $00, $00, $00, $00, $00, $00, $00, $00, $08, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $1c, $43, $41, $4b, $3a, $00, $08, $08, $00, $00, $05, $0b, $00, $00, $00, $08, $00, $08, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $4f, $42, $4c, $48, $2f, $00, $00, $07, $00, $00, $12, $1b, $00, $08, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $4b, $3a, $32, $1c, $3f, $06, $00, $00, $00, $00, $00, $00, $2d, $37, $4f, $38, $2d, $37, $4f, $42, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $48, $2f, $31, $49, $00, $00, $01, $0b, $00, $00, $00, $00, $3b, $41, $4b, $3a, $3b, $41, $4b, $3a, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $1c, $3f, $00, $00, $0a, $05, $13, $1e, $00, $2d, $37, $4f, $42, $4c, $48, $2f, $43, $4c, $48, $30, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $49, $0f, $00, $00, $00, $12, $26, $15, $00, $3b, $41, $4b, $3a, $32, $1c, $3f, $45, $32, $1c, $43, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $07, $00, $00, $00, $00, $00, $00, $43, $4c, $48, $2f, $31, $49, $0f, $2d, $37, $4f, $42, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $00, $07, $00, $00, $00, $00, $05, $0b, $00, $45, $32, $1c, $3f, $00, $00, $00, $3b, $41, $4b, $3a, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $00, $2d, $37, $4f, $38, $00, $12, $1b, $00, $0c, $31, $49, $0f, $00, $00, $00, $43, $4c, $48, $30, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $10, $3b, $41, $4b, $3a, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $45, $32, $1c, $43, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $4f, $42, $4c, $48, $30, $37, $4f, $38, $00, $00, $00, $00, $00, $00, $00, $00, $2d, $37, $4f, $42, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $4b, $3a, $32, $1c, $43, $41, $4b, $3a, $00, $00, $00, $00, $00, $12, $1b, $00, $43, $41, $4b, $3a, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $48, $30, $37, $4f, $42, $4c, $48, $30, $37, $4f, $38, $00, $00, $2d, $37, $4f, $42, $4c, $48, $30, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
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
WayToTheVillage2End::

WayToTheVillage2Load::
    ld de, OutsideStart
    ld hl, $9000  ; Tileblock 2
    ld bc, OutsideEnd - OutsideStart
    call Memcopy

    ld de, WayToTheVillage2Start
    ld hl, $9800  ; Tilemap 0
    ld bc, WayToTheVillage2End - WayToTheVillage2Start
    call Memcopy

    ld a, $2d
    ld [wUnwalkableTileIdx], a

    ld hl, wCurrentMapCheckExits         ; Point HL to wCurrentMapCheckExits
    ld [hl], LOW(WayToTheVillage2CheckExit)        ; Store the low byte
    inc hl                               ; Move to the high byte
    ld [hl], HIGH(WayToTheVillage2CheckExit)       ; Store the high byte

    call UpdatePlayerObject
    ret

WayToTheVillage2CheckExit::
    ; first check x coordinate
    ld a, [wPlayerX]
    cp a, 144
    jp z, .checkY0
    cp a, 0
    jp z, .checkY1
    cp a, 88
    jp z, .checkY2
    ret

    ; if there is a match, check y coordinate

.checkY0
.subcheck0_0
    ld a, [wPlayerY]
    cp a, 32
    jp nz, .subcheck0_1
    ld a, 8
    ld [wPlayerX], a
    ld a, 72
    ld [wPlayerY], a
    ld a, 8
    ld [wVBlankCount], a
    call WaitForVBlankFunction ; wait for 8 VBlanks, since otherwise the game can crash if levels are changed to quickly
    call TurnLcdOff
    call WayToTheVillageLoad
    jp .final
.subcheck0_1
    ld a, [wPlayerY]
    cp a, 40
    jp nz, .subcheck0_2
    ld a, 8
    ld [wPlayerX], a
    ld a, 72
    ld [wPlayerY], a
    ld a, 8
    ld [wVBlankCount], a
    call WaitForVBlankFunction ; wait for 8 VBlanks, since otherwise the game can crash if levels are changed to quickly
    call TurnLcdOff
    call WayToTheVillageLoad
    jp .final
.subcheck0_2
    ret
.checkY1
.subcheck1_0
    ld a, [wPlayerY]
    cp a, 88
    jp nz, .subcheck1_1
    ld a, 136
    ld [wPlayerX], a
    ld a, 96
    ld [wPlayerY], a
    ld a, 8
    ld [wVBlankCount], a
    call WaitForVBlankFunction ; wait for 8 VBlanks, since otherwise the game can crash if levels are changed to quickly
    call TurnLcdOff
    call PoorWomanHutOutsideLoad
    jp .final
.subcheck1_1
    ret
.checkY2
.subcheck2_0
    ld a, [wPlayerY]
    cp a, 128
    jp nz, .subcheck2_1
    ld a, 136
    ld [wPlayerX], a
    ld a, 96
    ld [wPlayerY], a
    ld a, 8
    ld [wVBlankCount], a
    call WaitForVBlankFunction ; wait for 8 VBlanks, since otherwise the game can crash if levels are changed to quickly
    call TurnLcdOff
    call PoorWomanHutOutsideLoad
    jp .final
.subcheck2_1
    ret
.final
    ld a, LCDCF_ON | LCDCF_BGON | LCDCF_OBJON
    ld [rLCDC], a
    ret
