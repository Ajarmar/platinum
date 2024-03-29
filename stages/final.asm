    .gba

    ; Some restructuring in existing code to include the hook
    .org ROMADDR_FINAL_HOOK

    beq     @@chkpnt_2
    bl      REG_FINAL_CHKPNT_NEW            ; Hook
@@chkpnt_2:
    mov     r0,r2
    add     r0,#0x10
    ldr     r1,=#0x083309A4
    .skip   22
    .pool

    .org REG_FINAL_CHKPNT_NEW
    .area REG_FINAL_CHKPNT_NEW_AREA
    
    cmp     r0,#0x6
    bne     @@chkpnt_7
    mov     r0,r2
    add     r0,#0x10
    ldr     r1,=#org(@chkpnt_6_script)
    bl      ROMADDR_SET_SCRIPT_ADDRS
    mov     r0,#0x3
    ldr     r1,=#ADDR_STAGE_STATE
    strb    r0,[r1]
    mov     r0,#0x1
    strb    r0,[r1,#0x1]
    b       @@subr_end
@@chkpnt_7:
    cmp     r0,#0x7
    bne     @@chkpnt_8
    mov     r0,r2
    add     r0,#0x10
    ldr     r1,=#org(@chkpnt_7_script)
    bl      ROMADDR_SET_SCRIPT_ADDRS
    mov     r0,#0x3
    ldr     r1,=#ADDR_STAGE_STATE
    strb    r0,[r1]
    mov     r0,#0x2
    strb    r0,[r1,#0x1]
    b       @@subr_end
@@chkpnt_8:
    cmp     r0,#0x8
    bne     @@chkpnt_9
    mov     r0,r2
    add     r0,#0x10
    ldr     r1,=#org(@chkpnt_8_script)
    bl      ROMADDR_SET_SCRIPT_ADDRS
    mov     r0,#0x3
    ldr     r1,=#ADDR_STAGE_STATE
    strb    r0,[r1]
    mov     r0,#0x3
    strb    r0,[r1,#0x1]
    b       @@subr_end
@@chkpnt_9:
    cmp     r0,#0x9
    bne     @@chkpnt_A
    mov     r0,r2
    add     r0,#0x10
    ldr     r1,=#org(@chkpnt_9_script)
    bl      ROMADDR_SET_SCRIPT_ADDRS
    mov     r0,#0x8
    ldr     r1,=#ADDR_STAGE_STATE
    strb    r0,[r1]
    mov     r0,#0x4
    strb    r0,[r1,#0x1]
    b       @@subr_end
@@chkpnt_A:
    cmp     r0,#0xA
    bne     @@chkpnt_B
    mov     r0,r2
    add     r0,#0x10
    ldr     r1,=#org(@chkpnt_A_script)
    bl      ROMADDR_SET_SCRIPT_ADDRS
    mov     r0,#0x8
    ldr     r1,=#ADDR_STAGE_STATE
    strb    r0,[r1]
    mov     r0,#0x5
    strb    r0,[r1,#0x1]
    b       @@subr_end
@@chkpnt_B:
    cmp     r0,#0xB
    bne     @@chkpnt_C
    mov     r0,r2
    add     r0,#0x10
    ldr     r1,=#org(@chkpnt_B_script)
    bl      ROMADDR_SET_SCRIPT_ADDRS
    mov     r0,#0x8
    ldr     r1,=#ADDR_STAGE_STATE
    strb    r0,[r1]
    mov     r0,#0x6
    strb    r0,[r1,#0x1]
    b       @@subr_end
@@chkpnt_C:
    cmp     r0,#0xC
    bne     @@chkpnt_D
    mov     r0,r2
    add     r0,#0x10
    ldr     r1,=#org(@chkpnt_C_script)
    bl      ROMADDR_SET_SCRIPT_ADDRS
    ldr     r0,=#0x02001000
    ldr     r1,=#0x02D01C
    add     r0,r0,r1
    mov     r1,#0x2
    strb    r1,[r0]
    mov     r0,#0xE
    ldr     r1,=#ADDR_STAGE_STATE
    strb    r0,[r1]
    mov     r0,#0x0
    strb    r0,[r1,#0x1]
    b       @@subr_end
@@chkpnt_D:
    cmp     r0,#0xD
    bne     @@chkpnt_E
    mov     r0,r2
    add     r0,#0x10
    ldr     r1,=#org(@chkpnt_D_script)
    bl      ROMADDR_SET_SCRIPT_ADDRS
    ldr     r0,=#0x02001000
    ldr     r1,=#0x02D01C
    add     r0,r0,r1
    mov     r1,#0x2
    strb    r1,[r0]
    mov     r0,#0xF
    ldr     r1,=#ADDR_STAGE_STATE
    strb    r0,[r1]
    b       @@subr_end
@@chkpnt_E:
    cmp     r0,#0xE
    bne     @@chkpnt_F
    mov     r0,r2
    add     r0,#0x10
    ldr     r1,=#org(@chkpnt_E_script)
    bl      ROMADDR_SET_SCRIPT_ADDRS
    mov     r0,#0x11
    ldr     r1,=#ADDR_STAGE_STATE
    strb    r0,[r1]
    mov     r0,#0xA5
    ldr     r1,=#ADDR_CUTSCENE_SKIPPABLE
    strb    r0,[r1]
    b       @@subr_end
@@chkpnt_F:
    cmp     r0,#0xF
    bne     @@subr_end
    mov     r0,r2
    add     r0,#0x10
    ldr     r1,=#org(@chkpnt_F_script)
    bl      ROMADDR_SET_SCRIPT_ADDRS
    mov     r0,#0x12
    ldr     r1,=#ADDR_STAGE_STATE
    strb    r0,[r1]
    mov     r0,#0xA5
    ldr     r1,=#ADDR_CUTSCENE_SKIPPABLE
    strb    r0,[r1]
    b       @@subr_end
@@subr_end:
    ldr     r0,=#ROMADDR_FINAL_FUNC_END+1
    bx      r0
    .pool


    ; New scripts for checkpoints 6, 7, 8
@chkpnt_set_1_scripts:
@chkpnt_6_script:
    .incbin "stages/scripts/final-script-6.bin"
@chkpnt_7_script:
    .incbin "stages/scripts/final-script-7.bin"
@chkpnt_8_script:
    .incbin "stages/scripts/final-script-8.bin"

    ; New scripts for checkpoints 9, 0xA, 0xB
@chkpnt_set_2_scripts:
@chkpnt_9_script:
    .incbin "stages/scripts/final-script-9.bin"
@chkpnt_A_script:
    .incbin "stages/scripts/final-script-A.bin"
@chkpnt_B_script:
    .incbin "stages/scripts/final-script-B.bin"

    ; Elpizo 1 & 2
@chkpnt_C_script:
    .incbin "stages/scripts/final-script-C.bin"
@chkpnt_D_script:
    .incbin "stages/scripts/final-script-D.bin"

    ; Ending & credits
@chkpnt_E_script:
    .db 0xFF, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0
@chkpnt_F_script:
    .db 0xFF, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0
    
    .endarea

    .org org(@chkpnt_6_script)+0x4
    .dw     org(final_chkpnt_6)
    .org org(@chkpnt_7_script)+0x4
    .dw     org(final_chkpnt_7)
    .org org(@chkpnt_8_script)+0x4
    .dw     org(final_chkpnt_8)
    .org org(@chkpnt_9_script)+0x4
    .dw     org(final_chkpnt_9)
    .org org(@chkpnt_A_script)+0x4
    .dw     org(final_chkpnt_A)
    .org org(@chkpnt_B_script)+0x4
    .dw     org(final_chkpnt_B)
    .org org(@chkpnt_C_script)+0x4
    .dw     org(final_chkpnt_C)
    .org org(@chkpnt_D_script)+0x4
    .dw     org(final_chkpnt_D)

    .org org(@chkpnt_6_script)+0xC
    .dw     org(final_camera_1)
    .org org(@chkpnt_7_script)+0xC
    .dw     org(final_camera_1)
    .org org(@chkpnt_8_script)+0xC
    .dw     org(final_camera_1)
    .org org(@chkpnt_9_script)+0xC
    .dw     org(final_camera_2)
    .org org(@chkpnt_A_script)+0xC
    .dw     org(final_camera_2)
    .org org(@chkpnt_B_script)+0xC
    .dw     org(final_camera_2)

    ; Modify scripts in place
    ; Pre-boss scripts
    ; Hyleg
    .org 0x0832EF6E
    .db     1, 6            ; Music change: Set skippable, set checkpoint to 6
    .org 0x0832EFAF
    .db     0x12            ; WARNING: Set not skippable, set checkpoint to 1
    ; Poler
    .org 0x0832F036
    .db     1, 7            ; Music change: Set skippable, set checkpoint to 7
    .org 0x0832F077
    .db     0x12            ; WARNING: Set not skippable, set checkpoint to 1
    ; Phoenix
    .org 0x0832F106
    .db     1, 8            ; Music change: Set skippable, set checkpoint to 8
    .org 0x0832F17F
    .db     0x12            ; WARNING: Set not skippable, set checkpoint to 1
    ; Panter
    .org 0x0832F596
    .db     1, 9            ; Music change: Set skippable, set checkpoint to 9
    .org 0x0832F5D7
    .db     0x32            ; WARNING: Set not skippable, set checkpoint to 3
    ; BEETLE BROS
    .org 0x0832F676
    .db     1, 0xA          ; Music change: Set skippable, set checkpoint to 0xA
    .org 0x0832F6C7
    .db     0x32            ; WARNING: Set not skippable, set checkpoint to 3
    ; Burble
    .org 0x0832F75E
    .db     1, 0xB          ; Music change: Set skippable, set checkpoint to 0xB
    .org 0x0832F79F
    .db     0x32            ; WARNING: Set not skippable, set checkpoint to 3
    ; TK-31
    .org 0x0832FB8E
    .db     1, 0xC          ; Fade out music: Set skippable, set checkpoint to 0xC
    .org 0x0833015E
    .db     0x10            ; Fix garbled cutscene art
    .org 0x0833020F
    .db     0x52            ; WARNING: Set not skippable, set checkpoint to 5
    .org 0x0833024E
    .db     1, 0xC          ; Lose control: Set skippable, set checkpoint to 0xC
    .org 0x083302BF
    .db     0x52            ; WARNING: Set not skippable, set checkpoint to 5
    ; Elpizo phase 2
    .org 0x08330316
    .db     1, 0xD          ; Lose control: Set skippable, set checkpoint to 0xD
    .org 0x0833041F
    .db     0x52            ; WARNING: Set not skippable, set checkpoint to 5
    ; After Elpizo
    .org 0x08330826
    .db     0x10            ; Fix garbled cutscene art
