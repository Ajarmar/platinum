    .gba

    REG_NEW_CHECKPOINTS equ 0x08360000
    REG_NEW_CHECKPOINTS_AREA equ 0x200
    REG_SKIP_FUNCS equ REG_NEW_CHECKPOINTS+REG_NEW_CHECKPOINTS_AREA
    REG_SKIP_FUNCS_AREA equ 0x1A0
    REG_INTRO_CHKPNT_NEW equ REG_SKIP_FUNCS+REG_SKIP_FUNCS_AREA
    REG_INTRO_CHKPNT_NEW_AREA equ 0x250
    REG_PANTER_CHKPNT_4 equ REG_INTRO_CHKPNT_NEW+REG_INTRO_CHKPNT_NEW_AREA
    REG_PANTER_CHKPNT_4_AREA equ 0x150
    REG_POLER_CHKPNT_4 equ REG_PANTER_CHKPNT_4+REG_PANTER_CHKPNT_4_AREA
    REG_POLER_CHKPNT_4_AREA equ 0x100
    REG_CMDROOM_CHKPNT_NEW equ REG_POLER_CHKPNT_4+REG_POLER_CHKPNT_4_AREA
    REG_CMDROOM_CHKPNT_NEW_AREA equ 0x400
    REG_CMDROOM_CIEL_HANDLING equ REG_CMDROOM_CHKPNT_NEW+REG_CMDROOM_CHKPNT_NEW_AREA
    REG_CMDROOM_CIEL_HANDLING_AREA equ 0x180
    REG_CMDROOM_ELPIZO_HANDLING equ REG_CMDROOM_CIEL_HANDLING+REG_CMDROOM_CIEL_HANDLING_AREA
    REG_CMDROOM_ELPIZO_HANDLING_AREA equ 0x44
    REG_OVERFLOW equ 0x0836DB00
    REG_OVERFLOW_AREA equ 0x1