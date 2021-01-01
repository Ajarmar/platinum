    .gba

    ; Some restructuring in existing code to include the hook
    .org ROMADDR_HARPUIA_HOOK

    beq     @@chkpnt_3
    bl      REG_HARPUIA_CHKPNT_NEW            ; Hook
@@chkpnt_3:
    mov     r0,r3
    add     r0,#0x10
    ldr     r1,=#0x0832C118
    .skip   14
    .pool

    .org REG_HARPUIA_CHKPNT_NEW
    .area REG_HARPUIA_CHKPNT_NEW_AREA
    
    cmp     r4,#0x4
    bne     @@chkpnt_5
    mov     r0,r3
    add     r0,#0x10
    ldr     r1,=#org(@chkpnt_4_script)
    bl      ROMADDR_SET_SCRIPT_ADDRS
    mov     r0,#0x7
    ldr     r1,=#ADDR_STAGE_STATE
    strb    r0,[r1]
    b       @@subr_end
@@chkpnt_5:
    cmp     r4,#0x5
    bne     @@subr_end
    mov     r0,r3
    add     r0,#0x10
    ldr     r1,=#org(@chkpnt_5_script)
    bl      ROMADDR_SET_SCRIPT_ADDRS
    mov     r0,#0x8
    ldr     r1,=#ADDR_STAGE_STATE
    strb    r0,[r1]
    ldr     r1,=#ADDR_CUTSCENE_SKIPPABLE
    mov     r0,#0x4
    strb    r0,[r1]
@@subr_end:
    ldr     r0,=#ROMADDR_HARPUIA_FUNC_END+1
    bx      r0
    .pool


    ; New script for checkpoint 4
@chkpnt_4_script:

    .incbin "stages/scripts/harpuia-script-4.bin"

@chkpnt_5_script:

    .incbin "stages/scripts/harpuia-script-5.bin"
    
    .endarea

    .org org(@chkpnt_4_script)+0x4
    .dw     org(harpuia_chkpnt_4)

    ; Modify scripts in place
    ; Stage start script
    .org 0x0832B832
    .db     1               ; Lose control: Set skippable
    .org 0x0832B89A
    .db     2               ; Gain control: Set not skippable
    ; Pre-boss script
    .org 0x0832BA4A
    .db     1, 4            ; Lose control: Set skippable, set checkpoint to 4
    .org 0x0832BBE2
    .db     2, 3            ; Gain control: Set not skippable, set checkpoint to 3
    .org 0x0832BC0A
    .db     1, 4            ; Lose control: Set skippable, set checkpoint to 4
    .org 0x0832BCAA
    .db     2, 3            ; Gain control: Set not skippable, set checkpoint to 3
    ; Post-boss script
    .org 0x0832BCF2
    .db     1, 5            ; Lose control: Set skippable, set checkpoint to 5
    .org 0x0832BD72
    .db     2, 3            ; Fade out: Set not skippable, set checkpoint to 3