    .gba

    REG_NEW_CHECKPOINTS equ 0x08360000
    REG_NEW_CHECKPOINTS_AREA equ 0x200
    REG_SKIP_FUNCS equ REG_NEW_CHECKPOINTS+REG_NEW_CHECKPOINTS_AREA
    REG_SKIP_FUNCS_AREA equ 0x1A0
    REG_INTRO_CHKPNT_NEW equ REG_SKIP_FUNCS+REG_SKIP_FUNCS_AREA
    REG_INTRO_CHKPNT_NEW_AREA equ 0x250
    REG_PANTER_CHKPNT_4 equ REG_INTRO_CHKPNT_NEW+REG_INTRO_CHKPNT_NEW_AREA
    REG_PANTER_CHKPNT_4_AREA equ 0x150
    REG_PHOENIX_CHKPNT_NEW equ REG_PANTER_CHKPNT_4+REG_PANTER_CHKPNT_4_AREA
    REG_PHOENIX_CHKPNT_NEW_AREA equ 0x440
    REG_PHOENIX_BOSS_INTRO_HANDLING equ REG_PHOENIX_CHKPNT_NEW+REG_PHOENIX_CHKPNT_NEW_AREA
    REG_PHOENIX_BOSS_INTRO_HANDLING_AREA equ 0x60
    REG_POLER_CHKPNT_4 equ REG_PHOENIX_BOSS_INTRO_HANDLING+REG_PHOENIX_BOSS_INTRO_HANDLING_AREA
    REG_POLER_CHKPNT_4_AREA equ 0x100
    REG_HYLEG_CHKPNT_NEW equ REG_POLER_CHKPNT_4+REG_POLER_CHKPNT_4_AREA
    REG_HYLEG_CHKPNT_NEW_AREA equ 0x140
    REG_NA1_CHKPNT_3 equ REG_HYLEG_CHKPNT_NEW+REG_HYLEG_CHKPNT_NEW_AREA
    REG_NA1_CHKPNT_3_AREA equ 0x40
    REG_KUWAGUST_CHKPNT_NEW equ REG_NA1_CHKPNT_3+REG_NA1_CHKPNT_3_AREA
    REG_KUWAGUST_CHKPNT_NEW_AREA equ 0x260
    REG_KUWAGUST_CIEL_HANDLING equ REG_KUWAGUST_CHKPNT_NEW+REG_KUWAGUST_CHKPNT_NEW_AREA
    REG_KUWAGUST_CIEL_HANDLING_AREA equ 0x100
    REG_HARPUIA_CHKPNT_NEW equ REG_KUWAGUST_CIEL_HANDLING+REG_KUWAGUST_CIEL_HANDLING_AREA
    REG_HARPUIA_CHKPNT_NEW_AREA equ 0x160
    REG_BURBLE_CHKPNT_NEW equ REG_HARPUIA_CHKPNT_NEW+REG_HARPUIA_CHKPNT_NEW_AREA
    REG_BURBLE_CHKPNT_NEW_AREA equ 0x100
    REG_LEVIATHAN_CHKPNT_NEW equ REG_BURBLE_CHKPNT_NEW+REG_BURBLE_CHKPNT_NEW_AREA
    REG_LEVIATHAN_CHKPNT_NEW_AREA equ 0x160
    REG_LEVIATHAN_BOSS_INTRO_HANDLING equ REG_LEVIATHAN_CHKPNT_NEW+REG_LEVIATHAN_CHKPNT_NEW_AREA
    REG_LEVIATHAN_BOSS_INTRO_HANDLING_AREA equ 0x80
    REG_FEFNIR_CHKPNT_NEW equ REG_LEVIATHAN_BOSS_INTRO_HANDLING+REG_LEVIATHAN_BOSS_INTRO_HANDLING_AREA
    REG_FEFNIR_CHKPNT_NEW_AREA equ 0x160
    REG_NA2_CHKPNT_3 equ REG_FEFNIR_CHKPNT_NEW+REG_FEFNIR_CHKPNT_NEW_AREA
    REG_NA2_CHKPNT_3_AREA equ 0x48
    REG_FEFNIRAP_CHKPNT_NEW equ REG_NA2_CHKPNT_3+REG_NA2_CHKPNT_3_AREA
    REG_FEFNIRAP_CHKPNT_NEW_AREA equ 0x100
    REG_FEFNIRAP_BOSS_INTRO_HANDLING equ REG_FEFNIRAP_CHKPNT_NEW+REG_FEFNIRAP_CHKPNT_NEW_AREA
    REG_FEFNIRAP_BOSS_INTRO_HANDLING_AREA equ 0x80
    REG_LEVIATHANAP_CHKPNT_NEW equ REG_FEFNIRAP_BOSS_INTRO_HANDLING+REG_FEFNIRAP_BOSS_INTRO_HANDLING_AREA
    REG_LEVIATHANAP_CHKPNT_NEW_AREA equ 0x100
    REG_LEVIATHANAP_BOSS_INTRO_HANDLING equ REG_LEVIATHANAP_CHKPNT_NEW+REG_LEVIATHANAP_CHKPNT_NEW_AREA
    REG_LEVIATHANAP_BOSS_INTRO_HANDLING_AREA equ 0x80
    REG_HARPUIAAP_CHKPNT_NEW equ REG_LEVIATHANAP_BOSS_INTRO_HANDLING+REG_LEVIATHANAP_BOSS_INTRO_HANDLING_AREA
    REG_HARPUIAAP_CHKPNT_NEW_AREA equ 0x100
    REG_HARPUIAAP_BOSS_INTRO_HANDLING equ REG_HARPUIAAP_CHKPNT_NEW+REG_HARPUIAAP_CHKPNT_NEW_AREA
    REG_HARPUIAAP_BOSS_INTRO_HANDLING_AREA equ 0x80
    REG_FINAL_CHKPNT_NEW equ REG_HARPUIAAP_BOSS_INTRO_HANDLING+REG_HARPUIAAP_BOSS_INTRO_HANDLING_AREA
    REG_FINAL_CHKPNT_NEW_AREA equ 0x100
    REG_CMDROOM_CHKPNT_NEW equ REG_FINAL_CHKPNT_NEW+REG_FINAL_CHKPNT_NEW_AREA
    REG_CMDROOM_CHKPNT_NEW_AREA equ 0x400
    REG_CMDROOM_CIEL_HANDLING equ REG_CMDROOM_CHKPNT_NEW+REG_CMDROOM_CHKPNT_NEW_AREA
    REG_CMDROOM_CIEL_HANDLING_AREA equ 0x180
    REG_CMDROOM_ELPIZO_HANDLING equ REG_CMDROOM_CIEL_HANDLING+REG_CMDROOM_CIEL_HANDLING_AREA
    REG_CMDROOM_ELPIZO_HANDLING_AREA equ 0x44
    REG_OVERFLOW equ 0x0836DB00