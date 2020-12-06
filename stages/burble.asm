    .gba

    ; Some restructuring in existing code to include the hook
    .org ROMADDR_BURBLE_HOOK

    beq     @@chkpnt_3
    bl      REG_BURBLE_CHKPNT_NEW           ; Hook
@@chkpnt_3:
    mov     r0,r1
    add     r0,#0x10
    ldr     r1,=#0x0832B18C
    .skip   10
    .pool

    .org REG_BURBLE_CHKPNT_NEW
    .area REG_BURBLE_CHKPNT_NEW_AREA
    
    cmp     r0,#0x4
    bne     @@chkpnt_5
    mov     r0,r1
    add     r0,#0x10
    ldr     r1,=#org(@chkpnt_4_script)
    bl      ROMADDR_SET_SCRIPT_ADDRS
    mov     r0,#0x8
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
    ldr     r0,=#ROMADDR_BURBLE_FUNC_END+1
    bx      r0
    .pool


    ; New script for checkpoint 4
@chkpnt_4_script:

    .incbin "stages/scripts/burble-script-4.bin"

@chkpnt_5_script:

    .db 0xFF, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0
    
    .endarea

    .org org(@chkpnt_4_script)+0x4
    .dw     org(burble_chkpnt_4)

    ; Modify scripts in place
    ; Stage start script
    .org 0x0832A8B6
    .db     1               ; Lose control: Set skippable
    .org 0x0832AA2E
    .db     2               ; Gain control: Set not skippable
    ; Pre-boss script
    .org 0x0832AD46
    .db     1, 4            ; Lose control: Set skippable, set checkpoint to 4
    .org 0x0832ADA6
    .db     2, 3            ; Gain control: Set not skippable, set checkpoint to 3
    ; Post-boss script
    .org 0x0832AEDE
    .db     1, 5            ; Lose control: Set skippable, set checkpoint to 5
    .org 0x0832B03E
    .db     2, 3            ; Fade out: Set not skippable, set checkpoint to 3