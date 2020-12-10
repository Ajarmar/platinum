    .gba

    ; Some restructuring in existing code to include the hook
    .org ROMADDR_LEVIATHANAP_HOOK

    beq     @@chkpnt_2
    bl      REG_LEVIATHANAP_CHKPNT_NEW            ; Hook
@@chkpnt_2:
    mov     r0,r1
    add     r0,#0x10
    ldr     r1,=#0x0832E0BC
    .skip   14
    .pool

    .org REG_LEVIATHANAP_CHKPNT_NEW
    .area REG_LEVIATHANAP_CHKPNT_NEW_AREA
    
    cmp     r0,#0x3
    bne     @@chkpnt_4
    mov     r0,r1
    add     r0,#0x10
    ldr     r1,=#org(@chkpnt_3_script)
    bl      ROMADDR_SET_SCRIPT_ADDRS
    mov     r0,#0x5
    ldr     r1,=#ADDR_STAGE_STATE
    strb    r0,[r1]
    b       @@subr_end
@@chkpnt_4:
    cmp     r0,#0x4
    bne     @@subr_end
    mov     r0,r1
    add     r0,#0x10
    ldr     r1,=#org(@chkpnt_4_script)
    bl      ROMADDR_SET_SCRIPT_ADDRS
    mov     r0,#0x5
    ldr     r1,=#ADDR_STAGE_STATE
    strb    r0,[r1]
    ldr     r1,=#ADDR_CUTSCENE_SKIPPABLE
    mov     r0,#0x4
    strb    r0,[r1]
@@subr_end:
    ldr     r0,=#ROMADDR_LEVIATHANAP_FUNC_END+1
    bx      r0
    .pool


    ; New script for checkpoint 3
@chkpnt_3_script:

    .incbin "stages/scripts/leviathanap-script-3.bin"

@chkpnt_4_script:

    .db 0xFF, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0
    
    .endarea

    .org org(@chkpnt_3_script)+0x4
    .dw     org(leviathanap_chkpnt_3)

    ; Leviathan intro animation: speed up transformation sequence
    .org REG_LEVIATHANAP_BOSS_INTRO_HANDLING
    .area REG_LEVIATHANAP_BOSS_INTRO_HANDLING_AREA
@leviathanap_intro_state_0:
    ldr     r0,=#ADDR_CHECKPOINT
    ldrb    r0,[r0]
    cmp     r0,#0x2
    bne     @@execute_normally
@@cutscene_skipped:
    ldr     r0,=#0x0805F644             ; Execute this state unconditionally instead of waiting
    mov     r15,r0
@@execute_normally:
    ldr     r0,=#0x0805F638
    mov     r15,r0
    .pool
@leviathanap_intro_state_1:
    ldr     r0,=#ADDR_CHECKPOINT
    ldrb    r0,[r0]
    cmp     r0,#0x2
    bne     @@execute_normally
@@cutscene_skipped:
    ldr     r1,=#ADDR_BOSS_POINTER
    ldr     r1,[r1]                     ; Go to boss object
    ldr     r1,[r1,#0x28]               ; Load animation thing(?)
    ldrb    r0,[r1,#0xF]
    cmp     r0,#0x2
    bge     @@execute_normally
    mov     r0,#0x2
    strb    r0,[r1,#0xF]                ; Store "boss intro animation state"(?)
    b       @leviathanap_subr_end
@@execute_normally:
    ldr     r0,=#0x0805F6B4
    mov     r15,r0
    .pool
@leviathanap_subr_end:
    ldr     r0,=#0x0805F884
    mov     r15,r0
    .pool

    .endarea

    ; Modify Leviathan state subroutines in place
    .org 0x0805F620
    .dw     org(@leviathanap_intro_state_0)
    .org 0x0805F624
    .dw     org(@leviathanap_intro_state_1)

    ; Modify scripts in place
    ; Pre-boss scripts
    .org 0x0832DC7E
    .db     1, 3            ; Lose control: Set skippable, set checkpoint to 3
    .org 0x0832DD3E
    .db     2, 2            ; Gain control: Set not skippable, set checkpoint to 2
    .org 0x0832DD76
    .db     1, 3            ; Lose control: Set skippable, set checkpoint to 3
    .org 0x0832DE1E
    .db     2, 2            ; Gain control: Set not skippable, set checkpoint to 2
    ; Post-boss script
    .org 0x0832DEFE
    .db     1, 4            ; Fade in: Set skippable, set checkpoint to 4
    .org 0x0832DF8E
    .db     2, 2            ; Fade out: Set not skippable, set checkpoint to 2