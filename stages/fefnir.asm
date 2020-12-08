    .gba

    ; Some restructuring in existing code to include the hook
    .org ROMADDR_FEFNIR_HOOK

    beq     @@chkpnt_3
    bl      REG_FEFNIR_CHKPNT_NEW            ; Hook
@@chkpnt_3:
    mov     r0,r2
    add     r0,#0x10
    ldr     r1,=#0x0832C604
    .skip   10
    .pool

    .org REG_FEFNIR_CHKPNT_NEW
    .area REG_FEFNIR_CHKPNT_NEW_AREA
    
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
    ldr     r0,=#ROMADDR_FEFNIR_FUNC_END+1
    bx      r0
    .pool


    ; New script for checkpoint 3
@chkpnt_3_script:

    .incbin "stages/scripts/fefnir-script-3.bin"

@chkpnt_4_script:

    .incbin "stages/scripts/fefnir-script-4.bin"
    
    .endarea

    .org org(@chkpnt_3_script)+0x4
    .dw     org(fefnir_chkpnt_3)

    ; Modify scripts in place
    ; Stage start script
    .org 0x0832C1F6
    .db     1               ; Lose control: Set skippable
    .org 0x0832C25E
    .db     2               ; Gain control: Set not skippable
    ; Pre-boss script
    .org 0x0832C33E
    .db     1, 3            ; Lose control: Set skippable, set checkpoint to 3
    .org 0x0832C3C6
    .db     2, 2            ; Gain control: Set not skippable, set checkpoint to 2
    ; Post-boss script
    .org 0x0832C3FE
    .db     1, 4            ; Lose control: Set skippable, set checkpoint to 4
    .org 0x0832C4AE
    .db     2, 2            ; Fade out: Set not skippable, set checkpoint to 2