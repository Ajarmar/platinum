    .gba

    ; Some restructuring in existing code to include the hook
    .org ROMADDR_FEFNIRAP_HOOK

    beq     @@chkpnt_2
    bl      REG_FEFNIRAP_CHKPNT_NEW            ; Hook
@@chkpnt_2:
    mov     r0,r1
    add     r0,#0x10
    ldr     r1,=#0x0832DA10
    .skip   14
    .pool

    .org REG_FEFNIRAP_CHKPNT_NEW
    .area REG_FEFNIRAP_CHKPNT_NEW_AREA
    
    cmp     r0,#0x3
    bne     @@chkpnt_4
    mov     r0,r1
    add     r0,#0x10
    ldr     r1,=#org(@chkpnt_3_script)
    bl      ROMADDR_SET_SCRIPT_ADDRS
    mov     r0,#0x5
    ldr     r1,=#ADDR_STAGE_STATE
    strb    r0,[r1]
    b       @@subr_end
@@chkpnt_4:
    cmp     r0,#0x4
    bne     @@subr_end
    mov     r0,r1
    add     r0,#0x10
    ldr     r1,=#org(@chkpnt_4_script)
    bl      ROMADDR_SET_SCRIPT_ADDRS
    mov     r0,#0x5
    ldr     r1,=#ADDR_STAGE_STATE
    strb    r0,[r1]
    ldr     r1,=#ADDR_CUTSCENE_SKIPPABLE
    mov     r0,#0x4
    strb    r0,[r1]
@@subr_end:
    ldr     r0,=#ROMADDR_FEFNIRAP_FUNC_END+1
    bx      r0
    .pool


    ; New script for checkpoint 3
@chkpnt_3_script:

    .incbin "stages/scripts/fefnirap-script-3.bin"

@chkpnt_4_script:

    .db 0xFF, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0
    
    .endarea

    .org org(@chkpnt_3_script)+0x4
    .dw     org(fefnirap_chkpnt_3)

    ; Fefnir intro animation: speed up transformation sequence
    .org REG_FEFNIRAP_BOSS_INTRO_HANDLING
    .area REG_FEFNIRAP_BOSS_INTRO_HANDLING_AREA
@fefnirap_intro_state_0:
    ldr     r0,=#ADDR_CHECKPOINT
    ldrb    r0,[r0]
    cmp     r0,#0x2
    bne     @@execute_normally
@@cutscene_skipped:
    ldr     r0,=#0x0805d03C             ; Execute this state unconditionally instead of waiting
    mov     r15,r0
@@execute_normally:
    ldr     r0,=#0x0805D030
    mov     r15,r0
    .pool
@fefnirap_intro_state_1:
    ldr     r0,=#ADDR_CHECKPOINT
    ldrb    r0,[r0]
    cmp     r0,#0x2
    bne     @@execute_normally
@@cutscene_skipped:
    ldr     r1,=#ADDR_BOSS_POINTER
    ldr     r1,[r1]                     ; Go to boss object
    ldr     r1,[r1,#0x28]               ; Load animation thing(?)
    ldrb    r0,[r1,#0xF]
    cmp     r0,#0x2
    bge     @@execute_normally
    mov     r0,#0x2
    strb    r0,[r1,#0xF]                ; Store "boss intro animation state"(?)
    b       @fefnirap_subr_end
@@execute_normally:
    ldr     r0,=#0x0805D0B8
    mov     r15,r0
    .pool
@fefnirap_subr_end:
    ldr     r0,=#0x0805D2D6
    mov     r15,r0
    .pool

    .endarea

    ; Modify Fefnir state subroutines in place
    .org 0x0805D018
    .dw     org(@fefnirap_intro_state_0)
    .org 0x0805D01C
    .dw     org(@fefnirap_intro_state_1)

    ; Modify scripts in place
    ; Pre-boss scripts
    .org 0x0832D5D2
    .db     1, 3            ; Fully enter room (1:1): Set skippable, set checkpoint to 3
    .org 0x0832D683
    .db     0x22            ; WARNING: Set not skippable, set checkpoint to 2
    .org 0x0832D6DA
    .db     1, 3            ; Fully enter room (1:1): Set skippable, set checkpoint to 3
    .org 0x0832D763
    .db     0x22            ; WARNING: Set not skippable, set checkpoint to 2
    ; Post-boss script
    .org 0x0832D84A
    .db     1, 4            ; Fade in: Set skippable, set checkpoint to 4
    .org 0x0832D8DA
    .db     2, 2            ; Fade out: Set not skippable, set checkpoint to 2
