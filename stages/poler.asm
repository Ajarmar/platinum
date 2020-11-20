    .gba

    ; Some restructuring in existing code to include the hook
    .org 0x08016C4A
    b       @set_script_addrs

    .org ROMADDR_POLER_HOOK

    beq     @@checkpoint_stage_3
    bl      REG_POLER_CHKPNT_4          ; Hook
@@checkpoint_stage_3:
    mov     r0,r2
    add     r0,#0x10
    ldr     r1,=#ROMADDR_STAGE_SCRIPTS
    ldr     r1,[r1,#0xC]
    ldr     r1,[r1,#0x14]
@set_script_addrs:
    bl      ROMADDR_SET_SCRIPT_ADDRS
@set_stage_state_5_and_exit:
    mov     r0,#0x5
    strb    r0,[r4]
    b       ROMADDR_POLER_FUNC_END
    .pool

    .org 0x08016D44
    b       @set_stage_state_5_and_exit

    ; New subroutine for checkpoint value 4
    .org REG_POLER_CHKPNT_4
    .area REG_POLER_CHKPNT_4_AREA
    
    cmp     r0,#0x4
    bne     @@subr_end
    mov     r0,r2
    add     r0,#0x10
    ldr     r1,=#org(@chkpnt_4_script)
    bl      ROMADDR_SET_SCRIPT_ADDRS
    mov     r0,#0x7
    ldr     r1,=#ADDR_STAGE_STATE
    strb    r0,[r1]
@@subr_end:
    ldr     r0,=#ROMADDR_POLER_FUNC_END+1
    bx      r0
    .pool
    .endarea

    ; New script for checkpoint 4
@chkpnt_4_script:

    .incbin "stages/scripts/poler-script-4.bin"

    .org org(@chkpnt_4_script)+0xC
    dw      org(poler_chkpnt_4)

    ; Modify scripts in place
    ; Stage start scripts
    .org 0x08328386
    .db     1               ; Lose control: Set skippable
    .org 0x083283EE
    .db     2               ; Gain control: Set not skippable
    ; Pre-boss scripts
    .org 0x0832861E
    .db     1, 4            ; Lose control: Set skippable, set checkpoint to 4
    .org 0x083286B6
    .db     2, 3            ; Gain control: Set not skippable, set checkpoint to 3