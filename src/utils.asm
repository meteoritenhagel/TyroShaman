INCLUDE "./include/hardware.inc"

SECTION "Utility Functions", ROM0

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
	ldh a, [rP1] ; this read counts
	or a, $F0 ; A7-4 = 1; A3-0 = unpressed keys
.knownret
	ret

WaitVBlank::
	ld a, [rLY]
	cp 144
	jp c, WaitVBlank
	ret
	
WaitForVBlankFunction::
WaitForVBlankFunction_Loop:

    ld a, [rLY] ; Copy the vertical line to a
    cp 144 ; Check if the vertical line (in a) is 0
    jp c, WaitForVBlankFunction_Loop ; A conditional jump. The condition is that 'c' is set, the last operation overflowed

    ld a, [wVBlankCount]
    sub 1
    ld [wVBlankCount], a
    ret z
WaitForVBlankFunction_Loop2:
    ld a, [rLY] ; Copy the vertical line to a
    cp 144 ; Check if the vertical line (in a) is 0
    jp nc, WaitForVBlankFunction_Loop2 ; A conditional jump. The condition is that 'c' is set, the last operation overflowed
    jp WaitForVBlankFunction_Loop

FadeToBlack::
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
	ret
	
FadeFromBlack::
	ld a, %11111111
	ld [rBGP], a
	ld a, 12
	ld [wVBlankCount], a
	call WaitForVBlankFunction
	
	ld a, %10111111
	ld [rBGP], a
	ld a, 12
	ld [wVBlankCount], a
	call WaitForVBlankFunction
	
	ld a, %01101111
	ld [rBGP], a
	ld a, 12
	ld [wVBlankCount], a
	call WaitForVBlankFunction
	
	ld a, %00011011
	ld [rBGP], a
	ld a, 12
	ld [wVBlankCount], a
	call WaitForVBlankFunction
	ret
	
	
	
	
