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
    include "src/includes/app/menu.inc"
    include "src/includes/app/full_screen.inc"
    include "src/includes/app/small_screen.inc"

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

    call draw_menu

    MOSCALL $1E                         ; load IX with keymap address

    ; If the Escape key is pressed
    ld a, (ix + $02)    
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
    call nz, vdu_screen_clear

    call vdu_vblank

    call vdu_refresh

    jp app_loop

show_full_screen:
    call vdu_screen_clear
    call full_screen
    call play_full_tone
    ret

show_small_screen:
    call vdu_screen_clear
    call small_screen
    call play_small_tone
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

play_full_tone:
    ld hl, full_tone
    ld bc, end_full_tone - full_tone
    rst.lil $18
    ret 

full_tone:  
    .db 23,0,$85
    .db 0
    .db 4,3

    .db 23,0,$85
    .db 0
    .db 0,63
    .dw 1000
    .dw 1500
end_full_tone:

play_small_tone:
    ld hl, small_tone
    ld bc, end_small_tone - small_tone
    rst.lil $18
    ret 

small_tone:  
    .db 23,0,$85
    .db 0
    .db 4,3

    .db 23,0,$85
    .db 0
    .db 0,63
    .dw 1500
    .dw 1500
end_small_tone: