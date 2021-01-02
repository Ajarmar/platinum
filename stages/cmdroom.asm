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
    bne     @@chkpnt_C
    mov     r0,r4
    add     r0,#0x10
    ldr     r1,=#org(@chkpnt_B_script)
    bl      ROMADDR_SET_SCRIPT_ADDRS
    mov     r0,#0x1
    ldr     r1,=#ADDR_STAGE_STATE
    strb    r0,[r1]
@@chkpnt_C:
    cmp     r0,#0xC
    bne     @@chkpnt_D
    mov     r0,r4
    add     r0,#0x10
    ldr     r1,=#org(@chkpnt_C_script)
    bl      ROMADDR_SET_SCRIPT_ADDRS
    mov     r0,#0xFF
    ldr     r1,=#ADDR_STAGE_STATE
    strb    r0,[r1]
@@chkpnt_D:
    cmp     r0,#0xD
    bne     @@chkpnt_E
    mov     r0,r4
    add     r0,#0x10
    ldr     r1,=#org(@chkpnt_D_script)
    bl      ROMADDR_SET_SCRIPT_ADDRS
    ldrh    r1,[r4,#0x8]
    ldr     r0,=#0xFFFE
    and     r0,r1
    strh    r0,[r4,#0x8]
    mov     r0,#0xFF
    ldr     r1,=#ADDR_STAGE_STATE
    strb    r0,[r1]
@@chkpnt_E:
    cmp     r0,#0xE
    bne     @@chkpnt_F
    mov     r0,r4
    add     r0,#0x10
    ldr     r1,=#org(@chkpnt_E_script)
    bl      ROMADDR_SET_SCRIPT_ADDRS
    mov     r0,#0xFF
    ldr     r1,=#ADDR_STAGE_STATE
    strb    r0,[r1]
@@chkpnt_F:
    cmp     r0,#0xF
    bne     @@subr_end
    mov     r0,r4
    add     r0,#0x10
    ldr     r1,=#org(@chkpnt_F_script)
    bl      ROMADDR_SET_SCRIPT_ADDRS
    ldrh    r1,[r4,#0x8]
    ldr     r0,=#0xFFFE
    and     r0,r1
    strh    r0,[r4,#0x8]
    mov     r0,#0xFF
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
@chkpnt_C_script:
    .incbin "stages/scripts/cmdroom-script-C.bin"
@chkpnt_D_script:
    .db 0xFF, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0
@chkpnt_E_script:
    .incbin "stages/scripts/cmdroom-script-E.bin" ; just spawn in zero lol
@chkpnt_F_script:
    .db 0xFF, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0

    .endarea
    
    ; Insert checkpoint positional data
    .org org(@chkpnt_A_script)+0x4
    dw      org(cmdroom_chkpnt_A)
    .org org(@chkpnt_B_script)+0x4
    dw      org(cmdroom_chkpnt_B)
    .org org(@chkpnt_C_script)+0x4
    dw      org(cmdroom_chkpnt_C)
    .org org(@chkpnt_E_script)+0x4
    dw      org(cmdroom_chkpnt_E)

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
    .org ROMADDR_CMDROOM_ELPIZO_HOOK_2
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
@elpizo_state_2_13:
    ldr     r0,=#ADDR_CHECKPOINT
    ldrb    r0,[r0]
    cmp     r0,#0x3
    beq     @@cutscene_skipped
    ldr     r0,=#0x080CA082
    mov     r15,r0
@@cutscene_skipped:
    mov     r0,r5
    bl      0x080128D4
    mov     r0,r5
    bl      0x08012C04
    mov     r0,#0x1
    strb    r0,[r5,#0x12]
    ldrb    r0,[r5,#0xD]
    add     r0,#0x1
    strb    r0,[r5,#0xD]
    b       @elpizo_subr_end
    .pool
@elpizo_state_2_15:
    ldr     r0,=#ADDR_CHECKPOINT
    ldrb    r0,[r0]
    cmp     r0,#0x3
    beq     @@cutscene_skipped
    ldr     r0,=#0x080CA0FA
    mov     r15,r0
@@cutscene_skipped:
    mov     r0,r5
    bl      0x080128D4
    mov     r0,r5
    bl      0x08012CD0
    mov     r0,#0x0
    strb    r0,[r5,#0x12]
    ldr     r0,=#0x01400060
    str     r0,[r5,#0x50]
    ldr     r0,=#0xFFFFF400
    str     r0,[r5,#0x60]
    ldrb    r0,[r5,#0xD]
    add     r0,#0x1
    strb    r0,[r5,#0xD]
    b       @elpizo_subr_end
    .pool
@elpizo_state_2_16:
    ldr     r0,=#ADDR_CHECKPOINT
    ldrb    r0,[r0]
    cmp     r0,#0x3
    beq     @@cutscene_skipped
    ldr     r0,=#0x080CA13C
    mov     r15,r0
@@cutscene_skipped:
    mov     r0,r5
    bl      0x080128D4
    mov     r0,r5
    bl      0x08012CD0
    ldr     r0,=#0x01400020
    str     r0,[r5,#0x50]
    ldr     r0,=#0xFFFFF1C0
    str     r0,[r5,#0x60]
    ldr     r0,=#0x0104C0
    str     r0,[r5,#0x58]
    ldr     r0,=#0x0202ED18
    mov     r1,r5
    add     r1,#0x54
    bl      0x08015188
    mov     r1,#0xC0
    lsl     r1,#0x6
    cmp     r0,r1
    bls     @elpizo_subr_end
    ldrb    r0,[r5,#0xA]
    mov     r1,#0xFE
    and     r1,r0
    strb    r1,[r5,#0xA]
    ldrb    r0,[r5,#0xD]
    add     r0,#0x1
    strb    r0,[r5,#0xD]
    b       @elpizo_subr_end
    .pool
@elpizo_subr_end:
    ldr     r0,=#0x080CA19A
    mov     r15,r0
    .pool
    .endarea

    ; Modify Elpizo state subroutines in place
    .org 0x080C9A60
    .dw     org(@elpizo_state_2_13)
    .org 0x080C9A68
    .dw     org(@elpizo_state_2_15)
    .org 0x080C9A6C
    .dw     org(@elpizo_state_2_16)

    .org REG_CMDROOM_CERVEAU_HANDLING
    .area REG_CMDROOM_CERVEAU_HANDLING_AREA

    ldr     r0,=#ADDR_CHECKPOINT
    ldrb    r0,[r0]
    cmp     r0,#0x3
    beq     @@cutscene_skipped
    ldr     r0,=#0x080C6FB8
    mov     r15,r0
@@cutscene_skipped:
    mov     r0,r6
    bl      0x080128D4
    ldr     r1,=#0x01A100
    str     r1,[r6,#0x54]
    mov     r1,#0x8A
    lsl     r1,#0x7
    mov     r0,r6
    bl      0x080127E4
    ldrb    r0,[r6,#0xD]
    add     r0,#0x1
    strb    r0,[r6,#0xD]
    b       @cerveau_subr_end
    .pool
@cerveau_state_5:
    ldr     r0,=#ADDR_CHECKPOINT
    ldrb    r0,[r0]
    cmp     r0,#0x3
    beq     @@cutscene_skipped
    ldr     r0,=#0x080C706C
    mov     r15,r0
@@cutscene_skipped:
    mov     r0,r6
    bl      0x080128D4
    ldr     r1,=#0x01A100
    str     r1,[r6,#0x54]
    mov     r0,#0x0
    strb    r0,[r6,#0x12]
    mov     r1,#0x8A
    lsl     r1,#0x7
    mov     r0,r6
    bl      0x080127E4
    ldrb    r0,[r6,#0xD]
    add     r0,#0x1
    strb    r0,[r6,#0xD]
    b       @cerveau_subr_end
    .pool
@cerveau_subr_end:
    ldr     r0,=#0x080C7192
    mov     r15,r0
    .pool
    
    .endarea

    ; Modify Cerveau state subroutines in place
    .org 0x080C6F38
    .dw     REG_CMDROOM_CERVEAU_HANDLING
    .org 0x080C6F48
    .dw     org(@cerveau_state_5)

    ; Modify scripts in place
    ; Ciel cutscene
    .org 0x08330D22
    .db     0x1, 0xA        ; Lose control: Set skippable, checkpoint 0xA
    .org 0x08330EB2
    .db     0x2, 0x0        ; Gain control: Set not skippable, checkpoint 0
    ; Elpizo cutscene w/ the troops
    .org 0x08330EC2
    .db     0x1, 0xB        ; Lose control: Set skippable, checkpoint 0xB
    .org 0x08330FCA
    .db     0x2, 0x0        ; Music change: Set not skippable, checkpoint 0
    ; Elpizo goes to Neo Arcadia against his better judgment
    .org 0x08331302
    .db     0x1, 0xC        ; Lose control: Set skippable, checkpoint 0xC
    .org 0x083317AA
    .db     0x2, 0x3        ; Fade out: Set not skippable, checkpoint 3
    ; Elpizo is brought back to the Resistance Base after getting demolished in Neo Arcadia
    .org 0x08331812
    .db     0x1, 0xD        ; Lose control: Set skippable, checkpoint 0xD
    .org 0x083319E2
    .db     0x2, 0x5        ; Fade out: Set not skippable, checkpoint 5
    ; Elpizo laments his shortcomings
    .org 0x08331A3A
    .db     0x1, 0xE        ; Lose control: Set skippable, checkpoint 0xE
    .org 0x08331B6A
    .db     0x2, 0x6        ; Gain control: Set not skippable, checkpoint 6
    ; Elpizo reaches the depths of Neo Arcadia and engages in a minor scuffle with X
    .org 0x08331DB2
    .db     0x1, 0xF        ; Music fades out: Set skippable, checkpoint 0xF
    .org 0x0833211A
    .db     0x2, 0x7        ; Fade out: Set not skippable, checkpoint 7