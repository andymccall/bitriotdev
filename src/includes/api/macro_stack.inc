    MACRO macro_stack_push_all
    ex af,af'
    exx
    push af
    push hl
    push bc
    push de

    ex af,af'
    exx
    push af
    push hl
    push bc
    push de
    push ix
    push iy
    ENDMACRO

    MACRO macro_stack_pop_all
    pop iy
    pop ix
    pop de
    pop bc
    pop hl
    pop af
    ex af,af'
    exx

    pop de
    pop bc
    pop hl
    pop af
    ex af,af'
    exx
    ENDMACRO