    .gba

    ; Some restructuring in existing code to include the hook
    .org 0x08016734
    b       ROMADDR_HYLEG_HOOK

    .org ROMADDR_HYLEG_HOOK

    bl      REG_HYLEG_CHKPNT_NEW        ; Hook

    .org REG_HYLEG_CHKPNT_NEW
    .area REG_HYLEG_CHKPNT_NEW_AREA
    
    push    r4
    ldr     r4,=#ADDR_STAGE_STATE       ; Check that a checkpoint actually was loaded
    ldrb    r4,[r4]
    cmp     r4,#0x0
    bne     @@subr_end
    cmp     r0,#0x4
    bne     @@chkpnt_5
    mov     r0,r1
    add     r0,#0x10
    ldr     r1,=#org(@chkpnt_4_script)
    bl      ROMADDR_SET_SCRIPT_ADDRS
    mov     r0,#0xA
    ldr     r1,=#ADDR_STAGE_STATE
    strb    r0,[r1]
    b       @@subr_end
@@chkpnt_5:
    cmp     r0,#0x5
    bne     @@subr_end
    mov     r0,r1
    add     r0,#0x10
    ldr     r1,=#org(@chkpnt_5_script)
    bl      ROMADDR_SET_SCRIPT_ADDRS
    mov     r0,#0xA
    ldr     r1,=#ADDR_STAGE_STATE
    strb    r0,[r1]
    ldr     r1,=#ADDR_CUTSCENE_SKIPPABLE
    mov     r0,#0x4
    strb    r0,[r1]
@@subr_end:
    pop     r4
    ldr     r0,=#ROMADDR_HYLEG_FUNC_END+1
    bx      r0
    .pool


    ; New script for checkpoint 4
@chkpnt_4_script:

    .incbin "stages/scripts/hyleg-script-4.bin"

@chkpnt_5_script:

    .db 0xFF, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0
    
    .endarea

    .org org(@chkpnt_4_script)+0x4
    dw      org(hyleg_chkpnt_4)

    ; Hyleg intro animation
    .org REG_HYLEG_BOSS_INTRO_HANDLING
    .area REG_HYLEG_BOSS_INTRO_HANDLING_AREA
@hyleg_intro_state_0:
    ldr     r0,=#ADDR_STAGE_INDEX
    ldrb    r0,[r0]
    cmp     r0,#0x10
    bne     @@in_hyleg_stage
    ldr     r0,=#ADDR_CHECKPOINT
    ldrb    r0,[r0]
    cmp     r0,#0x1
    bne     @@execute_normally
    b       @@cutscene_skipped
@@in_hyleg_stage:
    ldr     r0,=#ADDR_CHECKPOINT
    ldrb    r0,[r0]
    cmp     r0,#0x3
    bne     @@execute_normally
@@cutscene_skipped:
    mov     r0,#0x1
    strb    r0,[r4,#0x11]               ; Set flag to skip intro movement animation (thank you inti creates)
    ldrb    r0,[r4,#0x12]
    sub     r0,#0xA
    strb    r0,[r4,#0x12]
    ldr     r0,=#0x08040360             ; Execute this state unconditionally instead of waiting
    mov     r15,r0
@@execute_normally:
    ldr     r0,=#0x08040360
    mov     r15,r0
    .pool

    .endarea

    ; Modify Hyleg intro state subroutine in place
    .org 0x08040344
    .dw     org(@hyleg_intro_state_0)

    ; Modify scripts in place
    ; Stage start scripts
    .org 0x08327A3E
    .db     1               ; Lose control: Set skippable
    .org 0x08327B07
    .db     2               ; MISSION START: Set not skippable
    ; Pre-boss scripts
    .org 0x08327CEE
    .db     1, 4            ; Fully enter room (1:1): Set skippable, set checkpoint to 4
    .org 0x08327E2F
    .db     0x32            ; WARNING: Set not skippable, set checkpoint to 3
    .org 0x08327E9E
    .db     1, 4            ; Fully enter room (9:2): Set skippable, set checkpoint to 4
    .org 0x08327F47
    .db     0x32            ; WARNING: Set not skippable, set checkpoint to 3
    ; Post-boss script
    .org 0x0832805E
    .db     1, 5            ; Fade in: Set skippable, set checkpoint to 5
    .org 0x0832813E
    .db     2, 3            ; Fade out: Set not skippable, set checkpoint to 3
