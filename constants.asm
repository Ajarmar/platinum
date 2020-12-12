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
    ADDR_BOSS_POINTER equ 0x0202EC60

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

    ROMADDR_PHOENIX_HOOK equ 0x08017810

    ROMADDR_POLER_HOOK equ 0x08016C52
    ROMADDR_POLER_FUNC_END equ 0x08016E6C

    ROMADDR_HYLEG_HOOK equ 0x080167FC
    ROMADDR_HYLEG_FUNC_END equ 0x080169C8

    ROMADDR_NA1_HOOK equ 0x08019942
    ROMADDR_NA1_FUNC_END equ 0x08019C4C

    ROMADDR_KUWAGUST_HOOK equ 0x08017136
    ROMADDR_KUWAGUST_FUNC_END equ 0x08017758

    ROMADDR_HARPUIA_HOOK equ 0x08018EE2
    ROMADDR_HARPUIA_FUNC_END equ 0x080190D4

    ROMADDR_BURBLE_HOOK equ 0x0801867E
    ROMADDR_BURBLE_FUNC_END equ 0x08018974

    ROMADDR_LEVIATHAN_HOOK equ 0x08018C26
    ROMADDR_LEVIATHAN_FUNC_END equ 0x08018D56

    ROMADDR_FEFNIR_HOOK equ 0x0801944E
    ROMADDR_FEFNIR_FUNC_END equ 0x0801957E

    ROMADDR_NA2_HOOK equ 0x080196D6
    ROMADDR_NA2_FUNC_END equ 0x080197F8

    ROMADDR_FEFNIRAP_HOOK equ 0x08019D9E ; cmp r0, mov r1, ldr 0x0832DA10, pool +14
    ROMADDR_FEFNIRAP_FUNC_END equ 0x08019F50

    ROMADDR_LEVIATHANAP_HOOK equ 0x0801A0F2 ; cmp r0, mov r1, ldr 0x0832E0BC, pool +14
    ROMADDR_LEVIATHANAP_FUNC_END equ 0x0801A298

    ROMADDR_HARPUIAAP_HOOK_1 equ 0x0804D9E8
    ROMADDR_HARPUIAAP_HOOK_3 equ 0x0801A42E ; cmp r0, mov r1, ldr 0x0832EB5C, pool +14
    ROMADDR_HARPUIAAP_FUNC_END equ 0x0801A5AC

    ROMADDR_FINAL_HOOK equ 0x0801A7B2 ; cmp r0, mov r2, ldr 0x083309A4, pool +22
    ROMADDR_FINAL_FUNC_END equ 0x0801AF1C

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