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