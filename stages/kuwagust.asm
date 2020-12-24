    .gba

    ; Some restructuring in existing code to include the hook
    .org ROMADDR_KUWAGUST_HOOK

    beq     @@chkpnt_5
    bl      REG_KUWAGUST_CHKPNT_NEW            ; Hook
@@chkpnt_5:
    mov     r0,r3
    add     r0,#0x10
    ldr     r1,=#0x0832937C
    .skip   10
    .pool

    .org REG_KUWAGUST_CHKPNT_NEW
    .area REG_KUWAGUST_CHKPNT_NEW_AREA
    
    cmp     r0,#0x6
    bne     @@chkpnt_7
    mov     r0,r3
    add     r0,#0x10
    ldr     r1,=#org(@chkpnt_6_script)
    bl      ROMADDR_SET_SCRIPT_ADDRS
    mov     r0,#0x7
    ldr     r1,=#ADDR_STAGE_STATE
    strb    r0,[r1]
    b       @@subr_end
@@chkpnt_7:
    cmp     r0,#0x7
    bne     @@chkpnt_8
    mov     r0,r3
    add     r0,#0x10
    ldr     r1,=#org(@chkpnt_7_script)
    bl      ROMADDR_SET_SCRIPT_ADDRS
    mov     r0,#0x9
    ldr     r1,=#ADDR_STAGE_STATE
    strb    r0,[r1]
    b       @@subr_end
@@chkpnt_8:
    cmp     r0,#0x8
    bne     @@subr_end
    mov     r0,r3
    add     r0,#0x10
    ldr     r1,=#org(@chkpnt_8_script)
    bl      ROMADDR_SET_SCRIPT_ADDRS
    mov     r0,#0xD
    ldr     r1,=#ADDR_STAGE_STATE
    strb    r0,[r1]
@@subr_end:
    ldr     r0,=#ROMADDR_KUWAGUST_FUNC_END+1
    bx      r0
    .pool


    ; New script for checkpoint 6
@chkpnt_6_script:

    .incbin "stages/scripts/kuwagust-script-6.bin"

@chkpnt_7_script:

    .incbin "stages/scripts/kuwagust-script-7.bin"

@chkpnt_8_script:

    .incbin "stages/scripts/kuwagust-script-8.bin"
    
    .endarea

    .org org(@chkpnt_6_script)+0x4
    .dw     org(kuwagust_chkpnt_6)
    .org org(@chkpnt_6_script)+0x5C
    .dw     org(kuwagust_ciel_spawn)
    .org org(@chkpnt_7_script)+0x4
    .dw     org(kuwagust_chkpnt_6)
    .org org(@chkpnt_8_script)+0x4
    .dw     org(kuwagust_chkpnt_8)

    ; Ciel animations: speed up "teleport in" animation
    .org REG_KUWAGUST_CIEL_HANDLING
    .area REG_KUWAGUST_CIEL_HANDLING_AREA
@ciel_state_5:
    ldr     r0,=#ADDR_CHECKPOINT
    ldrb    r0,[r0]
    cmp     r0,#0x3
    beq     @@cutscene_skipped
    ldr     r0,=#0x080C76EA
    mov     r15,r0
@@cutscene_skipped:
    mov     r0,r6
    bl      0x080128D4
    mov     r0,r6
    bl      0x08012C04
    mov     r0,#0x0
    strb    r0,[r6,#0x12]
    ldrb    r0,[r6,#0xD]
    add     r0,#0x1
    strb    r0,[r6,#0xD]
    mov     r0,#0x1
    strb    r0,[r6,#0x12]
    b       @ciel_subr_end
    .pool
@ciel_subr_end:
    ldr     r0,=#0x080C7998
    mov     r15,r0
    .pool

    .endarea

            ; Burble boss intro: Skip state 0, force Burble position to where he should appear
    .org REG_KUWAGUST_BOSS_INTRO_HANDLING
    .area REG_KUWAGUST_BOSS_INTRO_HANDLING_AREA
    ldr     r0,=#ADDR_STAGE_INDEX
    ldrb    r0,[r0]
    cmp     r0,#0x10
    beq     @@execute_normally
    ldr     r0,=#ADDR_CHECKPOINT
    ldrb    r0,[r0]
    cmp     r0,#0x5
    beq     @@cutscene_skipped
@@execute_normally:
    ldr     r0,=#0x080466C8
    mov     r15,r0
@@cutscene_skipped:
    mov     r0,r4
    bl      0x080128D4
    mov     r0,#0xFF
    strb    r0,[r4,#0x12]
    ldrb    r0,[r4,#0xE]
    add     r0,#0x1
    strb    r0,[r4,#0xE]
    b       @kuwagust_subr_end
@kuwagust_state_2:
    ldr     r0,=#ADDR_STAGE_INDEX
    ldrb    r0,[r0]
    cmp     r0,#0x10
    beq     @@execute_normally
    ldr     r0,=#ADDR_CHECKPOINT
    ldrb    r0,[r0]
    cmp     r0,#0x5
    beq     @@cutscene_skipped
@@execute_normally:
    ldr     r0,=#0x080466F0
    mov     r15,r0
@@cutscene_skipped:
    mov     r0,r4
    bl      0x080128D4
    ldr     r0,=#org(kuwagust_boss_spawn)
    mov     r2,r4
    add     r2,#0xB4
    ldr     r1,[r0]
    str     r1,[r4,#0x54]
    str     r1,[r2]
    ldr     r1,[r0,#0x4]
    str     r1,[r4,#0x58]
    str     r1,[r2,#0x4]
    ldrb    r0,[r4,#0xE]
    add     r0,#0x1
    strb    r0,[r4,#0xE]
@kuwagust_subr_end:
    ldr     r0,=#0x08046786
    mov     r15,r0
    .pool

    .endarea

    ; Modify Burble intro state 0 subroutine in place
    .org 0x080466AC
    .dw     REG_KUWAGUST_BOSS_INTRO_HANDLING
    .org 0x080466B4
    .dw     org(@kuwagust_state_2)

    ; Modify Ciel state subroutines in place
    .org 0x080C758C
    .dw     org(@ciel_state_5)

    ; Modify scripts in place
    ; Stage start script
    .org 0x08328A7E
    .db     1               ; Lose control: Set skippable
    .org 0x08328B86
    .db     2               ; Gain control: Set not skippable
    ; Pre-miniboss script
    .org 0x08328E2E
    .db     1, 6            ; Lose control: Set skippable, set checkpoint to 6
    .org 0x08328F76
    .db     2, 3            ; Gain control: Set not skippable, set checkpoint to 3
    ; Post-miniboss script
    .org 0x08328F9E
    .db     1, 7            ; Lose control: Set skippable, set checkpoint to 7
    .org 0x0832907E
    .db     2, 4            ; Gain control: Set not skippable, set checkpoint to 4
    ; Pre-boss script
    .org 0x083291FE
    .db     1, 8            ; Lose control: Set skippable, set checkpoint to 8
    .org 0x083292B6
    .db     2, 5            ; Gain control: Set not skippable, set checkpoint to 5