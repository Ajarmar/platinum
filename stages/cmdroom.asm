    .org ROMADDR_CMDROOM_HOOK
    bl      REG_CMDROOM_CHKPNT_NEW
    .pool


    .org REG_CMDROOM_CHKPNT_NEW
    .area REG_CMDROOM_CHKPNT_NEW_AREA
    push    r14
    cmp     r0,#0x9
    bne     @@chkpnt_A
    mov     r0,r4
    add     r0,#0x10
    pop     r2
    add     r2,#0x4
    bx      r2
@@chkpnt_A:
    cmp     r0,#0xA
    bne     @@chkpnt_B
    mov     r0,r4
    add     r0,#0x10
    ldr     r1,=#org(@chkpnt_A_script)
    bl      ROMADDR_SET_SCRIPT_ADDRS
    mov     r0,#0x1
    ldr     r1,=#ADDR_STAGE_STATE
    strb    r0,[r1]
    b       @@subr_end
@@chkpnt_B:
    cmp     r0,#0xB
    bne     @@subr_end
    mov     r0,r4
    add     r0,#0x10
    ldr     r1,=#org(@chkpnt_B_script)
    bl      ROMADDR_SET_SCRIPT_ADDRS
    mov     r0,#0x1
    ldr     r1,=#ADDR_STAGE_STATE
    strb    r0,[r1]
@@subr_end:
    pop     r2
    ldr     r2,=#ROMADDR_CMDROOM_FUNC_END+1
    bx      r2
    .pool

@chkpnt_A_script:
    .incbin "stages/scripts/cmdroom-script-A.bin"
@chkpnt_B_script:
    .incbin "stages/scripts/cmdroom-script-B.bin"

    .endarea
    
    ; Insert checkpoint positional data
    .org org(@chkpnt_A_script)+0x4
    dw      org(cmdroom_chkpnt_A)
    .org org(@chkpnt_B_script)+0x4
    dw      org(cmdroom_chkpnt_B)

    .org REG_CMDROOM_CIEL_HANDLING
    .area REG_CMDROOM_CIEL_HANDLING_AREA
@ciel_state_2:
    ldr     r0,=#ADDR_CHECKPOINT
    ldrb    r0,[r0]
    cmp     r0,#0x0
    beq     @@cutscene_skipped
    ldr     r0,=#0x080C4014
    mov     r15,r0
@@cutscene_skipped:
    mov     r0,r6
    bl      #0x080128D4
    ldr     r1,=#0xC405
    mov     r0,r6
    bl      #0x080127E4
    ldrb    r0,[r6,#0xD]
    add     r0,#0x1
    b       @ciel_subr_end
    .pool
@ciel_state_3:
    ldr     r0,=#ADDR_CHECKPOINT
    ldrb    r0,[r0]
    cmp     r0,#0x0
    beq     @@cutscene_skipped
    ldr     r0,=#0x080C4038
    mov     r15,r0
@@cutscene_skipped:
    mov     r0,r6
    bl      #0x080128D4
    mov     r0,r6
    add     r0,#0x70
    mov     r1,#0x1
    strb    r1,[r0]
    mov     r1,#0x1
    strb    r1,[r0,#0x2]
    mov     r1,#0x3
    strb    r1,[r0,#0x3]
    mov     r0,#0xF
    strb    r0,[r6,#0x12]
    ldrb    r0,[r6,#0xD]
    add     r0,#0x1
    b       @ciel_subr_end
    .pool
@ciel_state_4:
    ldr     r0,=#ADDR_CHECKPOINT
    ldrb    r0,[r0]
    cmp     r0,#0x0
    beq     @@cutscene_skipped
    ldr     r0,=#0x080C4054
    mov     r15,r0
@@cutscene_skipped:
    mov     r0,r6
    bl      #0x080128D4
    mov     r0,#0x0
    strb    r0,[r6,#0x12]
    ldr     r1,=#0xC402
    mov     r0,r6
    bl      #0x080127E4
    mov     r0,r6
    mov     r1,#0x35
    bl      #0x080C248C
    ldrb    r0,[r6,#0xD]
    add     r0,#0x1
    b       @ciel_subr_end
    .pool
@ciel_state_5:
    ldr     r0,=#ADDR_CHECKPOINT
    ldrb    r0,[r0]
    cmp     r0,#0x0
    beq     @@cutscene_skipped
    ldr     r0,=#0x080C4084
    mov     r15,r0
@@cutscene_skipped:
    mov     r0,r6
    bl      #0x080128D4
    mov     r2,#0x0
    ldrb    r1,[r6,0x0A]
    mov     r0,#0xEF
    and     r0,r1
    strb    r0,[r6,#0xA]
    mov     r0,r6
    add     r0,#0x4C
    strb    r2,[r0]
    mov     r2,r6
    add     r2,#0x4A
    ldrb    r1,[r2]
    mov     r0,#0x11
    neg     r0,r0
    and     r0,r1
    strb    r0,[r2]
    ldr     r1,[r6,#0x54]
    ldr     r0,=#0xFFFFBA00
    add     r1,r1,r0
    str     r1,[r6,#0x54]
    mov     r1,#0xC4
    lsl     r1,r1,#0x8
    mov     r0,r6
    bl      #0x080127E4
    ldrb    r0,[r6,#0xD]
    add     r0,#0x1
    b       @ciel_subr_end
    .pool
@ciel_state_8:
    ldr     r0,=#ADDR_CHECKPOINT
    ldrb    r0,[r0]
    cmp     r0,#0x0
    beq     @@cutscene_skipped
    ldr     r0,=#0x080C4136
    mov     r15,r0
@@cutscene_skipped:
    mov     r0,r6
    bl      #0x080128D4
    mov     r0,#0x0
    strb    r0,[r6,#0x12]
    ldr     r1,=#0xC401
    mov     r0,r6
    bl      #0x080127E4
    ldrb    r0,[r6,#0xD]
    add     r0,#0x1
    b       @ciel_subr_end
    .pool
@ciel_subr_end:
    strb    r0,[r6,#0xD]
    ldr     r0,=#0x080C4338
    mov     r15,r0
    .pool
    .endarea

    ; Modify Ciel state subroutines in place
    .org 0x080C3FA8
    .dw     org(@ciel_state_2)
    .org 0x080C3FAC
    .dw     org(@ciel_state_3)
    .org 0x080C3FB0
    .dw     org(@ciel_state_4)
    .org 0x080C3FB4
    .dw     org(@ciel_state_5)
    .org 0x080C3FC0
    .dw     org(@ciel_state_8)

    .org ROMADDR_CMDROOM_ELPIZO_HOOK
    bl      REG_CMDROOM_ELPIZO_HANDLING


    .org REG_CMDROOM_ELPIZO_HANDLING
    .area REG_CMDROOM_ELPIZO_HANDLING_AREA
    push    {r4-r6,r14}
    mov     r5,r0
    mov     r6,r1
    mov     r3,r5
    add     r3,#0x30
    ldr     r4,[r5,#0x30]
    cmp     r4,#0x0
    bne     @@subr_end
    ldrb    r0,[r2,#0xA]
    mov     r1,#0x80
    orr     r1,r0
    strb    r1,[r2,#0xA]
    str     r3,[r2,#0x18]
    str     r2,[r5,#0x30]
    mov     r0,#0x2
    strb    r0,[r3,#0x8]
    strb    r4,[r3,#0x9]
    strh    r4,[r3,#0xE]
    strh    r4,[r3,#0xC]
    strh    r4,[r3,#0xA]
    ldr     r0,=#ADDR_STAGE_SCRIPT_ACTIVE
    ldrb    r0,[r0]
    cmp     r0,#0x1
    beq     @@subr_end
    mov     r0,r5
    mov     r1,r6
    bl      0x0801B454
@@subr_end:
    pop     {r4-r6}
    pop     r0
    bx      r0
    .pool
    .endarea

    ; Modify scripts in place
    ; Ciel cutscene
    .org 0x08330D22
    .db     0x1, 0xA        ; Lose control: Set skippable, checkpoint 0xA
    .org 0x08330EB2
    .db     0x2, 0x0        ; Gain control: Set not skippable, checkpoint 0
    ; Elpizo cutscene w/ the troops
    .org 0x08330EC2
    .db     0x1, 0xB
    .org 0x08330FCA
    .db     0x2, 0x0