    .gba

    ; Some restructuring in existing code to include the hook
    .org ROMADDR_NA1_HOOK

    beq     @@chkpnt_2
    bl      REG_NA1_CHKPNT_3            ; Hook
@@chkpnt_2:
    mov     r0,r1
    add     r0,#0x10
    ldr     r1,=#0x0832D318
    .skip   10
    .pool

    .org REG_NA1_CHKPNT_3
    .area REG_NA1_CHKPNT_3_AREA
    
    cmp     r0,#0x3
    bne     @@subr_end
    mov     r0,r1
    add     r0,#0x10
    ldr     r1,=#org(@chkpnt_3_script)
    bl      ROMADDR_SET_SCRIPT_ADDRS
    mov     r0,#0xB
    ldr     r1,=#ADDR_STAGE_STATE
    strb    r0,[r1]
    ldr     r1,=#ADDR_CUTSCENE_SKIPPABLE
    mov     r0,#0x4
    strb    r0,[r1]
    ldr     r0,=#ADDR_ZERO_CURRENT_HEALTH   ; Set health to full
    mov     r1,#0x10
    strb    r1,[r0]
@@subr_end:
    ldr     r0,=#ROMADDR_NA1_FUNC_END+1
    bx      r0
    .pool

    ; New script for checkpoint 3
@chkpnt_3_script:

    .db 0x01, 0x01, 0x0, 0x0, 0x10, 0x0, 0x0, 0x0
    .db 0xFF, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0

    .endarea

    ; Modify scripts in place
    ; Post-boss script
    .org 0x0832CF7A
    .db     1, 3            ; Lose control: Set skippable, set checkpoint to 3
    .org 0x0832D1D2
    .db     2, 2            ; Fade out: Set not skippable, set checkpoint to 2