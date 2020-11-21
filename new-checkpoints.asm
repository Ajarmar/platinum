
    .org REG_NEW_CHECKPOINTS
    .area REG_NEW_CHECKPOINTS_AREA
intro_chkpnt_4:
    .dw     0
    .dw     0x1C2500
    .dw     0x01BFFF
    .dw     0x0
panter_chkpnt_4:    ; This is actually the position before the perspective changes, but Zero needs some place to spawn
    .dw     0
    .dw     0x26B280
    .dw     0x013FFF
    .dw     0x1
poler_chkpnt_4:
    .dw     0
    .dw     0x24E87F
    .dw     0x01CFFF
    .dw     0x1
cmdroom_chkpnt_A:
    .dw     0
    .dw     0x0B6000
    .dw     0x012FFF
    .dw     0x1
cmdroom_chkpnt_B:
    .dw     0
    .dw     0x017780
    .dw     0x01CFFF
    .dw     0x0

    .endarea