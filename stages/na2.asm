    .gba

    ; Some restructuring in existing code to include the hook
    .org ROMADDR_NA2_HOOK

    beq     @@chkpnt_2
    bl      REG_NA2_CHKPNT_3            ; Hook
@@chkpnt_2:
    mov     r0,r1
    add     r0,#0x10
    ldr     r1,=#0x0832C9EC
    .skip   10
    .pool

    .org REG_NA2_CHKPNT_3
    .area REG_NA2_CHKPNT_3_AREA
    
    cmp     r4,#0x3
    bne     @@subr_end
    mov     r0,r1
    add     r0,#0x10
    ldr     r1,=#org(@chkpnt_3_script)
    bl      ROMADDR_SET_SCRIPT_ADDRS
    mov     r0,#0x3
    ldr     r1,=#ADDR_STAGE_STATE
    strb    r0,[r1]
    ldr     r1,=#ADDR_CUTSCENE_SKIPPABLE
    mov     r0,#0x4
    strb    r0,[r1]
@@subr_end:
    ldr     r0,=#ROMADDR_NA2_FUNC_END+1
    bx      r0
    .pool


    ; New script for checkpoint 3
@chkpnt_3_script:

    .incbin "stages/scripts/na2-script-3.bin"
    
    .endarea

    ; Modify script in place
    ; Post-boss script
    .org 0x0832C846
    .db     1, 3            ; Lose control: Set skippable, set checkpoint to 3
    .org 0x0832C89E
    .db     2, 2            ; Fade out: Set not skippable, set checkpoint to 2
