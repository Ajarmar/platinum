    .gba

    ADDR_BACKGROUNDS equ 0x02000F91
    ADDR_KEY equ 0x02000D10
    ADDR_GAME_PROGRESS equ 0x0202EBB4
    ADDR_CHECKPOINT equ 0x0202EC32
    ADDR_CUTSCENE_SKIPPABLE equ 0x0202EC38
    ADDR_SCRIPT_BASE equ 0x0202EC40
    ADDR_STAGE_SCRIPT_ACTIVE equ 0x0202EC42
    ADDR_STAGE_SCRIPT_BASE equ 0x0202EC48
    ADDR_STAGE_SCRIPT equ 0x0202EC4C

    ADDR_SCRIPT_TIMER equ 0x0202ED14
    ADDR_SCRIPTED_ZERO_MOVEMENT equ 0x0202ED88
    ADDR_STAGE_STATE equ 0x0202EDAC

    ADDR_GAME_STATE equ 0x0202F8E1

    ADDR_STORED_GAME_PROGRESS equ 0x02036B44

    ADDR_ZERO_CURRENT_HEALTH equ 0x02037D94
    ADDR_ZERO_RESPAWN_HEALTH equ 0x02037E6E

    ROMADDR_INTRO_HOOK equ 0x08015F26
    ROMADDR_INTRO_FUNC_END equ 0x0801641C

    ROMADDR_PANTER_HOOK equ 0x0801835A
    ROMADDR_PANTER_FUNC_END equ 0x08018540

    ROMADDR_POLER_HOOK equ 0x08016C52
    ROMADDR_POLER_FUNC_END equ 0x08016E6C

    ROMADDR_CMDROOM_HOOK equ 0x0801B09A
    ROMADDR_CMDROOM_FUNC_END equ 0x0801B114

    ROMADDR_SET_SCRIPT_ADDRS equ 0x0801B454

    ROMADDR_CMDROOM_ELPIZO_HOOK equ 0x080C9F3E

    ROMADDR_RESPAWN_HEALTH_HOOK equ 0x08030E9E

    ROMADDR_STAGE_SCRIPTS equ 0x08325638

    VAL_KEY_A equ 0x1
    VAL_KEY_B equ 0x2
    VAL_KEY_SEL equ 0x4
    VAL_KEY_START equ 0x8
    VAL_KEY_RIGHT equ 0x10
    VAL_KEY_LEFT equ 0x20
    VAL_KEY_UP equ 0x40
    VAL_KEY_DOWN equ 0x80
    VAL_KEY_R equ 0x100
    VAL_KEY_L equ 0x200