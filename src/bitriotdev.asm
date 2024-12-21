;
; Title:		       Bitroit.dev
;
; Description:         Simple splash screen for Bitriot.dev
; Author:		       Andy McCall, andy@bitriot.dev, others welcome!
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
    include "src/includes/api/macro_stack.inc"
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
    macro_stack_push_all

    call vdu_buffer_clear_all

    ld a, VDU_MODE_512x384x64_60HZ
    call vdu_screen_set_mode

    ld a, VDU_SCALING_OFF
    call vdu_screen_set_scaling

    call vdu_cursor_off

    call vdu_vblank

    call vdu_refresh

    ;call play_tone

    ld a, mos_getkbmap
	rst.lil $08

    ; Sending a VDU byte stream containing the logo
    ld hl, vdu_logo_data
    ld bc, vdu_logo_data_end - vdu_logo_data
    rst.lil $18

app_loop:

    MOSCALL $1E                         ; load IX with keymap address

    ; If the Escape key is pressed
    ld a, (ix + $0E)    
    bit 0, a
    jp nz, quit

    ; If the F key is pressed
    ld a, (ix + $08)    
    bit 3, a
    call nz, show_full_screen

    ; If the C key is pressed
    ld a, (ix + $0A)
    bit 1, a
    call nz, show_small_screen

    ; If the C key is pressed
    ld a, (ix + $0A)
    bit 2, a
    call nz, clear_screen

    call vdu_vblank

    call vdu_refresh

    jp app_loop

show_full_screen:
    call clear_screen
    call full_screen
    call play_tone
    ret

show_small_screen:
    call clear_screen
    call small_screen
    ret

quit:

    ld hl, VDU_MODE_640x480x4_60HZ
    call vdu_screen_set_mode

    call vdu_cursor_flash

    ld hl, quit_msg
    call vdu_text_print

    macro_stack_pop_all

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


full_screen:

    push ix

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

    ld a, VDU_COL_BRIGHT_CYAN
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

    ld a, VDU_COL_BRIGHT_MAGENTA
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

    ld a, VDU_COL_BRIGHT_CYAN
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

    ld hl, BITRIOTDEV_FULL_LOGO_ID
    call vdu_buffer_select
    ld bc, 64
    ld de, 90
    call vdu_bitmap_plot

    pop ix

    ret

small_screen:


; First column of long bars
    ld a, VDU_COL_WHITE
    call vdu_plot_set_fill
    ld bc, 100
    ld de, 100
    ld ix, 139
    ld iy, 199
    call vdu_plot_filled_rect

    ld a, VDU_COL_BRIGHT_YELLOW
    call vdu_plot_set_fill
    ld bc, 140
    ld de, 100
    ld ix, 179
    ld iy, 199
    call vdu_plot_filled_rect

    ld a, VDU_COL_BRIGHT_CYAN
    call vdu_plot_set_fill
    ld bc, 180
    ld de, 100
    ld ix, 219
    ld iy, 199
    call vdu_plot_filled_rect

    ld a, VDU_COL_BRIGHT_GREEN
    call vdu_plot_set_fill
    ld bc, 220
    ld de, 100
    ld ix, 259
    ld iy, 199
    call vdu_plot_filled_rect

    ld a, VDU_COL_BRIGHT_MAGENTA
    call vdu_plot_set_fill
    ld bc, 260
    ld de, 100
    ld ix, 299
    ld iy, 199
    call vdu_plot_filled_rect

    ld a, VDU_COL_BRIGHT_RED
    call vdu_plot_set_fill
    ld bc, 300
    ld de, 100
    ld ix, 339
    ld iy, 199
    call vdu_plot_filled_rect

    ld a, VDU_COL_BRIGHT_BLUE
    call vdu_plot_set_fill
    ld bc, 340
    ld de, 100
    ld ix, 379
    ld iy, 214
    call vdu_plot_filled_rect

; Second row of blocks of narrow bars
    ld a, VDU_COL_BRIGHT_RED
    call vdu_plot_set_fill
    ld bc, 100
    ld de, 200
    ld ix, 159
    ld iy, 214
    call vdu_plot_filled_rect

    ld a, VDU_COL_WHITE
    call vdu_plot_set_fill
    ld bc, 160
    ld de, 200
    ld ix, 219
    ld iy, 214
    call vdu_plot_filled_rect

    ld a, VDU_COL_BRIGHT_YELLOW
    call vdu_plot_set_fill
    ld bc, 220
    ld de, 200
    ld ix, 279
    ld iy, 214
    call vdu_plot_filled_rect

    ld a, VDU_COL_BRIGHT_CYAN
    call vdu_plot_set_fill
    ld bc, 280
    ld de, 200
    ld ix, 339
    ld iy, 214
    call vdu_plot_filled_rect

; Third row of squares
    ld a, VDU_COL_DARK_BLUE
    call vdu_plot_set_fill
    ld bc, 100
    ld de, 215
    ld ix, 139
    ld iy, 254
    call vdu_plot_filled_rect

    ld a, VDU_COL_BLACK
    call vdu_plot_set_fill
    ld bc, 140
    ld de, 215
    ld ix, 179
    ld iy, 254
    call vdu_plot_filled_rect

    ld a, VDU_COL_DARK_MAGENTA
    call vdu_plot_set_fill
    ld bc, 180
    ld de, 215
    ld ix, 219
    ld iy, 254
    call vdu_plot_filled_rect

    ld a, VDU_COL_BLACK
    call vdu_plot_set_fill
    ld bc, 220
    ld de, 215
    ld ix, 259
    ld iy, 254
    call vdu_plot_filled_rect

    ld a, VDU_COL_DARK_GREY
    call vdu_plot_set_fill
    ld bc, 260
    ld de, 215
    ld ix, 299
    ld iy, 254
    call vdu_plot_filled_rect

    ld a, VDU_COL_WHITE
    call vdu_plot_set_fill
    ld bc, 300
    ld de, 215
    ld ix, 312
    ld iy, 254
    call vdu_plot_filled_rect

    ld a, VDU_COL_MID_GREY
    call vdu_plot_set_fill
    ld bc, 313
    ld de, 215
    ld ix, 326
    ld iy, 254
    call vdu_plot_filled_rect

    ld a, VDU_COL_DARK_GREY
    call vdu_plot_set_fill
    ld bc, 327
    ld de, 215
    ld ix, 339
    ld iy, 254
    call vdu_plot_filled_rect

; Black stripe
    ld a, VDU_COL_BLACK
    call vdu_plot_set_fill
    ld bc, 100
    ld de, 130
    ld ix, 379
    ld iy, 150
    call vdu_plot_filled_rect

   ld hl, BITRIOTDEV_SMALL_LOGO_ID
    call vdu_buffer_select
    ld bc, 140
    ld de, 135
    call vdu_bitmap_plot

    pop ix

    ret

clear_screen:
    ld a, quit_msg
    call vdu_text_print
    ld a, 16
    rst.lil $10
    ret