    .gba

    ; Some restructuring in existing code to include the hook
    .org 0x08018352
    b       @set_script_addrs

    .org ROMADDR_PANTER_HOOK

    beq     @@checkpoint_stage_3
    bl      REG_PANTER_CHKPNT_4          ; Hook
@@checkpoint_stage_3:
    mov     r0,r2
    add     r0,#0x10
    ldr     r1,=#ROMADDR_STAGE_SCRIPTS
    ldr     r1,[r1,#0x18]
    ldr     r1,[r1,#0x14]
@set_script_addrs:
    bl      ROMADDR_SET_SCRIPT_ADDRS
@set_stage_state_6_and_exit:
    mov     r0,#0x6
    strb    r0,[r4]
    b       ROMADDR_PANTER_FUNC_END
    .pool

    .org 0x0801846C
    b       @set_stage_state_6_and_exit

    .org REG_PANTER_CHKPNT_4
    .area REG_PANTER_CHKPNT_4_AREA
    
    cmp     r0,#0x4
    bne     @@subr_end
    mov     r0,r2
    add     r0,#0x10
    ldr     r1,=#org(@chkpnt_4_script)
    bl      ROMADDR_SET_SCRIPT_ADDRS
    mov     r0,#0x8
    ldr     r1,=#ADDR_STAGE_STATE
    strb    r0,[r1]
@@subr_end:
    ldr     r0,=#ROMADDR_PANTER_FUNC_END+1
    bx      r0
    .pool


    ; New script for checkpoint 4
@chkpnt_4_script:

    .incbin "stages/scripts/panter-script-4.bin"
    
    .endarea

    .org org(@chkpnt_4_script)+0x4
    dw      org(panter_chkpnt_4)

    ; Modify scripts in place
    ; Stage start scripts
    .org 0x0832A17A
    .db     1               ; Lose control: Set skippable
    .org 0x0832A1E2
    .db     2               ; Gain control: Set not skippable
    ; Pre-boss scripts
    .org 0x0832A3BA
    .db     1, 4            ; Lose control: Set skippable, set checkpoint to 4
    .org 0x0832A4BA
    .db     2, 3            ; Gain control: Set not skippable, set checkpoint to 3