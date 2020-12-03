    .gba

    ; Some restructuring in existing code to include the hook
    .org 0x08016734
    b       ROMADDR_HYLEG_HOOK

    .org ROMADDR_HYLEG_HOOK

    bl      REG_HYLEG_CHKPNT_NEW        ; Hook

    .org REG_HYLEG_CHKPNT_NEW
    .area REG_HYLEG_CHKPNT_NEW_AREA
    
    push    r4
    ldr     r4,=#ADDR_STAGE_STATE       ; Check that a checkpoint actually was loaded
    ldrb    r4,[r4]
    cmp     r4,#0x0
    bne     @@subr_end
    cmp     r0,#0x4
    bne     @@chkpnt_5
    mov     r0,r1
    add     r0,#0x10
    ldr     r1,=#org(@chkpnt_4_script)
    bl      ROMADDR_SET_SCRIPT_ADDRS
    mov     r0,#0xA
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
    pop     r4
    ldr     r0,=#ROMADDR_HYLEG_FUNC_END+1
    bx      r0
    .pool


    ; New script for checkpoint 4
@chkpnt_4_script:

    .incbin "stages/scripts/hyleg-script-4.bin"

@chkpnt_5_script:

    .db 0xFF, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0
    
    .endarea

    .org org(@chkpnt_4_script)+0xC
    dw      org(hyleg_chkpnt_4)

    ; Modify scripts in place
    ; Stage start scripts
    .org 0x08327A3E
    .db     1               ; Lose control: Set skippable
    .org 0x08327B16
    .db     2               ; Gain control: Set not skippable
    ; Pre-boss scripts
    .org 0x08327E8E
    .db     1, 4            ; Lose control: Set skippable, set checkpoint to 4
    .org 0x08327F86
    .db     2, 3            ; Gain control: Set not skippable, set checkpoint to 3
    ; Post-boss script
    .org 0x0832805E
    .db     1, 5            ; Fade in: Set skippable, set checkpoint to 5
    .org 0x0832813E
    .db     2, 3            ; Fade out: Set not skippable, set checkpoint to 3