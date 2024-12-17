BITRIOTDEV_LOGO_ID:         EQU 1
BITRIOTDEV_LOGO_WIDTH:      EQU 260
BITRIOTDEV_LOGO_HEIGHT:     EQU 20

vdu_logo_data:

    .db 23, 0, 192, 0

    .db 23, 27, 0, BITRIOTDEV_LOGO_ID
    .db 23, 27, 1
    .dw BITRIOTDEV_LOGO_WIDTH, BITRIOTDEV_LOGO_HEIGHT
    incbin     "src/assets/bitriotdev.data"

    .db 23, 27, 0, BITRIOTDEV_LOGO_ID
    .db 23, 27, 3
    .dw 64, 90

vdu_logo_data_end: