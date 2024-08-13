; copies c bytes of data from hl to de, b times.
; used to copy gfx data with c = TILE_SIZE
; input:
;	b = number of times to copy
;	c = number of bytes to copy
;	hl = address from which to start copying the data
;	de = where to copy the data
CopyGfxData::
	ld a, [wLCDC]
	rla
	jr nc, .next_tile
.hblank_copy
	push bc
	push hl
	push de
	ld b, c
	call HblankCopyDataHLtoDE
	ld b, $0
	pop hl
	add hl, bc
	ld e, l
	ld d, h
	pop hl
	add hl, bc
	pop bc
	dec b
	jr nz, .hblank_copy
	ret
.next_tile
	push bc
.copy_tile
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .copy_tile
	pop bc
	dec b
	jr nz, .next_tile
	ret


; copies bc bytes from hl to de
; preserves all registers except af
; input:
;	bc = number of bytes to copy
;	hl = address from which to start copying the data
;	de = where to copy the data
CopyDataHLtoDE_SaveRegisters::
	push hl
	push de
	push bc
	call CopyDataHLtoDE
	pop bc
	pop de
	pop hl
	ret


; copies bc bytes from hl to de
; input:
;	bc = number of bytes to copy
;	hl = address from which to start copying the data
;	de = where to copy the data
CopyDataHLtoDE::
	ld a, [hli]
	ld [de], a
	inc de
	dec bc
	ld a, c
	or b
	jr nz, CopyDataHLtoDE
	ret


; copies b bytes of data from hl to de
; if LCD on, copy during h-blank only
; input:
;	b = number of bytes to copy
;	hl = address from which to start copying the data
;	de = where to copy the data
SafeCopyDataHLtoDE::
	ld a, [wLCDC]
	rla
	jr c, HblankCopyDataHLtoDE
.lcd_off_loop
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .lcd_off_loop
	ret


; copies b bytes of data from hl to de, but only during hblank
; preserves bc
; input:
;	b = number of bytes to copy
;	hl = address from which to start copying the data
;	de = where to copy the data
HblankCopyDataHLtoDE::
	push bc
.loop
	ei
	di
	ldh a, [rSTAT]       ;
	and STAT_LCDC_STATUS ;
	jr nz, .loop         ; assert hblank
	ld a, [hl]
	ld [de], a
	ldh a, [rSTAT]       ;
	and STAT_LCDC_STATUS ;
	jr nz, .loop         ; assert still in hblank
	ei
	inc hl
	inc de
	dec b
	jr nz, .loop
	pop bc
	ret


; copies c bytes of data from de to hl
; if LCD on, copy during h-blank only
; input:
;	c = number of bytes to copy
;	de = address from which to start copying the data
;	hl = where to copy the data
SafeCopyDataDEtoHL::
	ld a, [wLCDC]
	bit LCDC_ENABLE_F, a
	jr nz, HblankCopyDataDEtoHL  ; LCD is on
.lcd_off_loop::
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .lcd_off_loop
	ret


; copies c bytes of data from de to hl, but only during hblank
; preserves bc
; input:
;	c = number of bytes to copy
;	de = address from which to start copying the data
;	hl = where to copy the data
HblankCopyDataDEtoHL::
	push bc
.loop
	ei
	di
	ldh a, [rSTAT]       ;
	and STAT_LCDC_STATUS ;
	jr nz, .loop         ; assert hblank
	ld a, [de]
	ld [hl], a
	ldh a, [rSTAT]       ;
	and STAT_LCDC_STATUS ;
	jr nz, .loop         ; assert still in hblank
	ei
	inc hl
	inc de
	dec c
	jr nz, .loop
	pop bc
	ret


; Copies bc bytes from [wTempPointer] to de
; preserves all registers except af
; input:
;	bc = number of bytes to copy
;	[wTempPointer] = address from which to start copying the data
;	de = where to copy the data
CopyBankedDataToDE::
	ldh a, [hBankROM]
	push af
	push hl
	ld a, [wTempPointerBank]
	call BankswitchROM
	ld a, [wTempPointer]
	ld l, a
	ld a, [wTempPointer + 1]
	ld h, a
	call CopyDataHLtoDE_SaveRegisters
	pop hl
	pop af
	jp BankswitchROM


; fills de with b bytes of the value in register a
; preserves af and hl
; input:
;	a = byte to copy
;	b = number of bytes to copy
;	de = where to copy the data
FillDEWithA:
	push hl
	ld l, e
	ld h, d
.loop
	ld [hli], a
	dec b
	jr nz, .loop
	pop hl
	ret


; fills bc bytes of data at hl with a
; preserves all registers except af
; input:
;	a = data to copy
;	bc = how many times to copy the data
;	hl = where to copy the data
FillMemoryWithA::
	push hl
	push de
	push bc
	ld e, a
.loop
	ld [hl], e
	inc hl
	dec bc
	ld a, b
	or c
	jr nz, .loop
	pop bc
	pop de
	pop hl
	ret


; fills 2*bc bytes of data at hl with d,e
; preserves all registers except af
; input:
;	de = data to copy
;	bc = how many times to copy the data
;	hl = where to copy the data
FillMemoryWithDE::
	push hl
	push bc
.loop
	ld [hl], e
	inc hl
	ld [hl], d
	inc hl
	dec bc
	ld a, b
	or c
	jr nz, .loop
	pop bc
	pop hl
	ret
