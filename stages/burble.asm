    .gba

    ; Some restructuring in existing code to include the hook
    .org ROMADDR_BURBLE_HOOK

    beq     @@chkpnt_3
    bl      REG_BURBLE_CHKPNT_NEW           ; Hook
@@chkpnt_3:
    mov     r0,r1
    add     r0,#0x10
    ldr     r1,=#0x0832B18C
    .skip   10
    .pool

    .org REG_BURBLE_CHKPNT_NEW
    .area REG_BURBLE_CHKPNT_NEW_AREA
    
    cmp     r0,#0x4
    bne     @@chkpnt_5
    mov     r0,r1
    add     r0,#0x10
    ldr     r1,=#org(@chkpnt_4_script)
    bl      ROMADDR_SET_SCRIPT_ADDRS
    mov     r0,#0x8
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
    ldr     r0,=#ROMADDR_BURBLE_FUNC_END+1
    bx      r0
    .pool


    ; New script for checkpoint 4
@chkpnt_4_script:

    .incbin "stages/scripts/burble-script-4.bin"

@chkpnt_5_script:

    .db 0xFF, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0
    
    .endarea

    .org org(@chkpnt_4_script)+0x4
    .dw     org(burble_chkpnt_4)

    ; Burble boss intro: Skip state 0, force Burble position to where he should appear
    .org REG_BURBLE_BOSS_INTRO_HANDLING
    .area REG_BURBLE_BOSS_INTRO_HANDLING_AREA
@burble_state_0_0:
    push    r14
    ldr     r0,=#ADDR_STAGE_INDEX
    ldrb    r0,[r0]
    cmp     r0,#0x10
    bne     @@in_burble_stage
    ldr     r0,=#ADDR_CHECKPOINT
    ldrb    r0,[r0]
    cmp     r0,#0x3
    bne     @@execute_normally
    mov     r1,#0x1
    b       @@cutscene_skipped
@@in_burble_stage:
    mov     r1,#0x0
    ldr     r0,=#ADDR_CHECKPOINT
    ldrb    r0,[r0]
    cmp     r0,#0x3
    beq     @@cutscene_skipped
@@execute_normally:
    ldrb    r0,[r4,#0x12]
    add     r0,#0x1
    strb    r0,[r4,#0x12]
    pop     r1
    bx      r1
@@cutscene_skipped:
    ldr     r0,=#org(burble_boss_spawns)
    lsl     r1,#0x3
    add     r0,r0,r1
    ldr     r1,[r0]
    str     r1,[r4,#0x54]
    ldr     r1,[r0,#0x4]
    str     r1,[r4,#0x58]
    mov     r0,#0x30
    strb    r0,[r4,#0x12]
    pop     r1
    bx      r1
    .pool
@burble_state_0_2:
    push    r4,r14
    mov     r4,r0
    ldr     r0,=#ADDR_CHECKPOINT
    ldrb    r0,[r0]
    cmp     r0,#0x3
    beq     @@cutscene_skipped
@@execute_normally:
    mov     r0,r4
    pop     r4
    pop     r1
    ldr     r1,=#0x080518E0
    mov     r15,r1
@@cutscene_skipped:
    mov     r0,r4
    bl      0x080128D4
    mov     r0,r4
    add     r0,#0x73
    mov     r1,#0x3
    strb    r1,[r0]
    ldrb    r0,[r4,#0xE]
    add     r0,#0x1
    strb    r0,[r4,#0xE]
    mov     r0,#0x0
    strb    r0,[r4,#0xF]
    pop     r4
    pop     r1
    bx      r1
    .pool

    .endarea

    ; Modify Burble intro state 0 subroutine in place
    .org 0x080517FA
    bl      REG_BURBLE_BOSS_INTRO_HANDLING
    nop
    .org 0x0833B6F0
    .dw     org(@burble_state_0_2)+1

    ; Modify scripts in place
    ; Stage start script
    .org 0x0832A8B6
    .db     1               ; Lose control: Set skippable
    .org 0x0832AA2E
    .db     2               ; Gain control: Set not skippable
    ; Pre-boss script
    .org 0x0832ABFE
    .db     1, 4            ; Lose control: Set skippable, set checkpoint to 4
    .org 0x0832AD1E
    .db     2, 3            ; Gain control: Set not skippable, set checkpoint to 3
    .org 0x0832AD46
    .db     1, 4            ; Lose control: Set skippable, set checkpoint to 4
    .org 0x0832ADA6
    .db     2, 3            ; Gain control: Set not skippable, set checkpoint to 3
    ; Post-boss script
    .org 0x0832AEDE
    .db     1, 5            ; Lose control: Set skippable, set checkpoint to 5
    .org 0x0832B03E
    .db     2, 3            ; Fade out: Set not skippable, set checkpoint to 3