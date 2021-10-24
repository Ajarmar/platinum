    .gba

    ; Some restructuring in existing code to include the hook
    .org ROMADDR_HARPUIAAP_HOOK_3

    beq     @@chkpnt_2
    bl      REG_HARPUIAAP_CHKPNT_NEW            ; Hook
@@chkpnt_2:
    mov     r0,r1
    add     r0,#0x10
    ldr     r1,=#0x0832EB5C
    .skip   14
    .pool

    .org REG_HARPUIAAP_CHKPNT_NEW
    .area REG_HARPUIAAP_CHKPNT_NEW_AREA
    
    cmp     r0,#0x3
    bne     @@chkpnt_4
    mov     r0,r1
    add     r0,#0x10
    ldr     r1,=#org(@chkpnt_3_script)
    bl      ROMADDR_SET_SCRIPT_ADDRS
    mov     r0,#0x4
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
    mov     r0,#0x4
    ldr     r1,=#ADDR_STAGE_STATE
    strb    r0,[r1]
    ldr     r1,=#ADDR_CUTSCENE_SKIPPABLE
    mov     r0,#0x4
    strb    r0,[r1]
@@subr_end:
    ldr     r0,=#ROMADDR_HARPUIAAP_FUNC_END+1
    bx      r0
    .pool


    ; New script for checkpoint 3
@chkpnt_3_script:

    .incbin "stages/scripts/harpuiaap-script-3.bin"

@chkpnt_4_script:

    .db 0xFF, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0
    
    .endarea

    .org org(@chkpnt_3_script)+0x4
    .dw     org(harpuiaap_chkpnt_3)

    ; Hook it
    .org ROMADDR_HARPUIAAP_HOOK_1
    ldr     r0,=#org(@harpuiaap_intro_1)
    mov     r15,r0
    .pool

    ; Harpuia intro animation: speed up transformation sequence
    .org REG_HARPUIAAP_BOSS_INTRO_HANDLING
    .area REG_HARPUIAAP_BOSS_INTRO_HANDLING_AREA
@harpuiaap_intro_1:
    ldr     r1,=#ADDR_CHECKPOINT
    ldrb    r1,[r1]
    cmp     r1,#0x2
    bne     @@execute_normally
    mov     r1,#0x2
    strb    r1,[r4,#0xD]
    mov     r1,#0x0
    strb    r1,[r4,#0xE]
    ldr     r1,=#0x0B4000
    str     r1,[r4,#0x54]
    ldr     r1,=#0x01607F
    str     r1,[r4,#0x58]
    b       @harpuiaap_intro_1_subr_end
@@execute_normally:
    ldrb    r0,[r4,#0xE]
    cmp     r0,#0x3
    bgt     @harpuiaap_intro_1_subr_end
    lsl     r0,#0x2
    ldr     r1,=#org(@harpuiaap_intro_1_labels)
    add     r0,r1,r0
    ldr     r0,[r0]
    mov     r15,r0
@harpuiaap_intro_1_subr_end:
    ldr     r0,=#0x0804DA64
    mov     r15,r0
    .pool
@harpuiaap_intro_3_state_1:
    ldr     r0,=#ADDR_CHECKPOINT
    ldrb    r0,[r0]
    cmp     r0,#0x2
    bne     @@execute_normally
@@cutscene_skipped:
    mov     r0,#0x2                      ; Increment state
    strb    r0,[r7,#0xE]
    b       @harpuiaap_intro_3_subr_end
@@execute_normally:
    ldr     r0,=#0x0804DAC4
    mov     r15,r0
    .pool
@harpuiaap_intro_3_state_3:
    ldr     r0,=#ADDR_CHECKPOINT
    ldrb    r0,[r0]
    cmp     r0,#0x2
    bne     @@execute_normally
@@cutscene_skipped:
    ldr     r1,[r7,#0x28]               ; Load animation thing(?)
    ldrb    r0,[r1,#0xF]
    cmp     r0,#0x2
    bge     @@execute_normally
    mov     r0,#0x2
    strb    r0,[r1,#0xF]                ; Store "boss intro animation state"(?)
    b       @harpuiaap_intro_3_subr_end
@@execute_normally:
    ldr     r0,=#0x0804DB3E
    mov     r15,r0
    .pool
@harpuiaap_intro_3_subr_end:
    ldr     r0,=#0x0804DCB6
    mov     r15,r0
    .pool

@harpuiaap_intro_1_labels:
    .dw     0x0804DA02
    .dw     0x0804DA14
    .dw     0x0804DA34
    .dw     0x0804DA46

    .endarea

    ; Modify Harpuia state subroutines in place
    .org 0x0804DA9C
    .dw     org(@harpuiaap_intro_3_state_1)
    .org 0x0804DAA4
    .dw     org(@harpuiaap_intro_3_state_3)

    ; Modify scripts in place
    ; Pre-boss scripts
    .org 0x0832E3C6
    .db     1, 3            ; Fully enter room (1:1): Set skippable, set checkpoint to 3
    .org 0x0832E76F
    .db     0x22            ; WARNING: Set not skippable, set checkpoint to 2
    .org 0x0832E7BE
    .db     1, 3            ; Fully enter room (1:1): Set skippable, set checkpoint to 3
    .org 0x0832E85F
    .db     0x22            ; WARNING: Set not skippable, set checkpoint to 2
    ; Post-boss script
    .org 0x0832E94E
    .db     1, 4            ; Fade in: Set skippable, set checkpoint to 4
    .org 0x0832EA2E
    .db     2, 2            ; Fade out: Set not skippable, set checkpoint to 2
