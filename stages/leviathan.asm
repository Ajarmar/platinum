    .gba

    ; Some restructuring in existing code to include the hook
    .org ROMADDR_LEVIATHAN_HOOK

    beq     @@chkpnt_2
    bl      REG_LEVIATHAN_CHKPNT_NEW            ; Hook
@@chkpnt_2:
    mov     r0,r3
    add     r0,#0x10
    ldr     r1,=#0x0832B6A4
    .skip   10
    .pool

    .org REG_LEVIATHAN_CHKPNT_NEW
    .area REG_LEVIATHAN_CHKPNT_NEW_AREA
    
    cmp     r0,#0x3
    bne     @@chkpnt_4
    mov     r0,r2
    add     r0,#0x10
    ldr     r1,=#org(@chkpnt_3_script)
    bl      ROMADDR_SET_SCRIPT_ADDRS
    mov     r0,#0x3
    ldr     r1,=#ADDR_STAGE_STATE
    strb    r0,[r1]
    b       @@subr_end
@@chkpnt_4:
    cmp     r0,#0x4
    bne     @@subr_end
    mov     r0,r2
    add     r0,#0x10
    ldr     r1,=#org(@chkpnt_4_script)
    bl      ROMADDR_SET_SCRIPT_ADDRS
    mov     r0,#0x4
    ldr     r1,=#ADDR_STAGE_STATE
    strb    r0,[r1]
    ldr     r1,=#ADDR_CUTSCENE_SKIPPABLE
    mov     r0,#0x4
    strb    r0,[r1]
@@subr_end:
    ldr     r0,=#ROMADDR_LEVIATHAN_FUNC_END+1
    bx      r0
    .pool


    ; New script for checkpoint 3
@chkpnt_3_script:

    .incbin "stages/scripts/leviathan-script-3.bin"

@chkpnt_4_script:

    .incbin "stages/scripts/leviathan-script-4.bin"
    
    .endarea

    .org org(@chkpnt_3_script)+0x4
    .dw     org(leviathan_chkpnt_3)

    ; Ciel animations: speed up "teleport in" animation
    .org REG_LEVIATHAN_BOSS_INTRO_HANDLING
    .area REG_LEVIATHAN_BOSS_INTRO_HANDLING_AREA
@leviathan_state_0:
    ldr     r0,=#ADDR_CHECKPOINT
    ldrb    r0,[r0]
    cmp     r0,#0x2
    beq     @@cutscene_skipped
    ldr     r0,=#0x0805DC18
    mov     r15,r0
@@cutscene_skipped:
    mov     r0,r4
    bl      0x080128D4
    ldr     r0,=#0x080FFF
    str     r0,[r4,#0x58]
    ldrb    r0,[r4,#0xF]
    add     r0,#0x1
    strb    r0,[r4,#0xF]
    b       @leviathan_subr_end
    .pool
@leviathan_state_2:
    ldr     r0,=#ADDR_CHECKPOINT
    ldrb    r0,[r0]
    cmp     r0,#0x2
    beq     @@cutscene_skipped
    ldr     r0,=#0x0805DC7C
    mov     r15,r0
@@cutscene_skipped:
    mov     r0,r4
    bl      0x080128D4
    ldr     r0,=#0x218DFF
    str     r0,[r4,#0x54]
    ldr     r0,=#0xFFFFFF88
    str     r0,[r4,#0x5C]
    ldrb    r0,[r4,#0xF]
    add     r0,#0x1
    strb    r0,[r4,#0xF]
    b       @leviathan_subr_end
    .pool
@leviathan_subr_end:
    ldr     r0,=#0x0805DD00
    mov     r15,r0
    .pool

    .endarea

    ; Modify Ciel state subroutines in place
    .org 0x0805DBFC
    .dw     org(@leviathan_state_0)
    .org 0x0805DC04
    .dw     org(@leviathan_state_2)

    ; Modify scripts in place
    ; Stage start script
    .org 0x0832B256
    .db     1               ; Lose control: Set skippable
    .org 0x0832B2BE
    .db     2               ; Gain control: Set not skippable
    ; Pre-boss script
    .org 0x0832B3A6
    .db     1, 3            ; Lose control: Set skippable, set checkpoint to 3
    .org 0x0832B45E
    .db     2, 2            ; Gain control: Set not skippable, set checkpoint to 2
    ; Post-boss script
    .org 0x0832B496
    .db     1, 4            ; Lose control: Set skippable, set checkpoint to 5
    .org 0x0832B546
    .db     2, 2            ; Fade out: Set not skippable, set checkpoint to 3

    ; Change "water fillup" speed depending on argument
    .org 0x0800EB08
    add     r0,r0,r1

    ; x: FF 8D 21 00
    ; y: FF 0F 08 00