    .gba

    ; Some restructuring in existing code to change where scripts are loaded from
    ; when checkpoint value >= 2 and all minibosses dead

    .org ROMADDR_PHOENIX_HOOK

    nop
    lsl     r1,r1,#0x2
    add     r1,r1,r2
    ldr     r1,[r1]

    .org    0x08017848
    .dw     REG_PHOENIX_CHKPNT_NEW

    .org REG_PHOENIX_CHKPNT_NEW
    .area REG_PHOENIX_CHKPNT_NEW_AREA
    ; Old script addresses followed by new script addresses
    .dw     0x08329DC4
    .dw     0x08329E1C
    .dw     0x08329E74
    .dw     0x08329ECC
    .dw     0x08329F24
    .dw     org(@chkpnt_7_script)
    .dw     org(@chkpnt_8_script)
    .dw     org(@chkpnt_9_script)
    .dw     org(@chkpnt_A_script)

    ; New script for checkpoint 7
@chkpnt_7_script:

    .incbin "stages/scripts/phoenix-script-7.bin"

@chkpnt_8_script:

    .incbin "stages/scripts/phoenix-script-8.bin"

@chkpnt_9_script:

    .incbin "stages/scripts/phoenix-script-9.bin"
    
@chkpnt_A_script:

    .incbin "stages/scripts/phoenix-script-A.bin"
    
    .endarea

    ; Positional data
    .org org(@chkpnt_7_script)+0x4
    dw      org(phoenix_chkpnt_7)
    .org org(@chkpnt_8_script)+0x4
    dw      org(phoenix_chkpnt_8)
    .org org(@chkpnt_9_script)+0x4
    dw      org(phoenix_chkpnt_9)
    .org org(@chkpnt_A_script)+0x4
    dw      org(phoenix_chkpnt_A)

    ; Phoenix boss intro: Skip state 3, force Phoenix position to where he should appear
    .org REG_PHOENIX_BOSS_INTRO_HANDLING
    .area REG_PHOENIX_BOSS_INTRO_HANDLING_AREA
@phoenix_state_3:
    ldr     r0,=#ADDR_STAGE_INDEX
    ldrb    r0,[r0]
    cmp     r0,#0x10
    bne     @@in_phoenix_stage
    ldr     r0,=#ADDR_CHECKPOINT
    ldrb    r0,[r0]
    cmp     r0,#0x1
    bne     @@execute_normally
    b       @@cutscene_skipped
@@in_phoenix_stage:
    ldr     r0,=#ADDR_CHECKPOINT
    ldrb    r0,[r0]
    cmp     r0,#0x7
    blt     @@cutscene_skipped
@@execute_normally:
    ldr     r0,=#0x08058120
    mov     r15,r0
@@cutscene_skipped:
    mov     r0,#0xA
    strb    r0,[r6,#0x12]
    mov     r0,#0x0
    strb    r0,[r6,#0x13]
    ldr     r0,=#ADDR_STAGE_INDEX
    ldrb    r0,[r0]
    cmp     r0,#0x10
    bne     @@in_phoenix_stage_again
    ldr     r1,=#org(final_phoenix_boss_spawn)
    ldr     r0,[r1]
    str     r0,[r6,#0x54]
    ldr     r0,[r1,#0x4]
    str     r0,[r6,#0x58]
    ldrb    r0,[r6,#0xE]
    add     r0,#0x1
    strb    r0,[r6,#0xE]
    mov     r0,r6
    bl      0x080128D4
    b       @phoenix_subr_end
@@in_phoenix_stage_again:
    ldr     r0,=#org(phoenix_boss_spawns)
    ldr     r1,=#ADDR_CHECKPOINT
    ldrb    r1,[r1]
    sub     r1,#0x2
    lsl     r1,#0x3
    add     r1,r0,r1
    ldr     r0,[r1]
    str     r0,[r6,#0x54]
    ldr     r0,[r1,#0x4]
    str     r0,[r6,#0x58]
    ldrb    r0,[r6,#0xE]
    add     r0,#0x1
    strb    r0,[r6,#0xE]
    ldr     r1,=#ADDR_STAGE_STATE
    mov     r0,#0x8
    strb    r0,[r1]
    mov     r0,r6
    bl      0x080128D4
    b       @phoenix_subr_end
    .pool
@phoenix_subr_end:
    ldr     r0,=#0x080583E8
    mov     r15,r0
    .pool

    .endarea

    ; Modify Phoenix state 3 subroutine in place
    .org 0x08057FA8
    .dw     org(@phoenix_state_3)

    ; Modify scripts in place
    ; Stage start scripts
    .org 0x083294DE
    .db     1               ; Lose control: Set skippable
    .org 0x08329546
    .db     2               ; Gain control: Set not skippable
    ; Pre-boss scripts
    ; 7
    .org 0x08329786
    .db     1, 7            ; Lose control: Set skippable, set checkpoint to 7
    .org 0x083298C6
    .db     2, 2            ; Gain control: Set not skippable, set checkpoint to 2
    ; 8
    .org 0x083298E6
    .db     1, 8            ; Lose control: Set skippable, set checkpoint to 8
    .org 0x08329A26
    .db     2, 3            ; Gain control: Set not skippable, set checkpoint to 3
    ; 9
    .org 0x08329A46
    .db     1, 9            ; Lose control: Set skippable, set checkpoint to 9
    .org 0x08329B86
    .db     2, 4            ; Gain control: Set not skippable, set checkpoint to 4
    ; A
    .org 0x08329BA6
    .db     1, 0xA          ; Lose control: Set skippable, set checkpoint to 0xA
    .org 0x08329CE6
    .db     2, 5            ; Gain control: Set not skippable, set checkpoint to 5