;
; Title:		       Bitroit.dev
;
; Description:         
; Author:		       Andy McCall, mailme@andymccall.co.uk, others welcome!
;
; Created:		       2024-11-25 @ 17:28
; Last Updated:	       2024-11-25 @ 17:28
;
; Modinfo:

.assume adl=1
.org $040000

    jp start

; MOS header
.align 64
.db "MOS",0,1

; API includes
    include "src/includes/system/mos_api.inc"
    include "src/includes/api/vdu.inc"
    include "src/includes/api/vdu_screen.inc"
    include "src/includes/api/vdu_color.inc"
    include "src/includes/api/vdu_cursor.inc"
    include "src/includes/api/vdu_buffer.inc"
    include "src/includes/api/vdu_bitmap.inc"
    include "src/includes/api/vdu_plot.inc"
    include "src/includes/api/vdu_text.inc"
    include "src/includes/api/sprite.inc"
    include "src/includes/api/vdu_sprite.inc"
    include "src/includes/api/macro_sprite.inc"
    include "src/includes/api/macro_text.inc"
    include "src/includes/api/macro_bitmap.inc"

; App includes
    include "src/includes/app/vdu_data.inc"

start:
    push af
    push bc
    push de
    push ix
    push iy

    call vdu_buffer_clear_all

    ld a, VDU_MODE_512x384x64_60HZ
    call vdu_screen_set_mode

    ld a, VDU_SCALING_OFF
    call vdu_screen_set_scaling

    call vdu_cursor_off

    call vdu_vblank

    call vdu_refresh

; First column of long bars
    ld a, VDU_COL_WHITE
    call vdu_plot_set_fill
    ld bc, 0
    ld de, 0
    ld ix, 63
    ld iy, 299
    call vdu_plot_filled_rect

    ld a, VDU_COL_BRIGHT_YELLOW
    call vdu_plot_set_fill
    ld bc, 64
    ld de, 0
    ld ix, 127
    ld iy, 299
    call vdu_plot_filled_rect

    ld a, VUD_COL_BRIGHT_CYAN
    call vdu_plot_set_fill
    ld bc, 128
    ld de, 0
    ld ix, 191
    ld iy, 299
    call vdu_plot_filled_rect

    ld a, VDU_COL_BRIGHT_GREEN
    call vdu_plot_set_fill
    ld bc, 192
    ld de, 0
    ld ix, 255
    ld iy, 299
    call vdu_plot_filled_rect

    ld a, 0x0D
    call vdu_plot_set_fill
    ld bc, 256
    ld de, 0
    ld ix, 319
    ld iy, 299
    call vdu_plot_filled_rect

    ld a, VDU_COL_BRIGHT_RED
    call vdu_plot_set_fill
    ld bc, 320
    ld de, 0
    ld ix, 383
    ld iy, 299
    call vdu_plot_filled_rect

    ld a, VDU_COL_BRIGHT_BLUE
    call vdu_plot_set_fill
    ld bc, 384
    ld de, 0
    ld ix, 447
    ld iy, 320
    call vdu_plot_filled_rect

    ld a, VDU_COL_BLACK
    call vdu_plot_set_fill
    ld bc, 448
    ld de, 0
    ld ix, 512
    ld iy, 384
    call vdu_plot_filled_rect

; Second row of blocks of narrow bars
    ld a, VDU_COL_BRIGHT_RED
    call vdu_plot_set_fill
    ld bc, 0
    ld de, 300
    ld ix, 96
    ld iy, 320
    call vdu_plot_filled_rect

    ld a, VDU_COL_WHITE
    call vdu_plot_set_fill
    ld bc, 97
    ld de, 300
    ld ix, 191
    ld iy, 320
    call vdu_plot_filled_rect

    ld a, VDU_COL_BRIGHT_YELLOW
    call vdu_plot_set_fill
    ld bc, 192
    ld de, 300
    ld ix, 286
    ld iy, 320
    call vdu_plot_filled_rect

    ld a, VUD_COL_BRIGHT_CYAN
    call vdu_plot_set_fill
    ld bc, 287
    ld de, 300
    ld ix, 383
    ld iy, 320
    call vdu_plot_filled_rect

; Third row of squares
    ld a, VDU_COL_DARK_BLUE
    call vdu_plot_set_fill
    ld bc, 0
    ld de, 321
    ld ix, 63
    ld iy, 512
    call vdu_plot_filled_rect

    ld a, VDU_COL_BLACK
    call vdu_plot_set_fill
    ld bc, 64
    ld de, 321
    ld ix, 127
    ld iy, 512
    call vdu_plot_filled_rect

    ld a, VDU_COL_DARK_MAGENTA
    call vdu_plot_set_fill
    ld bc, 128
    ld de, 321
    ld ix, 191
    ld iy, 512
    call vdu_plot_filled_rect

    ld a, VDU_COL_BLACK
    call vdu_plot_set_fill
    ld bc, 192
    ld de, 321
    ld ix, 255
    ld iy, 512
    call vdu_plot_filled_rect

    ld a, VDU_COL_DARK_GREY
    call vdu_plot_set_fill
    ld bc, 256
    ld de, 321
    ld ix, 319
    ld iy, 512
    call vdu_plot_filled_rect

; Three grey stripes
    ld a, VDU_COL_WHITE
    call vdu_plot_set_fill
    ld bc, 320
    ld de, 321
    ld ix, 342
    ld iy, 512
    call vdu_plot_filled_rect

    ld a, VDU_COL_MID_GREY
    call vdu_plot_set_fill
    ld bc, 343
    ld de, 321
    ld ix, 363
    ld iy, 512
    call vdu_plot_filled_rect

    ld a, VDU_COL_DARK_GREY
    call vdu_plot_set_fill
    ld bc, 364
    ld de, 321
    ld ix, 383
    ld iy, 512
    call vdu_plot_filled_rect

; Black stripe
    ld a, VDU_COL_BLACK
    call vdu_plot_set_fill
    ld bc, 0
    ld de, 80
    ld ix, 512
    ld iy, 120
    call vdu_plot_filled_rect

; Sending a VDU byte stream containing the logo
    ld hl, vdu_logo_data
    ld bc, vdu_logo_data_end - vdu_logo_data
    rst.lil $18

    call play_tone


app_loop:
      
    ld a, mos_getkbmap
	rst.lil $08

    ; If the Escape key is pressed
    ld a, (ix + $0E)    
    bit 0, a
    jp nz, quit

    call vdu_vblank

    call vdu_refresh

    jp app_loop

quit:

    ld hl, VDU_MODE_640x480x4_60HZ
    call vdu_screen_set_mode

    call vdu_cursor_flash

    ld hl, quit_msg
    call vdu_text_print

    pop iy
    pop ix
    pop de
    pop bc
    pop af
    ld hl,0

    ret

quit_msg:
    .db "That was Bitriot.dev, impressive, huh??",13,10,0

play_tone:
    ld hl, tone
    ld bc, end_tone - tone
    rst.lil $18
    ret 

tone:  
    .db 23,0,$85
    .db 0
    .db 4,3

    .db 23,0,$85
    .db 0
    .db 0,63
    .dw 1000
    .dw 1500
end_tone: