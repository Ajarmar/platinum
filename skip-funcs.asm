    ; Change to existing code.
    ; Normally checks if you're in the intro stage, now checks
    ; if you are in any stage that isn't commander room.
    .org 0x08014AAA
    cmp     r0,#0x11
    bgt     #0x08014AB4
    nop
    
    ; Change to existing code.
    ; Normally checks a value that is set if you have a save file,
    ; to see if you should be allowed to skip the intro cutscene.
    ; Now branches to a new subroutine instead and skips this check.
    .org 0x08014E96
    .area 14
    ldr     r2,=#REG_SKIP_FUNCS+0x1
    ldr     r5,=#ADDR_GAME_STATE-0x1
    bx      r2
    .pool
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
 
    .org REG_SKIP_FUNCS
    .area REG_SKIP_FUNCS_AREA

    cmp     r0,#0x1
    bne     @not_intro
    ldr     r2,=#ADDR_CHECKPOINT
    ldrb    r3,[r2]
    cmp     r3,#0x1
    bgt     @not_intro
    mov     r2,r1
    ldr     r3,[r2,#0x20]
    ldr     r0,=#0x08014EA5
    bx      r0
@not_intro:
    push    {r2-r7}
    ldr     r5,=#ADDR_CUTSCENE_SKIPPABLE
    ldrb    r6,[r5]
    mov     r2,#0x80
    and     r2,r6
    cmp     r2,#0x0
    beq     @@subr_end
    ldr     r0,=#ADDR_KEY       ; Check for start button press {
    ldrh    r1,[r0,#0x4]
    mov     r4,#VAL_KEY_START
    and     r1,r4
    cmp     r1,#0x0             ; }
    beq     @@subr_end
    mov     r2,#0x7F
    and     r6,r2
    strb    r6,[r5]
    mov     r4,#0x3
    ldr     r5,=#ADDR_GAME_STATE
    strb    r4,[r5]
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
    ldr     r1,=#0x02036C10     ; "Saved gameplay settings" section to write to
    ldr     r0,=#0x02037EDC     ; Read from control settings
    ldmia   r0!,{r2-r7}         ; Load 24 bytes
    stmia   r1!,{r2-r7}         ; Store 24 bytes
    ldmia   r0!,{r2-r7}         ; Load 24 bytes
    stmia   r1!,{r2-r7}         ; Store 24 bytes
    ldmia   r0!,{r2-r7}         ; Load 24 bytes
    stmia   r1!,{r2-r7}         ; Store 24 bytes
    ldmia   r0!,{r2-r3}         ; Load 8 bytes
    stmia   r1!,{r2-r3}         ; Store 8 bytes
    ldrh    r2,[r0]             ; Load another 2 bytes
    strh    r2,[r1]             ; Store another 2 bytes
@@subr_end:
    pop     {r2-r7}
    ldr     r4,=#0x08014EDF
    bx      r4
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
    strb    r1,[r0,#0x12] ; 080669E4 pantheon subr 08067024 shooting (7) 08067068 state 8
    ;ldr     r0,=#0x02001000
    ;ldr     r1,=#0x02D01C
    ;add     r0,r0,r1
    ;mov     r1,#0x1
    ;strb    r1,[r0,#0x2]
    ;mov     r0,#0x1E
    ;mov     r1,#0x1D
    ;ldr     r2,=#0x083200A8
    ;bl      0x0800860C
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
    .endarea