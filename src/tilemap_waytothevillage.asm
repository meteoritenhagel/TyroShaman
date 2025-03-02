INCLUDE "./include/hardware.inc"

SECTION "WayToTheVillage Tilemap", ROMX, BANK[1]

WayToTheVillageStart::
db $4f, $42, $4c, $48, $30, $37, $4f, $42, $4c, $48, $30, $37, $4f, $42, $4c, $48, $30, $37, $4f, $42, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $4b, $3a, $32, $1c, $43, $41, $4b, $3a, $32, $1c, $43, $41, $4b, $3a, $32, $1c, $43, $41, $4b, $3a, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $48, $30, $37, $4f, $42, $4c, $48, $30, $37, $4f, $42, $4c, $48, $30, $37, $4f, $42, $4c, $48, $30, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $1c, $3b, $41, $4b, $3a, $32, $1c, $3b, $41, $4b, $3a, $32, $1c, $3b, $41, $4b, $3a, $32, $1c, $43, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $49, $43, $4c, $48, $2f, $31, $49, $43, $4c, $48, $30, $37, $4f, $42, $4c, $48, $30, $37, $4f, $42, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $00, $45, $32, $1c, $3f, $00, $00, $45, $32, $1c, $3b, $41, $4b, $3a, $32, $1c, $3b, $41, $4b, $3a, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $00, $0c, $31, $49, $0f, $00, $0a, $0c, $31, $49, $43, $4c, $48, $2f, $31, $49, $43, $4c, $48, $2f, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $03, $09, $02, $00, $00, $45, $32, $1c, $3f, $00, $00, $45, $32, $1c, $3f, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $12, $18, $21, $1d, $00, $00, $0c, $31, $49, $0f, $00, $00, $0c, $31, $49, $0f, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $08, $27, $2b, $1a, $00, $00, $00, $00, $00, $00, $01, $0b, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $08, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $05, $13, $1e, $00, $00, $00, $05, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $00, $2d, $37, $4f, $38, $00, $06, $00, $00, $05, $0b, $00, $00, $12, $26, $15, $00, $00, $00, $12, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $10, $3b, $41, $4b, $3a, $00, $00, $00, $00, $12, $1b, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $4f, $42, $4c, $48, $30, $37, $4f, $38, $00, $00, $2d, $37, $4f, $38, $00, $00, $2d, $37, $4f, $42, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $4b, $3a, $32, $1c, $43, $41, $4b, $3a, $10, $10, $43, $41, $4b, $3a, $10, $10, $43, $41, $4b, $3a, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $48, $30, $37, $4f, $42, $4c, $48, $30, $37, $4f, $42, $4c, $48, $30, $37, $4f, $42, $4c, $48, $30, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $1c, $43, $41, $4b, $3a, $32, $1c, $43, $41, $4b, $3a, $32, $1c, $43, $41, $4b, $3a, $32, $1c, $43, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $4f, $42, $4c, $48, $30, $37, $4f, $42, $4c, $48, $30, $37, $4f, $42, $4c, $48, $30, $37, $4f, $42, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
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
WayToTheVillageEnd::

WayToTheVillageLoad::
    ld de, OutsideStart
    ld hl, $9000  ; Tileblock 2
    ld bc, OutsideEnd - OutsideStart
    call Memcopy

    ld de, WayToTheVillageStart
    ld hl, $9800  ; Tilemap 0
    ld bc, WayToTheVillageEnd - WayToTheVillageStart
    call Memcopy

    ld a, $2d
    ld [wUnwalkableTileIdx], a

    ld hl, wCurrentMapCheckExits         ; Point HL to wCurrentMapCheckExits
    ld [hl], LOW(WayToTheVillageCheckExit)        ; Store the low byte
    inc hl                               ; Move to the high byte
    ld [hl], HIGH(WayToTheVillageCheckExit)       ; Store the high byte

    call UpdatePlayerObject
    ret

WayToTheVillageCheckExit::
    ; first check x coordinate
    ld a, [wPlayerX]
    cp a, 144
    jp z, .checkY0
    cp a, 0
    jp z, .checkY1
    ret

    ; if there is a match, check y coordinate

.checkY0
.subcheck0_0
    ld a, [wPlayerY]
    cp a, 72
    jp nz, .subcheck0_1
    ld a, 8
    ld [wPlayerX], a
    ld a, 80
    ld [wPlayerY], a
    ld a, 8
    ld [wVBlankCount], a
    call WaitForVBlankFunction ; wait for 8 VBlanks, since otherwise the game can crash if levels are changed to quickly
    call TurnLcdOff
    call ShamanHutOutsideLoad
    jp .final
.subcheck0_1
    ld a, [wPlayerY]
    cp a, 88
    jp nz, .subcheck0_2
    ld a, 8
    ld [wPlayerX], a
    ld a, 80
    ld [wPlayerY], a
    ld a, 8
    ld [wVBlankCount], a
    call WaitForVBlankFunction ; wait for 8 VBlanks, since otherwise the game can crash if levels are changed to quickly
    call TurnLcdOff
    call ShamanHutOutsideLoad
    jp .final
.subcheck0_2
    ld a, [wPlayerY]
    cp a, 80
    jp nz, .subcheck0_3
    ld a, 8
    ld [wPlayerX], a
    ld a, 80
    ld [wPlayerY], a
    ld a, 8
    ld [wVBlankCount], a
    call WaitForVBlankFunction ; wait for 8 VBlanks, since otherwise the game can crash if levels are changed to quickly
    call TurnLcdOff
    call ShamanHutOutsideLoad
    jp .final
.subcheck0_3
    ret
.checkY1
.subcheck1_0
    ld a, [wPlayerY]
    cp a, 72
    jp nz, .subcheck1_1
    ld a, 136
    ld [wPlayerX], a
    ld a, 32
    ld [wPlayerY], a
    ld a, 8
    ld [wVBlankCount], a
    call WaitForVBlankFunction ; wait for 8 VBlanks, since otherwise the game can crash if levels are changed to quickly
    call TurnLcdOff
    call WayToTheVillage2Load
    jp .final
.subcheck1_1
    ld a, [wPlayerY]
    cp a, 64
    jp nz, .subcheck1_2
    ld a, 136
    ld [wPlayerX], a
    ld a, 32
    ld [wPlayerY], a
    ld a, 8
    ld [wVBlankCount], a
    call WaitForVBlankFunction ; wait for 8 VBlanks, since otherwise the game can crash if levels are changed to quickly
    call TurnLcdOff
    call WayToTheVillage2Load
    jp .final
.subcheck1_2
    ld a, [wPlayerY]
    cp a, 56
    jp nz, .subcheck1_3
    ld a, 136
    ld [wPlayerX], a
    ld a, 32
    ld [wPlayerY], a
    ld a, 8
    ld [wVBlankCount], a
    call WaitForVBlankFunction ; wait for 8 VBlanks, since otherwise the game can crash if levels are changed to quickly
    call TurnLcdOff
    call WayToTheVillage2Load
    jp .final
.subcheck1_3
    ret
.final
    ld a, LCDCF_ON | LCDCF_BGON | LCDCF_OBJON
    ld [rLCDC], a
    ret
