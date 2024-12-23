draw_menu:

    macro_text_set_color 11

    ; Print the menu text
    ld hl, menu_txt
    ld bc, menu_txt_end - menu_txt
    rst.lil $18

    ret

menu_txt:
    .db     31, 0, 47
    .db     "[F] Full Screen  [S] Small Screen  [C] Clear Screen  [Q] Quit  "
menu_txt_end: