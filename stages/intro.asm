    .gba

    .org 0x08015F1C
    b       @set_stage_state_b_and_exit

    .org ROMADDR_INTRO_HOOK
    beq     @@chkpnt_state_3
    bl      REG_INTRO_CHKPNT_NEW    ; Hook
@@chkpnt_state_3:
    mov     r0,r1
    add     r0,#0x10
    ldr     r1,=#ROMADDR_STAGE_SCRIPTS
    ldr     r1,[r1,#0x4]
    ldr     r1,[r1,#0x20]
    bl      ROMADDR_SET_SCRIPT_ADDRS
@set_stage_state_b_and_exit:
    mov     r0,#0xB
    strb    r0,[r5]
    b       ROMADDR_INTRO_FUNC_END
    .pool

    ; Don't set skippable cutscene immediately after intro boss
    .org 0x08016386
    mov     r0,#0x0

    ; Don't set non-skippable cutscene at the beginning of sleepy Zero cutscene
    .org 0x08016412
    nop
    mov     r0,r1

    ; New subroutine for checkpoint values >3
    .org REG_INTRO_CHKPNT_NEW
    .area REG_INTRO_CHKPNT_NEW_AREA
    
    cmp     r0,#0x4
    bne     @@chkpnt_5
    mov     r0,r1
    add     r0,#0x10
    ldr     r1,=#org(@chkpnt_4_script)
    bl      ROMADDR_SET_SCRIPT_ADDRS
    mov     r0,#0xD
    ldr     r1,=#ADDR_STAGE_STATE
    strb    r0,[r1]
    b       @@subr_end
@@chkpnt_5:
    cmp     r0,#0x5
    bne     @@chkpnt_6
    mov     r0,r1
    add     r0,#0x10
    ldr     r1,=#org(@chkpnt_5_script)
    bl      ROMADDR_SET_SCRIPT_ADDRS
    mov     r0,#0xE
    ldr     r1,=#ADDR_STAGE_STATE
    strb    r0,[r1]
    b       @@set_flags_and_end
@@chkpnt_6:
    cmp     r0,#0x6
    bne     @@chkpnt_7
    mov     r0,r1
    add     r0,#0x10
    ldr     r1,=#org(@chkpnt_6_script)
    bl      ROMADDR_SET_SCRIPT_ADDRS
    mov     r0,#0x10
    ldr     r1,=#ADDR_STAGE_STATE
    strb    r0,[r1]
    b       @@set_flags_and_end
@@chkpnt_7:
    cmp     r0,#0x7
    bne     @@subr_end
    mov     r0,r1
    add     r0,#0x10
    ldr     r1,=#org(@chkpnt_7_script)
    bl      ROMADDR_SET_SCRIPT_ADDRS
    mov     r0,#0x11
    ldr     r1,=#ADDR_STAGE_STATE
    strb    r0,[r1]
    ldr     r1,=#ADDR_CUTSCENE_SKIPPABLE
    mov     r0,#0xFE
    ldrb    r2,[r1]
    and     r2,r0
    strb    r2,[r1]
@@set_flags_and_end:
    ldr     r1,=#ADDR_CUTSCENE_SKIPPABLE
    mov     r0,#0x4
    ldrb    r2,[r1]
    orr     r2,r0
    strb    r2,[r1]
    ldr     r1,=#ADDR_STAGE_SCRIPT_ACTIVE
    mov     r0,#0x2
    ldrb    r2,[r1]
    orr     r2,r0
    strb    r2,[r1]
@@subr_end:
    ldr     r0,=#ROMADDR_INTRO_FUNC_END+1
    bx      r0
    .pool

    ; New script for checkpoint 4
@chkpnt_4_script:

    .incbin "stages/scripts/intro-script-4.bin"

@chkpnt_5_script:

    .incbin "stages/scripts/intro-script-5.bin"

@chkpnt_6_script:

    .incbin "stages/scripts/intro-script-6.bin"

@chkpnt_7_script:

    .incbin "stages/scripts/intro-script-7.bin"

    .endarea
    
    ; Insert checkpoint positional data
    .org org(@chkpnt_4_script)+0x4
    dw      org(intro_chkpnt_4)


    ; Modify scripts in place
    ; Pre-boss scripts
    .org 0x083277D6
    .db     1, 4            ; Lose control: Set skippable, checkpoint 4
    .org 0x0832789E
    .db     2, 3            ; Gain control: Set not skippable, checkpoint 3
    ; Harpuia cutscene
    .org 0x08326D8E
    .db     1, 5            ; Fade in: Set skippable, checkpoint 5
    ; Let's go Elpizo!!! cutscene
    .org 0x08326F16
    .db     1, 6            ; Set initial camera position?: Set skippable, checkpoint 6
    ; Sleepy Zero cutscene
    .org 0x083273D6
    .db     1, 7            ; Set initial camera position?: Set skippable, checkpoint 7
    .org 0x0832764E
    .db     2               ; Fade out: Set not skippable

    ;.org 0x083283EE
    ;.db     2               ; Fade out: Set not skippable