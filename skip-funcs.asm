    ; Change to existing code.
    ; Normally checks if you're in the intro stage, now continues unconditionally
    ; to check for start press
    .org 0x08014AAC
    nop
    nop
    
    ; Change to existing code.
    ; Normally checks a value that is set if you have a save file,
    ; to see if you should be allowed to skip the intro cutscene.
    ; Now branches to a new subroutine instead and skips this check.
    .org 0x08014E96
    .area 14
    bl      REG_SKIP_FUNCS
    ldr     r3,[r2,#0x20]
    .skip 2
    cmp     r0,#0x0
    beq     #0x08014EDE
    nop
    .endarea

    ; End of script 9: branch to new subroutine to check 2nd/3rd arg
    .org 0x0801C254
    bl      @script_9_extra_args
    pop     r1
    bx      r1

    ; End of script 14: branch to new subroutine to fix BG register
    ; for "WARNING" animation
    ; Also check extra args like script 9
    .org 0x0801C74E
    bl      @script_14_BG_and_extra_args
    bx      r1

    .org 0x0801CABC
    bl      @script_18_extra_args
    bx      r1

    .org ROMADDR_RESPAWN_HEALTH_HOOK
    bl      @set_respawn_health

    .org ROMADDR_RNG_HOOK
    ldr     r1,=#org(@retain_rng_on_skip)+1
    .skip   6
    bx      r1
    .skip   0xEC
    .pool

    .org ROMADDR_CHARGE_TIMER_HOOK
    bl      @retain_weapon_charge_on_skip
    
    .org ROMADDR_CHARGE_TIMER_HOOK_2 ; This is the reality we live in
    nop
    .skip 4
    nop
 
    .org REG_SKIP_FUNCS
    .area REG_SKIP_FUNCS_AREA

    push    {r4-r7,r14}
    mov     r7,#0x0
    cmp     r0,#0x1
    bne     @@not_intro
    ldr     r2,=#ADDR_CHECKPOINT
    ldrb    r3,[r2]
    cmp     r3,#0x1
    bgt     @@intro_but_late_chkpnt
    mov     r0,#0x1
    b       @@subr_end
@@intro_but_late_chkpnt:
    cmp     r3,#0x5
    bne     @@not_intro
    mov     r7,#0x1
@@not_intro:
    ldr     r5,=#ADDR_CUTSCENE_SKIPPABLE
    ldrb    r6,[r5]
    mov     r2,#0x80
    and     r2,r6
    cmp     r2,#0x0
    beq     @@not_intro_subr_end
    mov     r2,#0x20
    and     r2,r6
    cmp     r2,#0x0
    bne     @@not_intro_subr_end
    ldr     r2,=#ADDR_FREE_AREA
    ldr     r1,=#OFFSET_NEW_PAUSE_PREVENTION
    add     r2,r2,r1
    ldrb    r1,[r2]
    cmp     r1,#0x0
    bne     @@not_intro_subr_end
    ldr     r0,=#ADDR_KEY       ; Check for start button press {
    ldrh    r1,[r0,#0x4]
    mov     r4,#VAL_KEY_START
    and     r1,r4
    cmp     r1,#0x0             ; }
    beq     @@not_intro_subr_end
    mov     r2,#0x7F
    and     r6,r2
    strb    r6,[r5]
    mov     r4,#0x3
    ldr     r5,=#ADDR_GAME_STATE
    strb    r4,[r5]
    cmp     r7,#0x1
    bne     @@skip_pause_prevention
    ldr     r2,=#ADDR_FREE_AREA
    ldr     r1,=#OFFSET_NEW_PAUSE_PREVENTION
    add     r2,r2,r1
    mov     r1,#0x1
    strb    r1,[r2]
@@skip_pause_prevention:
    ldr     r0,=#ADDR_ZERO_CURRENT_HEALTH   ; Store current health as respawn health
    mov     r1,#0xFF
    ldrb    r2,[r0]
    sub     r2,r1,r2
    strb    r2,[r0]
    ldr     r0,=#ADDR_GAME_PROGRESS
    ldr     r1,=#ADDR_STORED_GAME_PROGRESS
    ldmia   r0!,{r2-r7}
    stmia   r1!,{r2-r7}
    ldmia   r0!,{r2-r7}
    stmia   r1!,{r2-r7}
    ldmia   r0!,{r2-r3}
    stmia   r1!,{r2-r3}
    ldr     r0,=#ADDR_ZERO_BASE
    ldr     r1,=#ADDR_STORED_ZERO_DATA
    bl      ROMADDR_STORE_ZERO_DATA
    ldr     r0,=#ADDR_STAGE_SCRIPT                      ; Signify that a cutscene has been skipped for RNG purposes
    ldr     r1,[r0]
    add     r1,#0x1
    str     r1,[r0]
    ldr     r0,=#ADDR_ZERO_BASE
    ldr     r1,=#0x188
    add     r0,r0,r1
    ldr     r2,=#ADDR_FREE_AREA
    ldr     r1,=#OFFSET_NEW_INPUT_BUFFER
    add     r2,r2,r1
    ldrh    r1,[r0]
    strh    r1,[r2,#0x2]
    mov     r4,#0x0
    mov     r0,r1
    mov     r3,#0xFF
    and     r0,r3
    cmp     r0,#0x0
    beq     @@check_secondary
    mov     r3,#0x10
    orr     r4,r3
@@check_secondary:
    lsr     r0,r1,#0x8
    mov     r3,#0xFF
    and     r0,r3
    cmp     r0,#0x0
    beq     @@not_intro_subr_end
    mov     r3,#0x80
    orr     r4,r3
    strb    r4,[r2]
@@not_intro_subr_end:
    mov     r0,#0x0
@@subr_end:
    mov     r2,r1
    pop     {r4-r7}
    pop     r3
    bx      r3
    .pool
@script_9_extra_args:
    push    r14
    ldr     r0,[r4,#0xC]
    ldrb    r0,[r0,#0x2]
    mov     r1,#0xF
    and     r0,r1
    cmp     r0,#0x1
    bne     @@check_2
    ldr     r0,=#ADDR_CUTSCENE_SKIPPABLE
    ldrb    r1,[r0]
    mov     r2,#0x80
    orr     r1,r2
    strb    r1,[r0]
    b       @@elpizo_floor_flag
@@check_2:
    cmp     r0,#0x2
    bne     @@elpizo_floor_flag
    ldr     r0,=#ADDR_CUTSCENE_SKIPPABLE
    ldrb    r1,[r0]
    mov     r2,#0x7F
    and     r1,r2
    strb    r1,[r0]
@@elpizo_floor_flag:
    ldr     r0,[r4,#0xC]
    ldrb    r0,[r0,#0x2]
    lsr     r0,#0x4
    cmp     r0,#0x0
    beq     @@arg_3
    ldr     r0,=#0x020301FC
    ldr     r0,[r0]
    ldr     r1,=#0x030201
    str     r1,[r0,#0xC]
    mov     r1,#0x1
    strb    r1,[r0,#0x12]
    ldr     r1,=#ADDR_ZERO_BASE
    add     r0,#0xB4
    str     r1,[r0]
@@arg_3:
    ldr     r0,[r4,#0xC]
    ldrb    r0,[r0,#0x3]
    cmp     r0,#0x0
    beq     @@subr_end
    ldr     r1,=#ADDR_CHECKPOINT
    cmp     r0,#0xFF
    bne     @@store_the_value
    mov     r0,#0x0
@@store_the_value:
    strb    r0,[r1]
@@subr_end:
    mov     r0,#0x0
    pop     r0
    bx      r0
    .pool
@script_14_BG_and_extra_args:
    push    r4,r5
    ldrb    r1,[r2,#0x2]
    lsr     r1,#0x4
    cmp     r1,#0x1
    bne     @@make_BG0_visible
    ldr     r4,=#ADDR_BACKGROUNDS
    ldrb    r1,[r4]
    mov     r5,0xFE
    and     r1,r5
    strb    r1,[r4]
    b       @@after_BG_thing
@@make_BG0_visible:
    ldr     r4,=#ADDR_BACKGROUNDS
    ldrb    r1,[r4]
    mov     r5,0x1
    orr     r1,r5
    strb    r1,[r4]
@@after_BG_thing:
    ldrb    r1,[r2,#0x2]
    mov     r3,#0xF
    and     r1,r3
    cmp     r1,#0x1
    bne     @@check_2
    ldr     r1,=#ADDR_CUTSCENE_SKIPPABLE
    ldrb    r3,[r1]
    mov     r4,#0x80
    orr     r3,r4
    strb    r3,[r1]
    b       @@arg_3
@@check_2:
    cmp     r1,#0x2
    bne     @@arg_3
    ldr     r1,=#ADDR_CUTSCENE_SKIPPABLE
    ldrb    r3,[r1]
    mov     r4,#0x7F
    and     r3,r4
    strb    r3,[r1]
@@arg_3:
    ldrb    r1,[r2,#0x3]
    cmp     r1,#0x0
    beq     @@subr_end
    ldr     r3,=#ADDR_CHECKPOINT
    cmp     r1,#0xFF
    bne     @@store_the_value
    mov     r1,#0x0
@@store_the_value:
    strb    r1,[r3]
@@subr_end:
    pop     r4,r5
    pop     r1
    bx      r14
    .pool
@script_18_extra_args:
    ldr     r4,=#ADDR_SCRIPT_BASE
    ldr     r5,[r4,#0xC]
    cmp     r0,#0x1
    bne     @@addr_is_correct
    add     r5,#0x8
@@addr_is_correct:
    ldrb    r1,[r5,#0x2]
    cmp     r1,#0x1
    bne     @@check_2
    ldr     r1,=#ADDR_CUTSCENE_SKIPPABLE
    ldrb    r3,[r1]
    mov     r4,#0x80
    orr     r3,r4
    strb    r3,[r1]
    ldr     r2,=#ADDR_FREE_AREA
    ldr     r1,=#OFFSET_NEW_PAUSE_PREVENTION
    add     r2,r2,r1
    mov     r1,#0x0
    strb    r1,[r2]
    b       @@arg_3
@@check_2:
    cmp     r1,#0x2
    bne     @@arg_3
    ldr     r1,=#ADDR_CUTSCENE_SKIPPABLE
    ldrb    r3,[r1]
    mov     r4,#0x7F
    and     r3,r4
    strb    r3,[r1]
@@arg_3:
    ldrb    r1,[r5,#0x3]
    cmp     r1,#0x0
    beq     @@subr_end
    ldr     r3,=#ADDR_CHECKPOINT
    cmp     r1,#0xFF
    bne     @@store_the_value
    mov     r1,#0x0
@@store_the_value:
    strb    r1,[r3]
@@subr_end:
    pop     r4,r5
    pop     r1
    bx      r14
    .pool
@set_respawn_health:
    ldr     r1,=#ADDR_ZERO_CURRENT_HEALTH
    ldrb    r2,[r1]
    cmp     r2,#0x80
    blt     @@subr_end
    mov     r0,#0xFF
    sub     r0,r0,r2
@@subr_end:
    mov     r2,#0xBF
    lsl     r2,r2,#0x1
    bx      r14
    .pool
@retain_rng_on_skip:
    ldr     r2,=#ADDR_STAGE_SCRIPT
    ldrb    r2,[r2]
    mov     r1,#0x1
    and     r2,r1
    cmp     r2,#0x0
    beq     @@execute_normally
    ldr     r0,=#ADDR_STAGE_SCRIPT
    ldr     r1,[r0]
    sub     r1,#0x1
    str     r1,[r0]
    b       @@subr_end
@@execute_normally:
    ldr     r1,=#ADDR_RNG
    str     r0,[r1]
@@subr_end:
    ldr     r0,=#ROMADDR_RNG_HOOK_RETURN+1
    bx      r0
    .pool
@retain_weapon_charge_on_skip:
    push    r14
    ldr     r1,=#ADDR_STAGE_SCRIPT
    ldr     r1,[r1]
    ldrb    r1,[r1,#0x2]
    cmp     r1,#0x0
    bne     @@load_stored_charge
    bl      ROMADDR_RESET_CHARGE_TIMER_FUNC
    b       @@subr_end
@@load_stored_charge:
    ldr     r0,=#ADDR_ZERO_BASE
    ldr     r1,=#0x188
    add     r0,r0,r1
    ldr     r2,=#ADDR_FREE_AREA
    ldr     r1,=#OFFSET_NEW_INPUT_BUFFER
    add     r2,r2,r1
    ldrh    r1,[r2,#0x2]
    strh    r1,[r0]
    ldrb    r1,[r2]
    cmp     r1,#0x0
    beq     @@subr_end
    add     r0,#0x10
    strb    r1,[r0]
@@subr_end:
    pop     r0
    bx      r0
    .pool
    .endarea